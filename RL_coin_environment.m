f=0.1;
R_plus=1;
R_minus=20;
iter=999000;
Mean_R=[];
% coin=1, H type; coin=0, T type
Time={};

type=0; % 0: Reward/time, 1: Time step wise penalty
c=0.02;

for mu=2
    R=zeros(iter,1);
    time=zeros(iter,1);
for j=1:iter
coin=randi(2)-1;    
traj=[];
if coin==1
    for i=1:1000
%         if length(traj)>=2&&(all(traj(1:2)==[1,0]')||all(traj(1:2)==[0,1]'))
%             mu=3;
%         end
        if abs(length(find(traj==0))-length(find(traj==1)))>=mu
            break
        end
        traj=[traj;binornd(1,1-f)];
    end
    if length(find(traj==1))-length(find(traj==0))>0
        if type==0
            Reward=R_plus/length(traj);
        else
            Reward=R_plus-c*length(traj);
        end
    else
        if type==0
            Reward=-R_minus/length(traj);
        else
            Reward=-R_minus-c*length(traj);
        end
    end
    R(j)=Reward;
    time(j)=length(traj);
else
    for i=1:1000
%         if length(traj)>=2&&(all(traj(1:2)==[1,0]')||all(traj(1:2)==[0,1]'))
%             mu=3;
%         end
        if abs(length(find(traj==0))-length(find(traj==1)))>=mu
            break
        end
        traj=[traj;binornd(1,f)];    
    end
    if length(find(traj==0))-length(find(traj==1))>0
        if type==0
            Reward=R_plus/length(traj);
        else
            Reward=R_plus-c*length(traj);
        end
    else
        if type==0
            Reward=-R_minus/length(traj);
        else
            Reward=-R_minus-c*length(traj);
        end
    end
    R(j)=Reward;
    time(j)=length(traj);
end

end
fprintf([num2str(iter),' of simulation for old strategy'])
Mean_R=[Mean_R,mean(R)]
Time=[Time,time];
end
%%
figure(1)
histogram(Time{1,5},'Normalization','probability')
figure(2)
histogram(Time{1,2},'Normalization','probability')