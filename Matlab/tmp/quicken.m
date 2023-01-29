clear all
close all
clc


n=100000

% 26/36

r=0;
target=7;
for i=1:n
    %standard
   a=randi(6,2,1);
  [mini,idx]=min(a);
  if (sum(a)>=target & sum(a)~=12)
     r=r+1;
  else
      a(idx)=randi(6);
      if (sum(a)>=target & sum(a)~=12)
        r=r+1;
      else
        if (sum(a)==12)
          mortal=randi(3,1);
          if (mortal==1)
            r=r+1;
          end
        end
      end
  end
end
result=r/n*100


r=0;
target=6;
for i=1:n
    %assuming +1
   a=randi(6,2,1);
  [mini,idx]=min(a);
  if (sum(a)>=target & sum(a)~=12)
     r=r+1;
  else
      a(idx)=randi(6);
      if (sum(a)>=target & sum(a)~=12)
        r=r+1;
      else
        if (sum(a)==12)
          mortal=randi(3,1);
          if (mortal==1)
            r=r+1;
          end
        end
      end
  end
end
result_plus_1=r/n*100


r=0;
target=6;    %assuming +1 and dobbel reroll

for i=1:n
   a=randi(6,2,1);
   if (sum(a)>=target)
     if (sum(a)==12)
       a(1)=randi(6);
       if(sum(a)==12)
         mortal=randi(3);
         if(mortal>1)
           continue
         end
       end
     end
     r=r+1;
     continue
   end
   if(a(1)<4)
       a(1)=randi(6);
   end
   if(a(2)<4)
       a(2)=randi(6);
   end
   if (sum(a)>=target)
     if (sum(a)==12)
       a(1)=randi(6);
       if(sum(a)==12)
         mortal=randi(3);
         if(mortal>1)
           continue
         end
       end
     end
     r=r+1;
     continue
   end   
end
result_dobbel_reroll=r/n*100


