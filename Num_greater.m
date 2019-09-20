function num=Num_greater(tau,mu,Num)
if nargin<3
    Num=Num_smaller(mu-1,mu);
end
    Num_next=zeros(tau-mu+1,1);
    Num=[Num;Num_next];
    
    for i=mu:tau
        sum_for_subst_1=0;
        for j=1:i
            sum_for_subst_1=sum_for_subst_1+nchoosek(2*j,j)*Num(i-j+1);
        end 
        sum_for_subst_2=0;
        for j=0:(i-mu)
            sum_for_subst_2=sum_for_subst_2+Num(j+1)*find_N(i-mu-j,mu);
        end
        Num(i+1)=nchoosek(2*i+mu,i)-sum_for_subst_1-sum_for_subst_2;
    end
    num=Num;
end