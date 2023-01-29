function [ppart,failrolls]=singlereroll(roll,position,crit,dietype)
    ppart=0;
    failrolls=[];
    reroll=roll;
    s=0;
    for i=1:dietype+1
        reroll(position)=i;
        s=sum(reroll);
        if s<crit
            failrolls(end+1,:)=reroll;
        else
            ppart=ppart+1/dietype;
        end
    end
end