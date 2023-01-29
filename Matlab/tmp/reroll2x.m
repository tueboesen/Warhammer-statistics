clear all 
close all
clc

r=0
n=100000
for i=1:n
%   clear a mini idx idx2
   a=randi(6,2,1);
  [mini,idx]=min(a);
  if (sum(a)>7)
     r=r+1;
  else
      a(idx)=randi(6);
      if(sum(a)>7)
          r=r+1;
      else
          idx2=idx+1;
          if(idx2>2)
              idx2=1;
          end
        a(idx2)=randi(6);
        if(sum(a)>7)
          r=r+1;
        end
      end
  end
end
result=r/n*100
