program ejercicio3;
uses
    sysUtils;
CONST
  VALORALTO = 99999;
  CANTDETALLES = 20;
type
  str15 = string[15];
  str40 = string[40];
  infoCalzado = record
    code:integer;
    num:integer;
    ventas:integer;
  end;

  infoMaestro = record
    code:integer;
    num:integer;
    descripcion:str40;
    price:float;
    color:str15;
    stock:integer;
    minStock:integer;
  end;
  maestro = file of infoMaestro;
  detalle = file of infoCalzado;
  arCalzado = array[1..CANTDETALLES] of infoCalzado;
  arDetalle = array[1..CANTDETALLES] of detalle;

Procedure Leer(var arch:detalle; var reg:infoDetalle);
begin
  if(not EOF(arch)) then
    read(arch,reg);
  else
    reg.code:= VALORALTO;
end;
Procedure minimo(var arD:arDetalle;var arC:arCalzado; var min: infoDetalle);
var
  i:integer; posMin:integer;
begin
  posMin := 1;
  min := arC[1];
  for i:= 2 to CANTDETALLES do
      if((arC[i].code < min.code)or ((arC[i].code = min.code) and (arC[i].num < min.num)))then begin
        min:= arC[i];
        posMin := i;
      end;
  Leer(arD[posMin],arC[posMin]);
end;

Procedure updateMaster(var m:maestro; var arD:arDetalle; sStock:text);
var
  i:integer; arC: arCalzado; regM:infoMaestro; min:infoDetalle;
begin
  reset(m);
  for i:= 1 to CANTDETALLES do begin
    reset(arD[i]);
    Leer(arD[i],arC[i]);
  end;
  minimo(arD,arC,min);
  regM.code := VALORALTO;
  while(min.code <> VALORALTO) do begin
    while((min.code <> regM.code) or (min.num <> regM.num)) do
      read(m,regM);
    while((min.code = regM.code) and (min.num = regM.num))do begin
      // Acumular las ventas de un calzado
      // Llamar a minimo
    end;
    // Verificar si no tuvo ventas el calzado
    // Verificar si el stock es menor que el minimo
    // Retroceder en el archivo maestro
    // Escribir regM en m


  end;
  // Cerrar archivos


end;

var
  m:maestro; arD:arDetalle; i:integer; sinStock:text;
begin
  Assign(m, 'maestro.dat');
  for i:= 1 to CANTDETALLES do
      Assign(arD[i],'detalle' + IntToStr(i) + '.dat');
  Assign(sinStock, 'calzadosinstock.txt');
  updateMaster(m,arD,sinStock);
end.

