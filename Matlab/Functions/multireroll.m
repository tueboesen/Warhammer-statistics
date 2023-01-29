function [ppart]=multireroll(roll,idxs,target,dietype) 
%given a roll, it rerolls the idxs dices in that roll, and calculates how often this succeed
    ppart=0;
    s=0;
    n=size(idxs,2);
    allrolls=[];
    nrolls=dietype^n;
    for i=1:dietype %We recursively generate all rolls, with no degeneracy
      allrolls=dieroll(allrolls,i,n-1);
    end
    rerolls=repmat(roll,size(allrolls,1),1);
    rerolls(:,idxs)=allrolls;
    alldegen=zeros(length(allrolls),1); %We generate the degeneracy of all rolls
    for tt=1:length(alldegen)
      alldegen(tt)=degeneracy(allrolls(tt,:),n);
    end
    ppart=sum((sum(rerolls,2)>=target).*alldegen)/nrolls;
    
%   for i=1:n
%     for j=1:dietype      
%       roll(idxs(i))=j;        
%         roll(idxs(j))=j;        
%         s=sum(roll);
%         if s>=target
%             ppart=ppart+1/dietype^n;
%         end
%     end
end