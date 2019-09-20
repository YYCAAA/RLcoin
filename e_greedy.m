function a=e_greedy(Q,S,epsilon)
    flag_exploit=binornd(1,1-epsilon);
    if flag_exploit                         %   greedy
        [m,a]=max(Q(S(1)+1,S(2)+1,:));
        all_a=find(Q(S(1)+1,S(2)+1,:)==m);
        if length(all_a)==2
            a=max(all_a);
        elseif length(all_a)==3
            a=1;
        end
    else                                    %   explore
        if binornd(1,epsilon)   
            a=1;
        else
            a=randi(2:3);
        end                                 
    end
end