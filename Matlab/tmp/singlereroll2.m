function [ppart,failrolls]=singlereroll2(roll,idx,target,dietype) 
%given a roll, it rerolls the idx die in that roll, and returns the combinations that fails to meeet the target 
    ppart=0;
    failrolls=[];
    s=0;
    for i=1:dietype
        roll(idx)=i;
        s=sum(roll);
        if s<target
            failrolls(end+1,:)=roll;
        else
            ppart=ppart+1/dietype;
        end
    end
end