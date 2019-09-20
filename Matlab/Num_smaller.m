function num=Num_smaller(tau,mu)
    Num=zeros(tau+1,1);
    Num(1)=1;
    for i=1:tau
        sum_for_subst=0;
        for j=1:i
            sum_for_subst=sum_for_subst+nchoosek(2*j,j)*Num(i-j+1);
        end
        Num(i+1)=nchoosek(2*i+mu,i)-sum_for_subst;
    end
    num=Num;
end
