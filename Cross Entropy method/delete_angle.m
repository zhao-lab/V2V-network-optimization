function [ad_angle,ad_sigma]=delete_angle(angle,sigma2,M,N_rand_test)
global w
window=2*pi/M;   %the window width might need tuning
N_a=length(angle);
delete_index=[];

[s_sigma,i_sigma]=sort(sigma2);  %sort the noise, starting from the lower noise, delete angle near it
s_angle=angle(i_sigma); %rearrange angle according to the noise
for k=1:N_a
    dif=s_angle(k)-s_angle;  
    for j=1:N_a
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

      ad_angle=s_angle;    %after delete angles
      ad_angle(delete_index)=[];
      ad_sigma=s_sigma;
      ad_sigma(delete_index)=[];
end