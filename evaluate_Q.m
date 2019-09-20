function [average_reward,S]=evaluate_Q(Q,f,R_plus,R_minus,iter)
    Size=size(Q);
    R=zeros(iter,1);
    amp=100;
    for j=1:iter
        coin=randi(2)-1;    
        if coin==1
            S=[];
            S=[S;[0 0]];
            for i=1:Size(1)*Size(2)
                a=e_greedy(Q,S(end,:),0);
                if ~isempty(find(S(end,:)>=20))
                    [~,a_ind]=max(Q(S(end,1)+1,S(end,2)+1,2:3));
                    a=a_ind+1;
                end
                if a~=1
                    if (a-2)==coin
                        Reward=R_plus/max((length(S(:,1))-1),1)*amp;
                    	R(j)=Reward;
                    else
                        Reward=-R_minus/max((length(S(:,1))-1),1)*amp;
                      	R(j)=Reward;
                    end
                    break
                else
                    if binornd(1,1-f)
                        S=[S;S(end,:)+[1,0]];
                    else
                        S=[S;S(end,:)+[0,1]];
                    end
                end
            end
        else
            S=[];
            S=[S;[0 0]];
            for i=1:Size(1)*Size(2)
                a=e_greedy(Q,S(end,:),0);
                if ~isempty(find(S(end,:)>=20))
                    [~,a_ind]=max(Q(S(end,1)+1,S(end,2)+1,2:3));
                    a=a_ind+1;
                end
                if a~=1
                    if (a-2)==coin
                        Reward=R_plus/max((length(S(:,1))-1),1)*amp;
                        R(j)=Reward;
                    else
                        Reward=-R_minus/max((length(S(:,1))-1),1)*amp;
                        R(j)=Reward;
                    end    
                    break
                else
                    if binornd(1,1-f)
                        S=[S;S(end,:)+[0,1]];
                    else
                        S=[S;S(end,:)+[1,0]];
                    end
                end 
            end 
        end
    end
    average_reward=mean(R)




end