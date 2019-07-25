function X = linFeatures(S)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%X = [S(1); S(2)];
X = [1; S(1); S(2); S(1)*S(2)];

%X = [1; S(1); S(2); S(1)*S(2); S(1)^2; S(2)^2; S(1)*S(2)^2; S(1)^2 *S(2); S(1)^2 *S(2)^2];
%X = [1; S(1); S(2); S(1)*S(2); S(1)^2; S(2)^2; S(1)*S(2)^2; S(1)^2 *S(2); S(1)^2 *S(2)^2; S(1)^3; S(2)^3; S(1)*S(2)^3; S(1)^3 *S(2); S(1)^3 *S(2)^3];

 %S=[10 90];
%% Emulating a tabular representation 
% ser1 = [10 -15 -40 -65 -90];
% ser2 = [90 60 30 0 -30];
% 
% if S(1) == 10
%     idxS1 = 1;
% elseif S(1) == -15
%     idxS1 = 2; 
% elseif S(1) == -40
%     idxS1 = 3; 
% elseif S(1) == -65
%     idxS1 = 4; 
% else 
%     idxS1 = 5; 
% end
% 
% if S(2) == 90
%     idxS2 = 1;
% elseif S(2) == 60
%     idxS2 = 2; 
% elseif S(2) == 30
%     idxS2 = 3; 
% elseif S(2) == 0
%     idxS2 = 4; 
% else 
%     idxS2 = 5; 
% end
% 
% idxS1 = find(ser1 == S(1));
% idxS2 = find(ser2 == S(2));
% idxX = sub2ind([5,5], idxS1,idxS2);
% Xtemp = zeros(25,1) + 0* S(1)+0*S(2);
% Xtemp2 = zeros(25,1);
% Xtemp2(idxX) = 1;
% Xtemp(idxX) = 1;
% X = Xtemp + Xtemp2
end

