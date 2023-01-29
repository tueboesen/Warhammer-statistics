function allroll = dieroll2(roll,nd) %Recursively rolls all dice combinations up to roll for nd+1 dices
if nd>0
  roll(end+1)=0;
  for i=1:roll(end-1)
      roll(end)=i;
      allroll=dieroll2(roll,nd-1);
  end
else
  if exist('allrolls','var')
    allroll(end+1,:)=roll;  
  else
    allroll=roll;        
  end
end
end