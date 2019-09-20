function [V,alpha]=update_V_TD_0(V,state,Reward,alpha)
num=(length(V)+1)/2;


for i=length(state):-1:1
    if i==length(state)
        V(state(i)+num)=(1-alpha)*V(state(i)+num)+alpha*Reward;
        alpha=1/(1/alpha+alpha^2*4);
    else
        V(state(i)+num)=(1-alpha)*V(state(i)+num)+alpha*V(state(i+1)+num);
        alpha=1/(1/alpha+alpha^2*4);
    end
    
    V(num)=(1-alpha)*V(num)+alpha*V(state(1)+num);
end
    
    

    