function [E,pmf]=Expectation_of_Reward(mu,f,R_plus,R_minus,iter,TYPE,c)
ER=0;   
pmf=[];
if TYPE==1
    for i=0:iter
    	ER=ER+No_of_Paths(i,mu)*(1-f)^i*f^i*((1-f)^mu*R_plus-f^mu*R_minus-((1-f)^mu+f^mu)*c*(2*i+mu));%/(2*i+mu); 
    end
else
    for i=0:iter
        ER=ER+No_of_Paths(i,mu)*(1-f)^i*f^i*((1-f)^mu*R_plus-f^mu*R_minus)/(2*i+mu); 
        pmf=[pmf,No_of_Paths(i,mu)*(1-f)^i*f^i*((1-f)^mu+f^mu)];
    end
end
E=ER;
end
