clear all
close all
clc


%First we find the probability of getting 8 or more with 3d6
%3d6 statistics
% r=0
% n=1000000
% for i=1:n
% %   clear a mini idx idx2
%    a=randi(6,3,1);
%   if (sum(a)>7)
%      r=r+1;
%   end
% end
% r1=r/n*100
r1 =83.7807;
%%
%Next we get the likelyhood of getting more than r1 for each individual die
%roll, so we can figure out when to use one method or the other.
r=zeros(3,3,3);
n=1000000
for i=1:3
 for j=1:3
  for k=1:3
   for m=1:n   
    a=[i;j;k];
    if (sum(a)>7)
     r(i,j,k)=r(i,j,k)+1;
     continue
    end
    [mini,idx]=min(a);
    a(idx)=randi(6);
    if(sum(a)>7)
     r(i,j,k)=r(i,j,k)+1;
     continue
    end
    b=a;
    b(idx)=7;
    [mini,idx2]=min(b);
    a(idx2)=randi(6);
    if(sum(a)>7)
     r(i,j,k)=r(i,j,k)+1;
     continue
    end
   end
  end 
 end
end
r=r./n.*100
% 
% r(:,:,1) =   [58.2070   72.3180   83.4180;
%    72.1340   75.1060   86.2540;
%    83.2750   86.1290   91.5550]
% 
% 
% r(:,:,2) =  [72.2720   75.0190   86.0910;
%    74.9300   75.0700   85.9070;
%    86.0570   86.1440  100.0000]
% 
% 
% r(:,:,3) =  [83.1610   86.0050   91.4510;
%    86.0450   86.2120  100.0000;
%    91.6600  100.0000  100.0000]

r2= floor(r./r1)

r3= ones(6,6,6)
r3(1:3,1:3,1:3)=r2
%%
%Now run the actual simulation
r4=0;
for m=1:n   
  a=randi(6,3,1);
  if (sum(a)>7)
    r4=r4+1;
    continue
  end
  %determine reroll process
  reroll2=r3(a(1),a(2),a(3));
  if reroll2 
    [mini,idx]=min(a);
    a(idx)=randi(6);
    if(sum(a)>7)
      r4=r4+1;
      continue
    end
    b=a;
    b(idx)=7;
    [mini,idx2]=min(b);
    a(idx2)=randi(6);
    if(sum(a)>7)
      r4=r4+1;
      continue
    end
  else
    a=randi(6,3,1);
    if (sum(a)>7)
      r4=r4+1;
      continue
    end
  end  
end
r4=r4/n*100

