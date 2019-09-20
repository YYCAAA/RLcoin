%plot expectation
clear all 
close all

iter=20;

f=0.1;
R_plus=1;
R_minus=20;

type=0; % 0: Reward/time, 1: Time step wise penalty
c=0.02;% penalty value
for mu=1:20
    [ER_list(mu),pmf{mu}]=Expectation_of_Reward(mu,f,R_plus,R_minus,iter,type,c);
end
[maximum, ind]=max(ER_list);


plot(1:20,ER_list)
hold on
plot(ind,maximum,'r*')
xlabel('\mu')
xticks(0:2:20)
ylabel('E[R]')
grid on
title(['Optimal \mu when f=',num2str(f),', R_+=',num2str(R_plus),', R_-=',num2str(R_minus)])

%%
figure
plot(0:20,pmf{1,2})
plot(0:20,pmf{1,3})
ylabel('P(i)')
xlabel('i')
hold on
grid on
plot(0:20,cumsum(pmf{1,2}))
plot(0:20,cumsum(pmf{1,3}))
legend('Prob. mass wrt. I=i(mu=2)','Prob. mass sum until i(mu=2)','Prob. mass wrt. I=i(mu=3)','Prob. mass sum until i(mu=3)')

figure
plot(0:20,log(1-cumsum(pmf{1,2})))
hold on
grid on
plot(0:20,log(1-cumsum(pmf{1,3})))
legend('log of prob.sum until i(\mu=2)','log of prob.sum until i(\mu=3)')