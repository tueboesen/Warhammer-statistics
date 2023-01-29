function resu = degeneracy(roll,nd)
[a,b] = histc(roll,unique(roll));
denom=1;
for num=a
    denom=denom*factorial(num);
end
resu=factorial(nd)/denom;
end