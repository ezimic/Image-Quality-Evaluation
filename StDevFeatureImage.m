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
function [sI,sCoN,sStD]=StDevFeatureImage(I,CoN,StD,IndF)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This matlab code compute the standard deviation of the features image extracted from a test image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INTPUT

% I - test image

% ConT - local contrast image

% StD - local standard deviation image

% IndF - indices of foreground pixels

% OUTTPUT

% sI - standard deviation of grayscale test image

% sConT - standard deviation of local contrast image

% sStD - standard deviation of local standard deviation image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compute the mean of grayscale test image

sI=std(I(IndF));

% Compute the mean of local contrast

sCoN=std(CoN(IndF));

% Compute the mean of local standard deviation

sStD=std(StD(IndF));