{
Crear un procedimiento que reciba como parámetro el archivo del punto 2, y
genere un archivo de texto con el contenido del mismo.


2. Desarrollar un programa que permita la apertura de un archivo de números enteros
no ordenados. La información del archivo corresponde a la cantidad de votantes
de cada ciudad de la provincia de buenos aires en una elección presidencial.
Recorriendo el archivo una única vez, informe por pantalla la cantidad mínima y
máxima de votantes. Además durante el recorrido, el programa deberá listar el
contenido del archivo en pantalla. El nombre del archivo a procesar debe ser
proporcionado por el usuario.
}

program ejercicio4;
type
  archInt = file of integer;
procedure genTxtFromIntFile(var numArch:archInt;var txt:Text);
var
  buffer:integer;
begin
  while(not EOF(numArch)) do begin
     read(numArch,buffer);
     writeln(txt,buffer);
  end;
end;


var
  txtFile:Text;
  name:string;
  intFile:archInt;
begin
  writeln('Ingrese el nombre del archivo a abrir:');
  readln(name);
  Assign(intFile,name);
  writeln('Ingrese el nombre del archivo de texto a generar:');
  readln(name);
  Assign(txtFile,name);
  reset(intFile);
  rewrite(txtFile);
  genTxtFromIntFile(intFile,txtFile);
  closeFile(intFile);
  closeFile(txtFile);
end.
