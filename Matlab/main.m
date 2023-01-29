clear all
close all
clc
addpath('./Functions/')  
dietype=6;
nd=3;
target=8;
nindependentrerolls=2;
nanyrerolls=1;
nrerollall=1;
allrolls=[];
nrolls=dietype^nd

allrolls=[];
for i=1:dietype %We recursively generate all rolls, with no degeneracy
    allrolls=dieroll(allrolls,i,nd-1);
end


alldegen=zeros(length(allrolls),1); %We generate the degeneracy of all rolls
for tt=1:length(alldegen)
    alldegen(tt)=degeneracy(allrolls(tt,:),nd);
end

independentrrprobs=zeros(length(allrolls),1); %independent reroll probabilities for all rolls
if nindependentrerolls>0
    for i=1:length(allrolls)
      independentrrprobs(i)=independentrerolls(allrolls(i,:),nindependentrerolls,target,dietype);
    end
end

anyrrprobs=zeros(length(allrolls),1); %any reroll probabilities for all rolls
dicetoreroll=zeros(length(allrolls),1); %number of dice you should reroll
if nanyrerolls>0
    for i=1:length(allrolls)
      allrolls(i,:)
      i
      [anyrrprobs(i) dicetoreroll(i)]=anyrerolls(allrolls(i,:),target,dietype);
    end
end

%Initial chance of success and also for a complete reroll
if (nrerollall>0)
  rerollallprob=sum((sum(allrolls,2)>=target).*alldegen)/nrolls;
else
  rerollallprob=zeros(length(allrolls),1);  
end

probs=max(independentrrprobs,max(rerollallprob,anyrrprobs));
rerollstrat=(independentrrprobs<rerollallprob);
totprob=sum(probs.*alldegen)/nrolls

Given a roll, what is the percentage using the different reroll strats
available
iroll=[6 5 1];
iroll=sort(iroll,'descend');
[C,ia,ib]=intersect(allrolls,iroll,'rows');
X = sprintf('reroll all= %d ',rerollallprob);
disp(X)
X = sprintf('independentrr all= %d ',independentrrprobs(ia));
disp(X)
X = sprintf('anyreroll= %d if you reroll %i dice',anyrrprobs(ia),dicetoreroll(ia));
disp(X)