# -*- coding: utf-8 -*-
"""
Created on Wed Aug  1 13:18:42 2018

@author: jkblock
"""

import pandas as pd
import WarhammerSumReroll as sumprob 
#(dietype,nd,crit,numfullrr,numsinglerr)
dietype=6
dfindex=range(2,19)
dfheaders=['2d6','2d6 1 FRR','2d6 1 SRR','2d6 2 SRR','3d6','3d6 1 FRR','3d6 1 SRR','3d6 1 FRR+1 SRR','3d6 2 SRR','3d6 1 FRR+2 SRR']
probtable=pd.DataFrame(data=None,index=dfindex,columns=dfheaders,dtype=float)

#Generate 2d6
numdie=2
for crit in dfindex:
    probtable.at[crit,'2d6']=sumprob.probabilitywithrerolls(dietype,numdie,crit,0,0)
    probtable.at[crit,'2d6 1 FRR']=sumprob.probabilitywithrerolls(dietype,numdie,crit,1,0)
    probtable.at[crit,'2d6 1 SRR']=sumprob.probabilitywithrerolls(dietype,numdie,crit,0,1)
    probtable.at[crit,'2d6 2 SRR']=sumprob.probabilitywithrerolls(dietype,numdie,crit,0,2)
    
numdie=3
for crit in dfindex:
    probtable.at[crit,'3d6']=sumprob.probabilitywithrerolls(dietype,numdie,crit,0,0)
    probtable.at[crit,'3d6 1 FRR']=sumprob.probabilitywithrerolls(dietype,numdie,crit,1,0)
    probtable.at[crit,'3d6 1 SRR']=sumprob.probabilitywithrerolls(dietype,numdie,crit,0,1)
    probtable.at[crit,'3d6 1 FRR+1 SRR']=sumprob.probabilitywithrerolls(dietype,numdie,crit,1,1)
    probtable.at[crit,'3d6 2 SRR']=sumprob.probabilitywithrerolls(dietype,numdie,crit,0,2)
    probtable.at[crit,'3d6 1 FRR+2 SRR']=sumprob.probabilitywithrerolls(dietype,numdie,crit,1,2)

print(probtable)
probtable.to_excel('WarhammerChargeChart.xlsx')