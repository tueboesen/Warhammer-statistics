function ptot=independentrerolls(roll,numrerolls,target,dietype)
    nd=size(roll,2);
    ptot=1.0*(sum(roll)>=target);       
    rr=0;
    states=roll;
    newstates=[];
    while ((rr<min(numrerolls,nd)) && (ptot<1.0-1e-16))
        idx=nd-rr;
        n=size(states,1)
        for i=1:n
          [ppart,failrolls]=singlereroll(states(i,:),idx,target,dietype);
          ptot=ptot+1/dietype^(rr)*ppart;
          newstates=[newstates; failrolls];
          size(newstates)
        end
        rr=rr+1;
        states=newstates;
        newstates=[];
    end
end