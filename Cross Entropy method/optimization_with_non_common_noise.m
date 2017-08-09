clear all
% for kkk=1:1000
%     kkk
%     clearvars -except kkk rank_er
global M;
global n;  %number of angle in each section, shared with BB
global Best_comb;   %store the current best combination
global Best_value;
global dif_angle;
%global H; %Hessian matrix, shared with the bound function
global angle_sec;  %share with cost_function evaluation
%global dif_angle; %share with the bound function
global w;
global sigma2_sec;
%global optimal_value;  %share with the bound function
Best_comb=[];
Best_value=100;

w=2;
N=50;  
%sigma2=0.5+2*abs(randn(1,N));
M=5;
%angle=rand(1,N)*2*pi;
load benchmark_50angles.mat;

window=2*pi/M;   %the window width might need tuning
%com=combnk(1:N-2,M-1);  %used for deleting angles
%nub_com=length(com);
N_rand_test=5; % select 20 random configuration to test if one angle can be deleted
delete_index=[];

[s_sigma,i_sigma]=sort(sigma2);  %sort the noise, starting from the lower noise, delete angle near it
s_angle=angle(i_sigma); %rearrange angle according to the noise
for k=1:N
    dif=s_angle(k)-s_angle;  
    for j=1:N
dif(j)=abs(minimizedAngle(dif(j)));
    end
    [s_dif,i_dif]=sort(dif);   %i_dif gives the index of s_angle that is closest to the target angle
    nub_cand=sum(dif<=window)-1;  %total number of candidate angle to be deleted 
    %noted that dif is not sorted
    for i=1:nub_cand
        angle1=s_angle(k);
        noise1=s_sigma(k);
        angle2=s_angle(i_dif(i));
        noise2=s_sigma(i_dif(i));
        if noise2<=noise1   %angle2 is not going to deleted , jump to the next candidate
            continue;
        end
        % now test if angle2 should be deleted

        
        continue_indicator=0;
        
        for m=1:N_rand_test
            temp_angle=[];
            temp_noise=[];
            temp_angle(1)=angle1;
            temp_noise(1)=noise1;
            
        copy_angle=s_angle;
        copy_sigma=s_sigma;
        copy_angle([k,i_dif(i)])=[];
        copy_sigma([k,i_dif(i)])=[];
            
            for l=1:M-1
                rand_index=ceil(rand*length(copy_angle));
                temp_angle(l+1)=copy_angle(rand_index);
                temp_noise(l+1)=copy_sigma(rand_index);
                copy_angle(rand_index)=[];
                copy_sigma(rand_index)=[];
            end
            
            cost1=square_error_diff(temp_angle,w,temp_noise,0);
            temp_angle(1)=angle2;
            temp_noise(1)=noise2;
            cost2=square_error_diff(temp_angle,w,temp_noise,0);
            if cost2<cost1
                continue_indicator=1;
                break;
            end
        end
        
        if continue_indicator==1  %this candidate cannot be deleted, jump to the next candidate
            continue;
        end
        
        %otherwise: indicate this candidate should be deleted
        delete_index=[delete_index,i_dif(i)];
    end
end

      ad_angle=s_angle;
      ad_angle(delete_index)=[];
      ad_sigma=s_sigma;
      ad_sigma(delete_index)=[];
      
     part_com=combnk(1:length(ad_angle),M);
     for k=1:length(part_com(:,1))
         for j=1:M
         part_angle(j)=ad_angle(part_com(k,j));
         part_noise(j)=ad_sigma(part_com(k,j));
         end
     part_er(k)=square_error_diff(part_angle,w,part_noise,0);  
     end
      'Part:finished'
      length(part_com(:,1))
      min(part_er)
%      all_com=combnk(1:N,M);
%      for k=1:length(all_com(:,1))
%          for j=1:M
%          all_angle(j)=angle(all_com(k,j));
%          all_noise(j)=sigma2(all_com(k,j));
%          end
%      all_er(k)=square_error_diff(all_angle,w,all_noise,0);
%      end
         
   
    

% rank_er(kkk)=sum(s_er<min(part_er))+1;
% end

% sec_mid=0:2*pi/M:2*pi*(M-1)/M;
% n=zeros(1,M);
% angle_sec=[];
% 
% for k=1:N     %sort angle into different sections
%     for j=1:M
%     if abs(minimizedAngle(angle(k)-sec_mid(j)))<=2*pi/M/2
%        angle_sec(j,n(j)+1)=angle(k);
%        sigma2_sec(j,n(j)+1)=sigma2(k);
%        n(j)=n(j)+1;
%     end
%     end
% end
% 
% if sum(n)~=N
%     'Warning: error sum(n)~=N'
% end
% 
% for j=1:M-1
%     if n(j)==0
%       'Warning: some n(j)==0, algorithm doesnot work'
%     end
% end

% for j=1:M-1
%     for k=1:n(j)
%         dif_angle(j,k)=minimizedAngle(angle_sec(j,k)-sec_mid(j+1));
%     end
% end

% subopt_angle(1)=0;
% for j=1:M-1
%     [a,b]=min(abs(dif_angle(j,1:n(j))));
%     subopt_angle(j+1)=angle_sec(j,b);
%     Best_comb(j)=b;
% end
% heuristic=Best_comb;
% Best_value=square_error(subopt_angle,w,sigma2,0);
















            
            
            
    
    