
program ejercicio1;

{
Realizar un programa que permita crear un archivo conteniendo información de
nombres de materiales de construcción, el archivo no es ordenado. Efectúe la
declaración de tipos correspondiente y luego realice un programa que permita la
carga del archivo con datos ingresados por el usuario. El nombre del archivo debe
ser proporcionado por el usuario. La carga finaliza al procesar el nombre ‘cemento’
que debe incorporarse al archivo.
}
type
   cadena20 = string[20];
   strFile = file of cadena20;
procedure loadFile(var arch:strFile);
var
  aux: cadena20;
begin
  writeln('Ingrese el material de construccion:');
  readln(aux);
  while(aux <> 'cemento') do begin
      write(arch,aux);
      writeln('Ingrese el material de construccion:');
      readln(aux);
  end;
  write(arch,aux);
end;
var
  arch: strFile; name:cadena20;
begin
  writeln('Ingrese el nombre del archivo:');
  readln(name);
  Assign(arch,name);
  rewrite(arch);
  loadFile(arch);
  close(arch);
end.
