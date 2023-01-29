function allroll = dieroll(allroll,roll,nd) %Recursively rolls all dice combinations up to roll for nd+1 dices
if nd>0
  roll(end+1)=0;
  for i=1:roll(end-1)
      roll(end)=i;
      allroll=dieroll(allroll,roll,nd-1);
  end
else
  allroll(end+1,:)=roll;  
end
end