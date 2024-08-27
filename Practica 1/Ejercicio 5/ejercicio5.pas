program ejercicio5;
const
  FIN = 'zzz';
  NOMBRE_TXT = 'flores.txt';
  NOMBRE = 'spicies.dat';
  MIN_INDEX = 1;
  MAX_INDEX = 2;
type


  str30 = string[30];
  spicies = record
    num:integer;
    maxHeight:float;
    sciName:str30;
    commonName:str30;
    color:str30;
  end;
  maxMinTot = record
    vec = array[1..2] of spicies;
    tot:integer;
  end;
  spiFile = file of spicies;
Procedure getTotMaxMin(var arch:spiFile; var reg:maxTotMin);
var
  aux:spicies;
begin
  Reset(arch);
  reg.vec[MIN_INDEX] := VALOR_ALTO;
  reg.vec[MAX_INDEX] := -VALOR_ALTO;
  reg.tot := 0;
  if(not EOF(arch)) then
     read(arch,aux);
  while(not EOF(arch)) do begin
     if(reg.vec[MIN_INDEX].maxHeight <= aux.maxHeight) then
        reg.vec[MIN_INDEX] := aux;
     if(reg.vec[MAX_INDEX].maxHeight >= aux.maxHeight) then
        reg.vec[MAX_INDEX] := aux;
     reg.tot := reg.tot + 1;
     read(arch,aux);
  end;
  close(arch);
end;

Procedure readReg(var reg:spicies);
begin
  writeln('Ingrese el nombre cientifico de la especie:');
  readln(reg.sciName);
  writeln('Ingrese el nombre vulgar de la especie:');
  readln(reg.commonName);
  writeln('Ingrese el numero de especie:');
  readln(reg.num);
  writeln('Ingrese el color:');
  readln(reg.color);
  writeln('Ingrese la altura maxima alcanzada:');
  readln(reg.maxHeight);
end;
Procedure printSpicies(reg:spicies);
begin
  writeln('La especie numero ',reg.num,', de nombre cientifico: ',reg.sciName,', de nombre vulgar: ',reg.commonName,', de color: ',reg.color,', de altura maxima',reg.maxHeight,'.');
end;

Procedure readFileSpicies(var arch:spiFile);
var
  reg:spicies;
begin
  rewrite(arch);
  readReg(reg);
  while(reg.sciName <> NOMBRE) do
    write(arch, reg);
  closeFile(arch);
end;

var
  arch:spiFile;
  option:integer;
  mtm:maxMinTot;
begin
  Assign(txtFile,NOMBRE_TXT)
  Assign(arch, name);
  readSpicies(arch);
  writeln('Ingrese una opcion [1-5]:');
  readln(option);
  while(option <> 0) do begin
    case option of
         1:begin
           getTotMaxMin(arch, mtm);
           writeln('Total de especies: ',mtm.tot,', minimo: ',mtm.vec[MIN_INDEX].maxHeight,', maximo: ',mtm.vec[MAX_INDEX].maxHeight );
         end;
         2:printSpiciesByLine(arch);
         3:changeRegister(arch);
         4:addSpicies(arch);
         5:createTxtByFile(arch,txtFile);
         else writeln('Opcion incorrecta.');
    end;
    writeln('Ingrese una opcion [1-5]:');
    readln(option);
  end;


end;
