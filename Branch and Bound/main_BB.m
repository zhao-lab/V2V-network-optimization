clear all
N_val=30:5:100;
M_val=4:2:10;

for N_ite=1:length(N_val)
    N_ite
    for M_ite=1:length(M_val)
        success=0;
for ite=1:100000
    ite
    
clearvars -except ite time_consumed N_val N_ite M_val M_ite mean_time var_time success
global M;
global n;  %number of angle in each section, shared with BB
global Best_comb;   %store the current best combination
global Best_value;
global dif_angle;
global H; %Hessian matrix, shared with the bound function
global angle_sec;  %share with cost_function evaluation
global dif_angle; %share with the bound function
global w;
global sigma2;
global optimal_value;  %share with the bound function
Best_comb=[];
Best_value=100;

w=2;
sigma2=1;
N=N_val(N_ite);  %number of vehicles that are at other sections, total number=N+1
M=M_val(M_ite);
opt_angle=0:2*pi/M:2*pi*(M-1)/M;
optimal_value=square_error(opt_angle,w,sigma2,0);
angle=rand(1,N)*2*pi*(M-1)/M+2*pi/M/2;
sec_mid=0:2*pi/M:2*pi*(M-1)/M;
n=zeros(1,M-1);
angle_sec=[];

for k=1:N     %sort angle into different sections
    for j=1:M-1
    if abs(minimizedAngle(angle(k)-sec_mid(j+1)))<=2*pi/M/2
       angle_sec(j,n(j)+1)=angle(k);
       n(j)=n(j)+1;
    end
    end
end

if sum(n)~=N
    'Warning: error sum(n)~=N'
end

flag=0;
for j=1:M-1
    if n(j)==0
        flag=1;
      'Warning: some n(j)==0, algorithm doesnot work'
      break;
    end
end

if flag==1
    continue;
end

success=success+1;
if success>101
    break;
end
    
for j=1:M-1
    for k=1:n(j)
        dif_angle(j,k)=minimizedAngle(angle_sec(j,k)-sec_mid(j+1));
    end
end

subopt_angle(1)=0;
for j=1:M-1
    [a,b]=min(abs(dif_angle(j,1:n(j))));
    subopt_angle(j+1)=angle_sec(j,b);
    Best_comb(j)=b;
end
heuristic=Best_comb;
Best_value=square_error(subopt_angle,w,sigma2,0);

H=cal_hessian(M,w,sigma2);

tic;
BB([],1);   %find the best combination and the corresponding value using Branch&Bound
time_consumed(N_ite,M_ite,ite)=toc;
end
% mean_time(N_ite,M_ite)=mean(time_consumed);
% var_time(N_ite,M_ite)=var(time_consumed);
    end
end













            
            
            
    
    