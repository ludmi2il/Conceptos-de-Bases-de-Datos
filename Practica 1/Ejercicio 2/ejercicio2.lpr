{
Desarrollar un programa que permita la apertura de un archivo de números enteros
no ordenados. La información del archivo corresponde a la cantidad de votantes
de cada ciudad de la provincia de buenos aires en una elección presidencial.
Recorriendo el archivo una única vez, informe por pantalla la cantidad mínima y
máxima de votantes. Además durante el recorrido, el programa deberá listar el
contenido del archivo en pantalla. El nombre del archivo a procesar debe ser
proporcionado por el usuario.
}
program ejercicio2;
type
  fileInt = file of integer;
  maxMinReg = record
    max:integer;
    min:integer;
  end;

procedure readFile(var arch: fileInt);
var
  num:integer; reg:maxMinReg;
begin
  reg.min := 32767;
  reg.max := -32767;
  reset(arch);
  seek(arch,0);
  while(not eof(arch))do
  begin
       read(arch,num);
       if(num <= reg.min)then
              reg.min := num;
       if(num >= reg.max)then
              reg.max := num;
       writeln(num);
  end;
  writeln;
  writeln('La cantidad maxima de habitantes es ',reg.min,' y la maxima es ',reg.max,'.');
  close(arch);
end;
var
  arch:fileInt;
  name:string[20];
begin
  readln(name);
  Assign(arch,name); // habitantes.dat
  readFile(arch);
  readln;
end.

