clear all
load benchmark_50angles.mat;
for kk=1:1000

clearvars -except kk s_er best
%load benchmark_50angles.mat;

num=0;
for k=1:5000
    x=ceil(rand*2118760);
    er(k)=s_er(x);
    
    if er(k)<=4
        num=num+1;
valid_er(num)=er(k);
    end
end

s_v_er=sort(valid_er);

best(kk)=s_v_er(1);
end

