%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  
%     IMAGE QUALITY EVALUATION IN CLINICAL RESEARCH: A CASE STUDY ON BRAIN AND CARDIAC MRI IMAGES IN MULTI-CENTER CLINICAL TRIALS
%                                                                     BY
%                               MICHAEL E. OSADEBEY, MARIUS PEDERSEN, DOUGLAS L. ARNOLD AND KATRINA WENDEL-MITORAJ
%
%                                                    ACCEPTED ON JULY 5 2018 FOR PUBLICATION IN 
%
%                                    IEEE JOURNAL OF TRANSLATIONAL ENGINEERING IN HEALTH AND MEDICINE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [mI,mCoN,mStD]=MeanFeatureImage(I,CoN,StD,IndF)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This matlab code compute the mean of the features images extracted from a test image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INTPUT

% I - test image

% ConT - local contrast image

% StD - local standard deviation image

% IndF - indices of foreground pixels

% OUTTPUT

% mI - mean of grayscale test image

% mConT - mean of local contrast image

% mStD - mean of local standard deviation image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compute the mean of grayscale test image

mI=mean(I(IndF));

% Compute the mean of local contrast

mCoN=mean(CoN(IndF));

% Compute the mean of local standard deviation

mStD=mean(StD(IndF));