% Configuraciones de BuscaMat by JakoLarsen. Jun 2021

clear
if exist('Config.mat','file')
    load('Config.mat')
else 
    niv = 1;
    mn = 10;
end

disp(' ')
opt = 1;
while opt~=0
    disp([' 1 - Nivel: ' num2str(niv)])
    disp([' 2 - Num de minas: ' num2str(mn)])
    disp(' 0 - Salir')
    disp(' ')

    opt = input(' Elija una opcion: ');
    disp(' ')

    switch opt
        case 1 
            disp('El numero mostrado tiene en cuenta las minas en:')
            disp('  1. Solo los casilleros de los costados, arriba y abajo.')
            disp('  2. Solo los casilleros en diagonal.')
            disp('  3. Todos los casilleros que lo rodean.')
            disp(' ')
            niv = input(' Elije el nivel de juego: ');
            while (niv<1)||(niv>3)
                disp(' Ingresa un numero valido de nivel de juego')
                niv = input(' Elije el nivel de juego: ');
            end

        case 2
            mn = input(' Ingresa la cantidad de minas: ');
            while (mn<1)||(mn>99)
                disp(' La cantidad de minas tiene que ser mayor a cero y menor a 100')
                mn = input(' Ingresa la cantidad de minas: ');
            end
        case 0 
            save('Config.mat');
    end
end
clear
clc
