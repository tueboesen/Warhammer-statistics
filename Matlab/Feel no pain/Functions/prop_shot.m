function [prob]=prop_shot(p_in,hp,dmg,fnp,n,nc,kills_in,prob,p_all)
%Recursive function that calculates the returned hp probabilities from a single shot
%given an input hp value.
max_hp = size(prob,2);
p_cur = zeros(hp+1);
if nc == 0
    %We start by precalculating all possible probabilities, such that we
    %only have to calculate them once.
    p_all = zeros(max_hp+1,max_hp);
    for hpi = max_hp : -1 : 1
        for i = hpi : -1 : max(hpi-dmg,0)
            N = dmg;
            k = hpi-i;
            p_all(i+1,hpi) = fnp^(dmg-k)*(1-fnp)^k*nchoosek(N,k);
        end
        p_all(1,hpi) =1-sum(p_all(2:end,hpi)); %sum probabilities to 1, in case we have lower hp than dmg
    end
end

if nc < n %Still shots to do
    p_cur = p_in*p_all(max(1,hp-dmg):hp+1,hp);
    nc = nc+1;
    for i = 1:length(p_cur)
        if i == 1
            hp_c = max_hp;
            kills = kills_in+1;
        else
            hp_c = i-1;
            kills = kills_in;
        end
        if p_cur(i) > 0
            [prob]=prop_shot(p_cur(i),hp_c,dmg,fnp,n,nc,kills,prob,p_all);
        end
    end
else %reached the last shot, fill in p
    prob(kills_in+1,hp) = prob(kills_in+1,hp) + p_in;
end

end