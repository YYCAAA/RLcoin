close all
clear all
f=0.1;
R_plus=1;
R_minus=20;
alpha=1;
epsilon_0=0.3;
epsilon_1=0.02;
epsilon_n=0.01;
epsilon_f=0.005;
ratio_1=0.3;
ratio_2=0.5;
amp=100;

%% Get Analytical Solution
for mu=1:10
    ER_list(mu)=Expectation_of_Reward(mu,f,R_plus,R_minus,20);
end
E_R_max=max(ER_list)*amp;
%% Q-learning
for iter=[ 49999]

    Q=zeros(21,21,3); % 0 to 20
    step_size_para=zeros(21,21);
    Size=size(Q);
    Eva_Q=[];
    Epsilon=[];
for j=1:iter
    if j<=ratio_1*iter
        epsilon=epsilon_0+(epsilon_1-epsilon_0)*j/ratio_1/iter;
        if j==fix(ratio_1*iter)-1
            step_size_para=zeros(21,21);
        end
    elseif j<ratio_2*iter
        epsilon=epsilon_n*(iter-j)/iter/(1-ratio_1);
    else
        epsilon=max(0.01*(iter-j)/iter/(1-ratio_2),epsilon_f);
    end
%     epsilon=epsilon_0;
    coin=randi(2)-1;
    if coin==1
        S=[];
        S=[S;[0 0]];
        for i=1:Size(1)*Size(2)
            a=e_greedy(Q,S(end,:),epsilon);
            if ~isempty(find(S(end,:)>=20))
                [~,a_ind]=max(Q(S(end,1)+1,S(end,2)+1,2:3));
                a=a_ind+1;
            end
            if a~=1
                if (a-2)==coin
                    Reward=R_plus/max((length(S(:,1))-1),1)*amp;
                else
                    Reward=-R_minus/max((length(S(:,1))-1),1)*amp;
                end
                Q=update_Q(get_stepsize(alpha,S(end,:),step_size_para),Q,a,Reward,S(end,:));
                step_size_para(S(end,1)+1,S(end,2)+1)=step_size_para(S(end,1)+1,S(end,2)+1)+1;
                
                break
            else
                if binornd(1,1-f)
                    S=[S;S(end,:)+[1,0]];
                else
                    S=[S;S(end,:)+[0,1]];
                end
                Reward=0;
                Q=update_Q(get_stepsize(alpha,S(end-1,:),step_size_para),Q,a,Reward,S(end-1,:),S(end,:));
                step_size_para(S(end-1,1)+1,S(end-1,2)+1)=step_size_para(S(end-1,1)+1,S(end-1,2)+1)+1;

            end
        end
    else
        S=[];
        S=[S;[0 0]];
        for i=1:Size(1)*Size(2)
            a=e_greedy(Q,S(end,:),epsilon);
            if ~isempty(find(S(end,:)>=20))
                [~,a_ind]=max(Q(S(end,1)+1,S(end,2)+1,2:3));
                a=a_ind+1;
            end
            if a~=1
                if (a-2)==coin
                    Reward=R_plus/max((length(S(:,1))-1),1)*amp;
                else
                    Reward=-R_minus/max((length(S(:,1))-1),1)*amp;
                end
                Q=update_Q(get_stepsize(alpha,S(end,:),step_size_para),Q,a,Reward,S(end,:));
                step_size_para(S(end,1)+1,S(end,2)+1)=step_size_para(S(end,1)+1,S(end,2)+1)+1;
                break
            else
                if binornd(1,1-f)
                    S=[S;S(end,:)+[0,1]];
                else
                    S=[S;S(end,:)+[1,0]];
                end
                Reward=0;
                Q=update_Q(get_stepsize(alpha,S(end-1,:),step_size_para),Q,a,Reward,S(end-1,:),S(end,:));
                step_size_para(S(end-1,1)+1,S(end-1,2)+1)=step_size_para(S(end-1,1)+1,S(end-1,2)+1)+1;
            end
        end
    end
    %% Evaluate E(R) from greedy wrt. Q
    if  ~mod(j,2000)
        fprintf(['Current iter=' num2str(j) '\n'])  
        fprintf(['Current epsilon=' num2str(epsilon) '\n'])  
        Evaluated_average_reward=evaluate_Q(Q,f,R_plus,R_minus,10000);
        Eva_Q=[Eva_Q,Evaluated_average_reward];
        Epsilon=[Epsilon,epsilon];
    end
    
    
    
    
end




%% Comparison between Q and analytical
figure()
plot(1:2000:length(Eva_Q)*2000,Eva_Q,'linewidth',1.5)
hold on
plot(1:2000:length(Epsilon)*2000,Epsilon,'linewidth',1.0)
x_ax=1:2000:length(Eva_Q)*2000;
plot(x_ax,ones(length(x_ax))*E_R_max,'--','color','k','linewidth',1.5)
[maximum, ind]=max(Eva_Q);
plot((ind-1)*2000,maximum,'r*')
text((ind-1)*2000,maximum+0.1*amp,num2str(maximum))
text(0,E_R_max+0.1*amp,num2str(E_R_max))
xlabel('Iterations')
legend('Evaluated avg. Reward of Greedy Policy wrt. current Q','Exploration Rate','Analytical Maximum')
ylabel('E[R]')
title(['Comparison of results from Q-learning and analytical,',num2str(iter),' epsodes,f=',num2str(f)])
grid on
end