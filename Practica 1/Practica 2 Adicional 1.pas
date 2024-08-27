program p2a1;
{
  Se desea actualizar un archivo maestro a partir de 500 archivos
  de detalle de votos de localidades.

  Cada archivo detalle contiene un código de provincia, código de
  localidad, cantidad de votos válidos, cantidad de votos en blanco
  y cantidad de votos anulados. El archivo se encuentra ordenado por
  código de provincia y código de localidad.

  El archivo maestro tiene código de provincia, código de localidad,
  cantidad de votos válidos, cantidad de votos en blanco y cantidad
  de votos anulados. El archivo se encuentra ordenado por código de
  provincia.

  Realizar la actualización de archivo maestro con la información de
  los archivos detalles. Además al final se debe informar en un
  archivo de texto denominado cantidad_votos_04_07_2023.txt la cantidad
  de archivos procesados, la cantidad de votos válidos, cantidad total
  de votos en blanco y cantidad total de votos anulados en los archivos
  detalles con el siguiente formato:

  Cantidad de archivos procesados: ___
  Cantidad total de votos: ___
  Cantidad de votos válidos: __
  Cantidad de votos anulados: __
  Cantidad de votos en blanco: __

  Se debe realizar el programa completo con sus declaraciones de tipo.
}

{$codepage utf8}
uses sysutils;

const
  ARCHIVOS = 500;
  FIN_PROVINCIA = High(byte);

type
  TRecuento = record
    codigoProvincia: byte;
    votosValidos: word;
    votosEnBlanco: word;
    votosAnulados: word;
  end;
  TVotos = record
    codigoProvincia: byte;
    codigoLocalidad: word;
    votosValidos: word;
    votosEnBlanco: word;
    votosAnulados: word;
  end;
  TArrVotos = array[1..ARCHIVOS] of TVotos;
  TMaestro = File of TRecuento;
  TDetalle = File of TVotos;
  TDetalles = array[1..ARCHIVOS] of TDetalle;

procedure Leer(var maestro: TMaestro; var recuento: TRecuento);
begin
  if not EOF(maestro) then Read(maestro, recuento)
  else recuento.codigoProvincia := FIN_PROVINCIA;
end;

procedure Leer(var detalle: TDetalle; var votos: TVotos);
begin
  if not EOF(detalle) then Read(detalle, votos)
  else votos.codigoProvincia := FIN_PROVINCIA;
end;

procedure Minimo(var detalles: TDetalles; var arrVotos: TArrVotos; var min: TVotos);
var
  i,j: integer;
begin
  i := 1;
  for j := 2 to ARCHIVOS do begin
    if arrVotos[j].codigoProvincia < arrVotos[i].codigoProvincia
    then i := j;
  end;
  min := arrVotos[i];
  Leer(detalles[i], arrVotos[i]);
end;

procedure Merge(var maestro: TMaestro; var detalles: TDetalles);
var
  i: integer;
  recuento: TRecuento;
  arrVotos: TArrVotos;
  min: TVotos;
  t_validos,t_blancos,t_anulados: cardinal;
  reporte: Text;
begin
  Reset(maestro);
  for i := 1 to ARCHIVOS do begin
    Reset(detalles[i]);
    Leer(detalles[i], arrVotos[i]);
  end;

  t_validos := 0;
  t_blancos := 0;
  t_anulados := 0;
  Leer(maestro, recuento);
  Minimo(detalles, arrVotos, min);
  while min.codigoProvincia < FIN_PROVINCIA do begin
    while recuento.codigoProvincia < min.codigoProvincia
    do Leer(maestro, recuento);

    while min.codigoProvincia = recuento.codigoProvincia do begin
      recuento.votosValidos := recuento.votosValidos + min.votosValidos;
      recuento.votosEnBlanco := recuento.votosEnBlanco + min.votosEnBlanco;
      recuento.votosAnulados := recuento.votosAnulados + min.votosAnulados;
      Minimo(detalles, arrVotos, min);
    end;

    t_validos := t_validos + recuento.votosValidos;
    t_blancos := t_blancos + recuento.votosEnBlanco;
    t_anulados := t_anulados + recuento.votosAnulados;
    Seek(maestro, FilePos(maestro)-1);
    Write(maestro, recuento);
  end;

  Close(maestro);
  for i := 1 to ARCHIVOS do Close(detalles[i]);

  Assign(reporte, 'cantidad_votos_04_07_2023.txt');
  Rewrite(reporte);
  WriteLn('Cantidad de archivos procesados: ', ARCHIVOS);
  WriteLn('Cantidad total de votos: ', t_validos + t_blancos + t_anulados);
  WriteLn('Cantidad de votos válidos: ', t_validos);
  WriteLn('Cantidad de votos anulados: ', t_anulados);
  WriteLn('Cantidad de votos en blanco: ', t_blancos);
  Close(reporte);
end;

var
  maestro: TMaestro;
  detalles: TDetalles;
  i: integer;
begin
  Assign(maestro, 'maestro.dat');
  for i := 1 to ARCHIVOS do Assign(detalles[i], 'detalle' + IntToStr(i) + '.dat');
  Merge(maestro, detalles);
end.