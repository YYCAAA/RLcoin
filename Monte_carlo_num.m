function No=Monte_carlo_num(tau,mu)
path=randi(2)-1;
while(1)
    if abs(length(find(path==1))-length(find(path==0)))==mu
        break
    end
    
    if length(find(path==0))==tau
        path=[path;1];
        
    elseif (length(find(path==0))-length(find(path==1)))==(mu-1)
        path=[path;1];
    elseif length(find(path==1))-length(find(path==0))==(mu-1)
        path=[path;0];
    
    else
        if randi(2)-1==0
            path=[path;0];
        else
            path=[path;1];
        end
    end
    if length(find(path==0))==tau&&length(find(path==1))==tau+mu
        break
    end
    
end
No=path;
end