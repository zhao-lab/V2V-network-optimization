clear all   %bernoulli distribution of all the N sample 
load('benchmark_50angles.mat');
global angle;
global w;
global sigma2;
global copy_angle;
global copy_sigma2;
copy_angle=angle;
copy_sigma2=sigma2;

tic;

for lll=1:100
    lll
clearvars -except copy_angle w copy_sigma2 lll best_sol tic; 
w=2;
M=5;

miu=(0:M-1)*2*pi/M; 
cov=100*(pi/M)^2*eye(M);   %initial parameter of the distribution, this ensure that the initial distribution is sufficiently flat, such that all combination of angles are sampled
% this 100* might need some tuning

N=1000;   %number of samples
Ne=50;   %number of elite samples
N_max_iter=20;  %number of maximum iteration
alpha=0.75;  %smooth paramter

%start delete angles
N_rand_test=10; % select 20 random configuration to test if one angle can be deleted

[angle,sigma2]=delete_angle(copy_angle,copy_sigma2,M,N_rand_test);
%end delete angles
n=length(angle);   %select M vehicles from N vehicles


for n_iter=1:N_max_iter
    sample_c=mvnrnd(miu,cov,N);
    sample_d=zeros(N,M);
    sigma_d=zeros(N,M);
    for i=1:N
        for j=1:M
            dif=mod(angle-sample_c(i,j),2*pi);
            [a,b]=min([dif,2*pi-dif]);
            if b<=n  %n:length of angle
                sample_d(i,j)=angle(b);
                sigma_d(i,j)=sigma2(b);
            else
                sample_d(i,j)=angle(b-n);
                sigma_d(i,j)=sigma2(b-n);
            end
        end
    end    %now sample_d

    



for k=1:N
        S(k,1)=-square_error_diff(sample_d(k,:),w,sigma_d(k,:),0);   %notice the minus makes the minimization into a maximization problem
end

[sort_S,order_S]=sort(S);
gamma=sort_S(N-Ne+1);
gamma_t(n_iter)=gamma;   %record the elite performance
best_t(n_iter)=sort_S(N);  %record the best performance
%update v(k)
deno=sum(S>=gamma);  %number of elite samples
miu_pre=miu;  %record the previous v
cov_pre=cov;

for k=1:M
miu(k)=atan2(sum((S>=gamma).*sin(sample_d(:,k)))/deno,sum((S>=gamma).*cos(sample_d(:,k)))/deno);
end

cov=zeros(M);
for k=1:N
    if S(k)>=gamma
        dif_ang=sample_d(k,:)-miu;
        for j=1:M
            dif_ang(j)=minimizedAngle(dif_ang(j));
        end
        cov=cov+dif_ang.'*dif_ang;
    end
end
cov=cov/(deno-1);  %unbiased estimator

    
%stop criterion
if sum(abs(miu-miu_pre))<=M*0.02   %if the average update is less than 0.1%, stop the iteration
    break;
end

miu=atan2(alpha*sin(miu)+(1-alpha)*sin(miu_pre),alpha*cos(miu)+(1-alpha)*cos(miu_pre));  %smooth update of v
cov=alpha*cov+(1-alpha)*cov_pre;
end  %end for the iteration loop
    
    best_sol(lll)=-max(best_t);
end

run_time=toc;

    