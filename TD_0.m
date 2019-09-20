close all
clear all
f=0.4;
R_plus=1;
R_minus=20;
alpha_0=0.25;
alpha_1=0.4;
for mu=1:10
    ER_list(mu)=Expectation_of_Reward(mu,f,R_plus,R_minus,20);
end

for iter=[10,50,100,500,1000,3000]

% iter=16000;%Trials or Episodes

Mean_R=[];
V_TD_0=[];
V_list={};
v_TD_0=[];


for mu=1:10
alpha=alpha_0;%Initial step size
V=zeros(2*mu+1,1);   
v=0;

R=zeros(iter,1);
for j=1:iter
coin=randi(2)-1;    % coin=1, H type; coin=0, T type
traj=[];
state=[];
if coin==1
    for i=1:100
        if abs(length(find(traj==0))-length(find(traj==1)))>=mu
            break
        end
        traj=[traj;binornd(1,1-f)];
        state=[state;length(find(traj==1))-length(find(traj==0))];
    end
    if length(find(traj==1))-length(find(traj==0))>0
        Reward=R_plus/length(traj);
    else
        Reward=-R_minus/length(traj);
    end
    R(j)=Reward;
    [V,alpha]=update_V_TD_0(V,state,Reward,alpha);
    v=alpha_1*Reward+(1-alpha_1)*v;
    alpha_1=1/(1/alpha_1+alpha_1);
else
    for i=1:100
    if abs(length(find(traj==0))-length(find(traj==1)))>=mu
        break
    end
        traj=[traj;binornd(1,f)];    
        state=[state;length(find(traj==1))-length(find(traj==0))];
    end
    if length(find(traj==0))-length(find(traj==1))>0
        Reward=R_plus/length(traj);
    else
        Reward=-R_minus/length(traj);
    end
    R(j)=Reward;
    [V,alpha]=update_V_TD_0(V,state,Reward,alpha);
    v=alpha_1*Reward+(1-alpha_1)*v;
    alpha_1=1/(1/alpha_1+alpha_1);
end

end
fprintf(['Ending stepsize alpha=',num2str(alpha),'\n'])
fprintf(['Ending stepsize alpha=',num2str(alpha_1),'\n'])
fprintf(['Number of Episodes=',num2str(iter),'\n'])
Mean_R=[Mean_R,mean(R)]
V_TD_0=[V_TD_0,V((length(V)+1)/2)]
v_TD_0=[v_TD_0,v]

V_list=[V_list,V];
end
%%
figure()
plot(1:length(Mean_R),Mean_R)
hold on
plot(1:length(ER_list),ER_list,'--','color','k','linewidth',1.5)
plot(1:length(V_TD_0),V_TD_0,'Color','magenta','linewidth',2)
plot(1:length(v_TD_0),v_TD_0,'Color','green','linewidth',1.2)
xlabel('\mu')
legend('simulation','analytical','TD(0) 2\mu+1 states','TD(0) one state')
xticks(0:1:10)
ylabel('E[R]')
title(['Comparison of results from simulation and from TD(0),',num2str(iter),' epsodes'])
grid on
end