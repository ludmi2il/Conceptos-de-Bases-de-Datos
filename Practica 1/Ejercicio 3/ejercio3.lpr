{
Realizar un programa que permita crear un archivo de texto. El archivo se debe
cargar con la información ingresada mediante teclado. La información a cargar
representa los tipos de dinosaurios que habitaron en Sudamérica. La carga finaliza
al procesar el nombre ‘zzz’ que no debe incorporarse al archivo.
}
program ejercio3;

const
  FIN = 'zzz';
Procedure loadFile(var ar:Text);
var
  buffer:string;
begin
  writeln('Ingrese un nombre de un dinosaurio:');
  readln(buffer);
  while(buffer <> FIN) do begin
    writeln(ar,buffer);
    writeln('Ingrese un nombre de un dinosaurio:');
    readln(buffer);
  end;
end;

var
  arch: Text;
  name:string;
begin
  writeln('Ingrese el nombre del archivo (con terminacion .txt):');
  readln(name);
  Assign(arch,name);
  Rewrite(arch);
  loadFile(arch);
  closeFile(arch);

end.

