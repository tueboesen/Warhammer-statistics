function rolls = diereroll(rolls,idxs) %Recursively rerolls certain dices
if length(idxs)>0
  roll(end+1)=0;
  for i=1:roll(end-1)
      roll(end)=i;
      allroll=dieroll(allroll,roll,nd-1);
  end
else
  allroll(end+1,:)=roll;  
end
end