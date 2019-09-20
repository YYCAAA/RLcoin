function alpha_new=get_stepsize(alpha,S,step_size_para)
    para=step_size_para(S(1)+1,S(2)+1);%sum(step_size_para(:));%step_size_para(S(1)+1,S(2)+1);
   	alpha_new=1/(1/alpha+para);
end
    