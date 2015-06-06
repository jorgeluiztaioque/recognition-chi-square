%limpando variaveis e terminal.
%cleaning the variables and terminal
clear all;
close all;
clc;
 
%inicia contador de tempo
%start counter of time
tic;
 
%procura imagem inicial
%Search initial image
imagefiles = dir('*.pgm');      
nfiles = length(imagefiles);  
	forResult = zeros(1,nfiles);
	y = randi([1, nfiles]);
 
	for ii=1:nfiles
		if (ii == y)
		currentfilename = imagefiles(ii).name;
		inputImage = imread(currentfilename);
		images{ii} = inputImage;
		end
	end
 
 
		inputImage=inputImage;
		diferente = currentfilename;
 
%seta tamanho da janela de verificação
%set window size
windowSize=3;
 
inputImage=inputImage;
 
 
%executa função cesus
%execuit function cesus
[nr,nc] = size(inputImage);
 
bits=uint32(0);
 
res=uint32(zeros(nr,nc));
 
C= (windowSize-1)/2;
for(j=C+1:1:nc-C) 
	for(i=C+1:1:nr-C) 
	census = 0; 
		for (a=-C:1:C) 
			for (b=-C:1:C) 
				if (~(a==0 && b==0)) 
				census=bitshift(census,1); 
					if (inputImage(i+a,j+b) < inputImage(i,j))
					census=census+1;
					end
				end
			end
		end
	res(i,j) = census;
	end
end
 
 
 
%pega parametros da imagen para criar histograma
%get parameters of image to create histogram
larg = size(res,2) ;
alt  = size(res,1) ;
minimo = min(min(res)) ;
maximo = max(max(res)) ;
img_contraste = 255 * ( double(res - minimo) / double(maximo - minimo) );
 
histograma = zeros(1,256) ;
 
%criando histograma
%creating histegram
for i = 1 : alt
    for j = 1 : larg
        histograma(floor(img_contraste(i,j)+1)) = histograma(floor(img_contraste(i,j)+1)) + 1 ;
    end
end
 
	%calculando histograma
	%calculating histogram
	resultado1 = sum(histograma);
 
	%mostra resultados na janela figura
	%show results in window figure
	figure,
	subplot(2,3,1); plot(1:256,histograma,'-b');
	subplot(2,3,2); imshow(res,[0 128]);
	subplot(2,3,3); imshow(inputImage);
	drawnow 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%procura imagen canditada 
	%Search image candidate
	imagefiles = dir('*.pgm');      
	nfiles = length(imagefiles);  
 
	%Vector of results
	%Vetor de resultados
	forResult = zeros(1,nfiles);
	resultchi = 999999999999999;
 
	for ii=1:nfiles
 
	currentfilename = imagefiles(ii).name;
 
	z = strcmp( currentfilename, diferente );
	if (z==0)
 
	inputImage2 = imread(currentfilename);
	images{ii} = inputImage2;
 
 
windowSize=3;
 
inputImage2=inputImage2;
 
 
%executando função cesus
%running cesus function
[nr,nc] = size(inputImage2);
 
bits=uint32(0);
 
res2=uint32(zeros(nr,nc));
 
 
 
%creatingo histogram
C= (windowSize-1)/2;
for(j=C+1:1:nc-C) 
	for(i=C+1:1:nr-C) 
	census2 = 0; 
		for (a=-C:1:C) 
			for (b=-C:1:C) 
				if (~(a==0 && b==0)) 
				census2=bitshift(census2,1); 
					if (inputImage2(i+a,j+b) < inputImage2(i,j))
					census2=census2+1;
					end
				end
			end
		end
		%res = histogram
	res2(i,j) = census2;
	end
end
 
 
 
%pega parametros do fuzy para criar histograma
%get parameters of fuzy to create histogram
larg = size(res2,2) ;
alt  = size(res2,1) ;
minimo = min(min(res2)) ;
maximo = max(max(res2)) ;
img_contraste2 = 255 * ( double(res2 - minimo) / double(maximo - minimo) );
 
histograma2 = zeros(1,256) ;
 
%criando histograma
%creating histegram
for i = 1 : alt
    for j = 1 : larg
        histograma2(floor(img_contraste2(i,j)+1)) = histograma2(floor(img_contraste2(i,j)+1)) + 1 ;
    end
end
 
 
	%calculando chi-quadrado
	%calculating chi-square
	reschi = sum((histograma - histograma2).^2);
 
	%vetor para resultados do chi
	% Vector for results of chi
	forResult(ii) = reschi;
 
	%procura menor resultado do chi
	%search menor result of chi
	if ( reschi < resultchi )
	resultchi = reschi;
	reshistograma = histograma2;
	resresultado = res2;
	resimage = inputImage2;
	end 
 
 
 
	subplot(2,3,4); plot(1:256,histograma2,'-b');
	title('Histograma');
	subplot(2,3,5); imshow(res2,[0 128]);
	title('Trnas Census');
	subplot(2,3,6); imshow(inputImage2);
	title('Imagem Original');
	drawnow 
 
	end
end
	%mostra resultado
	%show result
	subplot(2,3,4); plot(1:256,reshistograma,'-b');
	title('RESULTADO');
	subplot(2,3,5); imshow(resresultado,[0 128]);
	title('RESULTADO');
	subplot(2,3,6); imshow(resimage);
	title('RESULTADO');
	drawnow 
 
 
 
%mostra tempo de procesamento
%show processing time
time=toc;
time
