program adicional2;
type
  cadena20 = string[20];
  profesional = record
    DNI: integer;
    nombre:cadena20;
    apellido:cadena20;
    sueldo:real;
  end;
  binArch = file of profesional;


Procedure crear(var arch: binArch; var info: text);
var
  p: profesional;
begin
     reset(info);
     rewrite(arch);
     {Como el primer registro del archivo binario corresponde a la cabecera, inicializo la cabecera en 0 y la escribo en el archivo.}
     p.dni := 0;
     write(arch, p);
     while (not eof(info)) do begin
       readln(info,p.DNI, p.sueldo, p.nombre);
       readln(info,p.apellido);
       write(arch,P);
     end;
     close(arch);
     close(info);
end;
Procedure agregar(var  arch: binArch; p:profesional);
var
  aux, c:profesional;
begin
     reset(arch);
     read(arch,c);
     if(c.dni <> 0) then begin
       seek(arch,- c.dni);
       read(arch,aux);
       seek(arch,0);
       write(arch, aux);
       seek(arch, -c.dni);
     end
     else
         seek(arch,filesize(arch));
     write(arch, p);
     close(arch);
end;
Procedure eliminar (var arch:binArch; DNI:integer; var bajas:text);
var
  p,c:profesional;
begin
     reset(arch);
     reset(bajas);
     read(arch,c);
     p.dni := -1;
     while((not EOF(arch)) and (p.DNI <> DNI)) do
       read(arch,p);
     if(p.dni = dni)then begin
       seek(arch, filepos(arch)-1);
       write(arch,c);
       c.dni := -(filepos(arch)-1);
       seek(arch,0);
       write(arch, c);
       writeln(bajas,p.DNI, p.sueldo, p.nombre);
       writeln(bajas,p.apellido);
     end
     else
        writeln('No se encontro el DNI a borrar');
     close(arch);
     close(bajas);
end;

begin
end.

