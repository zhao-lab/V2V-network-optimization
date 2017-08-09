clear all   %bernoulli distribution of all the N sample 
load('benchmark_50angles.mat');
global angle;
global w;
global sigma2;
w=2;
M=5;
%
N=1000;   %number of samples
Ne=20;   %number of elite samples
N_max_iter=20;  %number of maximum iteration
alpha=0.75;  %smooth paramter

%start delete angles
N_rand_test=5; % select 20 random configuration to test if one angle can be deleted

[angle,sigma2]=delete_angle(angle,sigma2,M,N_rand_test);
%end delete angles
n=length(angle);   %select M vehicles from N vehicles
v=M/n*ones(1,n);   %inital prob of the bernoulli distribution, to make the expected selected number equal to M to maximize the performance of the algorithm


for n_iter=1:N_max_iter
    
sample_index=rand(N,n);
for k=1:n
    sample_index(:,k)=sample_index(:,k)<=v(k); %the k-th component selected with prob v(k)  
end

for k=1:N
    if sum(sample_index(k,:))~=M
        S(k,1)=-10;   %assign a small value (large negative)
    else
        S(k,1)=-cost_function_CE(sample_index(k,:),M);   %notice the minus makes the minimization into a maximization problem
    end
end

[sort_S,order_S]=sort(S);
gamma=sort_S(N-Ne+1);
gamma_t(n_iter)=gamma;   %record the elite performance
best_t(n_iter)=sort_S(N);  %record the best performance
%update v(k)
deno=sum(S>=gamma);  
pre_v=v;  %record the previous v
for k=1:n
    v(k)=sum((S>=gamma).*sample_index(:,k))/deno;
end
    
%stop criterion
if sum(abs(v-pre_v))<=N*10^-3   %if the average update is less than 0.1%, stop the iteration
    break;
end

v=alpha*v+(1-alpha)*pre_v;  %smooth update of v

end  %end for the iteration loop
    
    



    