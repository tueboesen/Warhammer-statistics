clear all
close all
clc

dietype=6;
nd=3;
target=8;
independentrerolls=2;
anyrerolls=1;
rerollall=1
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
for i=1:length(allrolls)
  independentrrprobs(i)=allsinglerr2(allrolls(i,:),independentrerolls,target,dietype);
end

%Initial chance of success and also for a complete reroll
startprob=sum((sum(allrolls,2)>=target).*alldegen)/nrolls;

if (rerollall==1)
   probs=max(independentrrprobs,startprob);
   rerollstrat=(independentrrprobs<startprob);
else
   probs=independentrrprobs; 
end
totprob=sum(probs.*alldegen)/nrolls


