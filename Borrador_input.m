%% STARTUO MENU


prompt = {'Cantidad de elementos','Animación de desplazamiento:','Time sweep modal y proporcional:','Modos rígidos:','Desplazamiento con peso en el techo:','Respuesta temporal:'};
titulo = 'Ingrese 1 para elegir las variables a evaluar';
dims = [1 35];
definput = {'2','0','0','0','0','1'};
answer = inputdlg(prompt,titulo,dims,definput);

nVig            = str2double(answer{1}) + 1;
sweepAnimado    = str2double(answer{2});
timeSweep       = str2double(answer{3});
modosRigidos    = str2double(answer{4});
despPeso        = str2double(answer{5});
rtaTemp         = str2double(answer{6});