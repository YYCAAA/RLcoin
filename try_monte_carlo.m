function [No,U] = try_monte_carlo(tau,mu,sample_number)

if nargin<3
    sample_number=1000;
end

lists=[];
for i=1:sample_number
    lists=[lists,Monte_carlo_num(tau,mu)];
end
U=unique(lists', 'rows')'

No=length(U(1,:));

end