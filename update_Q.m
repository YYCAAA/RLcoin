function Q=update_Q(alpha,Q,a,R,S,S_next)
    gamma=1;
    if nargin<6
        theta=R-Q(S(1)+1,S(2)+1,a);
        Q(S(1)+1,S(2)+1,a)=alpha*theta;
    else
        theta=R+gamma*max(Q(S_next(1)+1,S_next(2)+1,:))-Q(S(1)+1,S(2)+1,a);
        Q(S(1)+1,S(2)+1,a)=alpha*theta;
    end
end

