function ptot=allsinglerr(roll,numrerolls,crit,dietype)
    ptot=1.0*(sum(roll)>=crit);       
    rr=0;
    states=roll;
    newstates=[];
    while ((rr<numrerolls) && (ptot<1.0-1e-16))
        for ind=1:length(states)
            [ppart,failrolls]=singlereroll(states(ind,:),numel(states(ind))-rr,crit,dietype)
            ptot=ptot+1/dietype^(rr)*ppart
            newstates=[newstates, failrolls];
        end
        rr=rr+1;
        states=newstates
        newstates=[]
    end
end
        
        