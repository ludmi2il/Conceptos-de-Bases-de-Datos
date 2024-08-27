program ejercicio1;
const
     valorAlto = 999999;
uses SysUtils;
type

  {código de empleado, la fecha y
la cantidad de días de licencia solicitadas.}
  cadena20 = string[20];
  infoDetalle = record
    cod:integer;
    fecha:cadena20;
    diasLic:integer;
  end;
  detalle = file of infoDetalle;
  vecDetalle = array [1..10] of infoDetalle;
  arDetalle = array[1..10] of detalle;
  empleado = record
    cod:integer;
    nameSur:cadena20;
    birthDate:cadena20;
    address:cadena20;
    children:integer;
    phone:integer;
    vacDays:integer;
  end;


  maestro = file of empleado;

Procedure leer(var fDet:detalle; var reg:infoDetalle);
begin
    if(not EOF(fDet)) then
      read(fDet,reg)
    else
      reg.cod := valorAlto;
end;
Procedure minimo(var aReg:vecDetalle;var arDet:arDetalle; var min:infoDetalle);
var
  i, posMin:integer;
begin
  posMin := 1;
  min.cod := aReg[1];
  for i := 2 to 10 do
      if(min.cod < aReg[i].cod) then begin
        posMin := i;
        min := aReg[i];
      end;
  Leer(arDet[posMin],aReg[posMin]);
end;

Procedure masterUpdate(var master:maestro; var arFile:arDetalle);
var
  arReg:vecDetalle; i:integer; min:infoDetalle; regM: empleado;
  dias, disponibles:integer;
  informe:string;
begin
  append(requests);
  reset(master);
  for i:= 1 to 10 do begin
    reset(arFile[i]);
    Leer(arFile[i],arReg[i]);
  end;
  minimo(arReg,arFile,min);
  regM.cod := valorAlto;
  while(min.cod <> valorAlto) do begin
    while(min.cod <> regM.cod) do
      read(master,regM);
    {No se puede repetir el mismo empleado en distintos archivos detalles}
    if(regM.vacDays < min.diasLic) then begin
      informe := 'Codigo de empleado: ',regM.cod,', Nombre y Apellido:', regM.nameSur,', Dias disponibles: ',regM.vacDays,', Dias solicitados:',min.diasLic;
      writeln(requests,informe);
    end;

  end;

  while(not fin)
  close(master);
  for i := 1 to 10 do
      close(arFile[i]);
end;


var
  archName:cadena20; master:maestro; vectorDetalle:arDetalle; requests:text;
begin
  readln(archName);
  Assign(master,archName);
  readln(archName);
  Assign(archName, requests);
  for i:= 1 to 10 do begin
    Assign(vectorDetalle[i], 'detalle' + IntToStr(i) + '.dat');
  end;
  masterUpdate(master, vectorDetalle);

end.

