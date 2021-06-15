% BuscaMat es la version del buscaminas para Matlab.
%   By JakoLarsen. 
% Creado por alla en el 2018, revisado en jun 2021 para subir a GitHub
% Instrucciones:
%  - Abre todos los casilleros sin pisar ninguna mina.
%  - Se abre un casillero ingresando la letra correspondiente
%a la columna y luego el numero de fila (ejemplo: 'a7','F10'). 
%  - Si el casillero contiene una mina aparecera una 'X' y finalizara
%el juego. Si no contiene una mina aparecera un numero indicando cuantas
%minas hay en los casilleros adyacentes.
% - Ingresa una 'm' luego de la ubicacion, para marcar los casilleros
%donde consideres que hay minas (ejemplo: 'f6m').
% - Puedes configurar algunos parametros del juego ingresando 'config'


%% --- Configuracion del juego ---
if exist('Config.mat','file')
    load('Config.mat')
else 
    niv = 1;
    mn = 10;
end

if exist('state','var')==0 %variable con info de un juego en curso
    
    tic
 
    aux = -1;
    MShow = char.empty(10,10,0);

    for i=1:10
        for j=1:10 
            MShow(i,j,1) = '-'; % pantalla base
        end
    end
    
    mine = zeros(2,mn); % ubicacion de minas
    % 1 fila: num de fila
    % 2 fila: num de columna
    for i=1:2
        for j=1:mn
            mine(i,j) = randi(10);
        end
    end 
    valido = 0;
    % verificion de que no haya 2 minas en el mismo lugar
    while valido==0
        valido = 1;
        for i=1:mn
            for j=1:mn
                if i~=j
                    if (mine(1,i)==mine(1,j))&&(mine(2,i)==mine(2,j))
                        valido = 0;
                        mine(1,i) = randi(10);
                        mine(2,i) = randi(10);
                    end
                end
            end
        end
    end

% matriz de contenidos
    MS = MShow;
    
    for i=1:mn
        MS(mine(1,i),mine(2,i)) = 'X';
    end
    for i=1:10
        for j=1:10
            if strcmp(MS(i,j),'X')==0
                n = 0;
                if (niv==1)||(niv==3)
                if i>1
                    m = MS(i-1,j);
                    if strcmp(m,'X')
                        n = n+1;
                    end
                end
                if i<10
                    m = MS(i+1,j);
                    if strcmp(m,'X')
                        n = n+1;
                    end
                end
                if j>1
                    m = MS(i,j-1);
                    if strcmp(m,'X')
                        n = n+1;
                    end
                end
                if j<10
                    m = MS(i,j+1);
                    if strcmp(m,'X')
                        n = n+1;
                    end
                end
                end
                if (niv==2)||(niv==3)
                if (i>1)&&(j>1)
                    m = MS(i-1,j-1);
                    if strcmp(m,'X')
                        n = n+1;
                    end
                end
                if (i>1)&&(j<10)
                    m = MS(i-1,j+1);
                    if strcmp(m,'X')
                        n = n+1;
                    end
                end
                if (i<10)&&(j>1)
                    m = MS(i+1,j-1);
                    if strcmp(m,'X')
                        n = n+1;
                    end
                end
                if (i<10)&&(j<10)
                    m = MS(i+1,j+1);
                    if strcmp(m,'X')
                        n = n+1;
                    end
                end
                end
                MS(i,j) = num2str(n);
            end
        end
    end

    clear i j n m valido
    state = 'Playing';

end

%% --- Inicio del juego ---
clc
disp(' ')
disp('                         BuscaMat')
disp(' ')
T = table((1:10)',MShow(:,1,1),MShow(:,2,1),MShow(:,3,1),MShow(:,4,1),MShow(:,5,1),MShow(:,6,1),MShow(:,7,1),MShow(:,8,1),MShow(:,9,1),MShow(:,10,1),'VariableNames',{'MS' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J'});
disp(T)


validloc = 0;
disp(' ')
disp('Instrucciones:')
disp(' -Ingresa una ubicacion para descubrir el valor indicado')
disp(' -Ingresa una "m" seguido a la ubicacion para indicar las')
disp('posibles minas encontradas')
disp(' -Ingresa "EndGame" para salir del juego')
while validloc==0
disp(' ')
loc = input('Ingresa una ubicacion: ','s');

err = loc(end);

if (strcmp(loc(end),'m'))||(strcmp(loc(end),'M'))
    m = 1;
    n = length(loc)-1;
else
    m = 0;
    n = length(loc);
end

c = loc(1);
f = loc(2:n); 
f = str2num(f);

switch c
    case {'A','a'}
        c = 1;
    case {'B','b'}
        c = 2;
    case {'C','c'}
        c = 3;
    case {'D','d'}
        c = 4;
    case {'E','e'}
        c = 5;
    case {'F','f'}
        c = 6;
    case {'G','g'}
        c = 7;
    case {'H','h'}
        c = 8;
    case {'I','i'}
        c = 9;
    case {'J','j'}
        c = 10;
end

try
    if m==0
        MShow(f,c) = MS(f,c);
    else 
        MShow(f,c) = 'm';
    end
    validloc = 1;
    if strcmp(loc,'EndGame')
        state = 'ExitGame';
    end
catch
   validloc = 0;
    if strcmp(loc,'EndGame')
        validloc = 1;
        state = 'ExitGame';
    else
       clc
       disp(' ')
       disp('                         BuscaMat')
       disp(' ')
       T = table((1:10)',MShow(:,1,1),MShow(:,2,1),MShow(:,3,1),MShow(:,4,1),MShow(:,5,1),MShow(:,6,1),MShow(:,7,1),MShow(:,8,1),MShow(:,9,1),MShow(:,10,1),'VariableNames',{'MS' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J'});
       disp(T)
       disp(' ')
       disp('Ubicacion incorrecta')     
    end
end

end



cont = 0;
cont2 = 0;
for i=1:10
    for j=1:10
        if strcmp(MShow(i,j),'-')
            cont = cont+1;
        end
        if strcmp(MShow(i,j),'m')
            if strcmp(MS(i,j),'X')
                cont = cont+1;
                cont2 = cont2+1;
            end
        end
    end
end

if (cont==mn)||(cont2==mn)
    state = 'Win';
end

if strcmp(MShow(f,c),'X')
    state = 'Finished';
end

switch state
    case 'Playing'
        buscamat;
    
    case {'Finished','Win'}
        clc
        disp(' ')
        disp('                         BuscaMat')
        disp(' ')
        T = table((1:10)',MS(:,1,1),MS(:,2,1),MS(:,3,1),MS(:,4,1),MS(:,5,1),MS(:,6,1),MS(:,7,1),MS(:,8,1),MS(:,9,1),MS(:,10,1),'VariableNames',{'MS' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J'});
        disp(T)
        disp(' ')
        if strcmp(state,'Finished')
            disp('                       Juego Terminado')
        else
            disp('                         ¡Has ganado!')
        end
        time = toc;
        disp(' ¡Gracias por jugar BuscaMat!')
        disp(['Tiempo transcurrido: ' char(duration(0,0,time,'Format','mm:ss')) ' min'])
        disp(' ')
        ng = input('¿Desea iniciar un nuevo juego? [1 0]: ');
        switch ng
            case 1
                clear
                buscamat;
            otherwise
                clear
        end
    case 'ExitGame'
        clc
        clear
        disp(' ¡Gracias por jugar BuscaMat!')
end
