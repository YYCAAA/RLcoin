function No=No_of_Paths(tau,mu)
    if tau<mu
        num=Num_smaller(tau,mu);
    end
    if tau>=mu
        num=Num_greater(tau,mu,Num_smaller(mu-1,mu));
    end
    No=num(end);
end