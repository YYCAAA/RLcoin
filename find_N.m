function [Nend,N]=find_N(n,mu)
N=zeros(n+1,1);
    N(1)=1;
    for i=1:n
%         subst=0;
%         for j=0:i-1
%             subst=subst+N(j+1)*nchoosek(2*i-2*j,i-j);
%         end
        N(i+1)=nchoosek(2*mu+2*i,i);
    end
Nend=N(end);
end

