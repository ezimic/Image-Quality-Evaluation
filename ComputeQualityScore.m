%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  
%     IMAGE QUALITY EVALUATION IN CLINICAL RESEARCH: A CASE STUDY ON BRAIN AND CARDIAC MRI IMAGES IN MULTI-CENTER CLINICAL TRIALS
%                                                                BY
%                       MICHAEL E. OSADEBEY, MARIUS PEDERSEN, DOUGLAS L. ARNOLD AND KATRINA WENDEL-MITORAJ
%
%                                                  ACCEPTED ON JULY 5 2018 FOR PUBLICATION IN 
%
%                               IEEE JOURNAL OF TRANSLATIONAL ENGINEERING IN HEALTH AND MEDICINE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This matlab code computes the quality score of a slice in a MRI volume data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Clear variables from the workspace

clear 

clear all

clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SYSTEM INPUT PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Size of kernel for extracting local feature image

nhood = true(7);

% Threshold for eliminating small regions during foreground extraction

thA=800;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% READ IN THE TEST IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[FileName, FilePath] = uigetfile('*.dcm','Select minc file');

filename = [FilePath,FileName];

Itest1=dicomread(filename);

figure(1),

imshow(Itest1,[])

%Read the image

figure(1),

imshow(Itest1,[])

% Print figure

set(gcf,'PaperPositionMode','manual')
print('-depsc','-r600','TESTSLICE')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXTRACT FOREGROUND FROM THE TEST IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Iff,IndF,nF]=ExtractForeground(Itest1,thA);

% Display the foreground image

figure(2),

imshow(Iff,[])

% Print figure

set(gcf,'PaperPositionMode','manual')
print('-depsc','-r600','FOREGROUND')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RESCALE THE TEST IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Rescale the pixel intensity levels of the test image 
% to lie between 0 and 1

NewMin=0;

NewMax=1;

Itest0=RescaleIntensityLevel(Itest1,NewMin,NewMax);

% Display the rescaled test image

figure(3),

imshow(Itest0,[])

% Print figure

set(gcf,'PaperPositionMode','auto')
print('-depsc','-r600','manual')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXTRACT LOCAL FEATURE IMAGES FROM THE TEST IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

[CoN0,StD0]=ExtractFeatureImage(Itest0,nhood);

% Display the local contrast feature image

figure(4),

imshow(CoN0,[])

% Print figure

set(gcf,'PaperPositionMode','manual')
print('-depsc','-r600','CONTRASTFEATURE')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPUTE THE MEAN OF THE LOCAL FEATURE IMAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

[mI0,mCoN0,mStD0]=MeanFeatureImage(Itest0,CoN0,StD0,IndF);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPUTE THE STANDARD DEVIATION OF THE LOCAL FEATURE IMAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

[sI0,sCoN0,sStD0]=StDevFeatureImage(Itest0,CoN0,StD0,IndF);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPUTE NORMAL CUMUMLATIVE DISTRIBUTION FUNCTION OF NORMAL DISTRIBUTION
% CENTERED ON THE STANDARD DEVIATION OF THE TEST IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Estimate the standard deviation using three sigmal rule

[EsigS]=ThreeSigmaRule(sI0);

% Normal cumulative distribution function

PsigS=normcdf(sCoN0,sI0,EsigS);

% Lightness contrast quality score

Q1=PsigS;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPUTE NORMAL CUMUMLATIVE DISTRIBUTION FUNCTION OF NORMAL DISTRIBUTION
% CENTERED ON THE MEAN OF THE TEST IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Estimate the standard deviation using three sigma rule

[EsigM]=ThreeSigmaRule(mI0);

% Normal cumulative distribution function

PsigM=normcdf(mCoN0,mI0,EsigM);

% Initial sharpness quality score

q2=PsigM;

% One-tailed cumulative probability density of the Z-score in a standard
% Gaussian distribution

 if ( q2 <= 0.5)
      
     Q2=q2*2;
      
  else
      
     Q2=abs(1 - q2)*2; 
     
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOTAL CONTRAST QUALITY SCORE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Total quality score-

QT=mI0*Q1 + (1 - mI0)*Q2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAPHICAL PLOT - LIGHTNESS CONTRAST QUALITY SCORE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

QT1 = [sI0;sCoN0;EsigS];

str = {'sI0'; 'sCI'; 'SQs'};

figure(5),

bar(QT1)
ylabel('MAGNITUDE');

set(gca, 'XTickLabel',str, 'XTick',1:numel(str))

% Print figure

set(gcf,'PaperPositionMode','auto')
print('-depsc','-r600','manual')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAPHICAL PLOT - SHARPNESS QUALITY SCORE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

QT2 = [mI0;mCoN0;EsigM];

str = {'mI0'; 'mCi'; 'SQm'};

figure(6),

bar(QT2)
ylabel('MAGNITUDE');

set(gca, 'XTickLabel',str, 'XTick',1:numel(str))

% Print figure

set(gcf,'PaperPositionMode','auto')
print('-depsc','-r600','SHARPNESSBAR')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAPHICAL PLOT - QUALITY SCORE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

QTT=[Q1;Q2;QT]';

str = {'LIGHTNESS CONTRAST'; 'TEXTURE CONT'; 'TOTAL QUALITY'};

figure(7),

bar(QTT);
ylabel('QUALITY SCORE');

set(gca, 'XTickLabel',str, 'XTick',1:numel(str))

ylim([0 1])

% Print figure

set(gcf,'PaperPositionMode','auto')
print('-depsc','-r600','DEMOBAR')