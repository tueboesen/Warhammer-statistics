# -*- coding: utf-8 -*-
"""
Created on Tue Jul 31 12:58:04 2018

@author: jkblock
Currently support for
nd=2-3
numfullrr=0-1
numsingler=0-inf

"""

import numpy as np
from math import factorial
def probabilitywithrerolls(dietype,nd,crit,numfullrr,numsinglerr):
    #nd=3
    #dietype=6
    #crit=8
    #numsinglerr=2
    #numfullrr=1
    
    def singlereroll(roll,position,crit,dietype): #list,int,int,int
        ppart=0.
        failrolls=[]
        reroll=roll.copy()
        s=0
        for i in range(1,dietype+1):
            reroll[position]=i
            s=sum(reroll)
            if s<crit:
                failrolls.append(reroll.copy()) #Copy the current value instead of inserting a ref
            else:
                ppart+=1/dietype
        return ppart, failrolls
            
    def allsinglerr(roll,numsinglerr,crit,dietype): #Roll: Ordered array
        ptot=1.0*(sum(roll)>=crit)       
        rr=0
        states=[roll.copy()]
        newstates=[]
        while rr<numsinglerr and ptot<1.0-dietype*np.finfo(float).eps:
            #print('Reroll number'+str(rr))
            #print(states)
            for ind in range(len(states)):
                (ppart,failrolls)=singlereroll(states[ind],states[ind].size-1-rr,crit,dietype)
                ptot+=1/dietype**(rr)*ppart
                newstates.extend(failrolls.copy())
            rr+=1
            states=newstates.copy()
            newstates=[]
        return ptot
    
    def degeneracy(roll,nd):
        (uniqrolls,counts)=np.unique(roll,return_counts=True)
        denom=1
        for num in counts:
            denom=denom*factorial(num)
        return factorial(nd)/denom
        
    nrolls=dietype**nd
    #
    #Generate states for any number of dies
    #
    #First quick and dirty for nd=3 and 2
    allrolls=[]
    if nd==3:
        for i in range(dietype,0,-1):
            for j in range(i,0,-1):
                for k in range(j,0,-1):
                    allrolls.append(np.array([i,j,k]))
    elif nd==2:
       for i in range(dietype,0,-1):
           for j in range(i,0,-1):
               allrolls.append(np.array([i,j]))
    
    #Test degeneracy
    testrollsum=0
    alldegen=np.zeros(len(allrolls))
    for ind in range(len(allrolls)):
        alldegen[ind]=degeneracy(allrolls[ind],nd)
        testrollsum+=alldegen[ind]
    if not abs(testrollsum-nrolls)<1:
        print('Error: The total number of rolls is ' +str(testrollsum)+' expected '+str(nrolls))
    #print('The total number of unique rolls is ' +str(len(allrolls)))
    #print('The total number of rolls is ' +str(testrollsum)+' expected '+str(nrolls))
    
    
    #
    #Could more than one total reroll and check if better chance
    #
    
    allprob=np.zeros(len(allrolls))
    pfullrr=0
    for i in range(len(allrolls)):
        if sum(allrolls[i])>=crit:
            pfullrr+=degeneracy(allrolls[i],nd)
    pfullrr=pfullrr/nrolls
    
    fullrrstrategy=np.zeros(len(allrolls))
    for i in range(len(allrolls)):
        psinglerr=allsinglerr(allrolls[i],numsinglerr,crit,dietype)
        if psinglerr<pfullrr and numfullrr==1:
            allprob[i]=pfullrr
            fullrrstrategy[i]=1
        else:
            allprob[i]=psinglerr            
        
    totprob=sum(allprob*alldegen)/nrolls
    #print('The total probability for getting at least '+str(crit)+' using '+str(nd)+' '+str(dietype)+'-sided die \n with '+str(numsinglerr)+' single die reroll(s) and ' +str(numfullrr)+' full die reroll(s) is: '+str(totprob))
    #print('For these rolls, a full reroll is strictly better than the single die reroll(s):')
#    for i in range(len(allrolls)):
#        if fullrrstrategy[i]==1:
#            print(allrolls[i])
    
    return totprob        
