function [ptot,dicetoreroll]=anyrerolls(roll,target,dietype)
    nd=size(roll,2);
    dicetoreroll=0;
    ptot=1.0*(sum(roll)>=target);       
    idxs=[];
    old_prob=0;
    if (ptot<1.0-1e-16)
      for i=1:nd %number of dice to reroll
        idxs=[idxs nd-i+1];
        [ppart]=multireroll(roll,idxs,target,dietype);
        if ppart>=old_prob
          dicetoreroll=i
          old_prob=ppart;
        else
          break  
        end
      end
      ptot=old_prob;
    end
end