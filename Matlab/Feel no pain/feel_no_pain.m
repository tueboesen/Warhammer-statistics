%This program calculates the probability of killing feel no pain units
clear all
close all
clc
addpath('./Functions')

%Set the following parameters
n=19 %number of shots
dmg = 2 %dmg per shot
hp = 2 %hp of each model
fnp = 1/3 %chance of feel no pain
tol = 0 % The tolerance for how accurate the calculation is, if 0 it is exact, if negative it is adaptive.


%% Program start

prob = zeros(n+1,hp); %Stores all the output probabilities
kills = 0; %kill counter
nc = 0; %current shot
tic
[prob,tol]=prop_shot_v2(1,hp,dmg,fnp,n,nc,kills,prob,tol);
toc
tol
for i = 1:n+1
    rownames{i} = num2str(i-1);
end
for i = 1:hp
    colnames{i} =  sprintf('Hp_%i',i);   
end
Probabilities = array2table(prob);
Probabilities.Properties.RowNames = rownames;
Probabilities.Properties.VariableNames(1:hp) = colnames

cprob = sum(cumsum(prob,'reverse'),2);

CumProbabilities = array2table(cprob);
CumProbabilities.Properties.RowNames = rownames;
CumProbabilities.Properties.VariableNames(1) = {'CumProbability'}
