%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  
%     IMAGE QUALITY EVALUATION IN CLINICAL RESEARCH: A CASE STUDY ON BRAIN AND CARDIAC MRI IMAGES IN MULTI-CENTER CLINICAL TRIALS
%                                                                      BY
%                            MICHAEL E. OSADEBEY, MARIUS PEDERSEN, DOUGLAS L. ARNOLD AND KATRINA WENDEL-MITORAJ
%
%                                                    ACCEPTED ON JULY 5 2018 FOR PUBLICATION IN 
%
%                                          IEEE JOURNAL OF TRANSLATIONAL ENGINEERING IN HEALTH AND MEDICINE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Iff,IndF,nF]=ExtractForeground(I,th)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This matlab code extracts foreground of the test MRI image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INPUT

% I  - test image

% th - threshold for removing small regions

% OUTPUT

% Iff  - foreground mage

% nF - total number of pixels in the foreground 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONVERT TEST IMAGE TO BINARY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Threshold the test image

mu_t=mean(mean(I));

% Binarize the image

ItO=(I > (mu_t));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXTRACT FOREGROUND PIXELS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fill image regions and holes

indff= imfill(ItO,'holes');  

% Find connected components in binary image

cc = bwconncomp(indff);

% Measure area region property

stats = regionprops(cc, 'Area');

% Threshold the area size

idx = find(([stats.Area]) > th);

% Remove the small region if there are more than one region greater than the threshold

if (numel(idx)) > 1
    
idx=find([stats.Area]== max([stats.Area]));

else
     
 idx = find(([stats.Area]) > th);
 
end

Iff = ismember(labelmatrix(cc), idx);

% Find indices of nonzeo pixels

IndF=find(Iff);

% Compute the total number of elements in the foreground

nF=numel(IndF);