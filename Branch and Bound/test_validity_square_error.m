clear all
%m=1;

%angle=[2.86867085195028,3.51697605249778,5.79170832092104,0.333054660873655,1.91203840626317,5.22730426981623,4.49512139726233,3.28094763059571,3.64671732664192,3.75835106788947,1.12569010460698,2.72532681445343,5.40634548258076,2.08984025540198,1.85700776033110,0.805866148005574,4.50001733180105,2.84547799308547,5.87117182498798,1.06816763609627];
%angle=rand(1,10)*2*pi;
%angle=[4.88336365209250,5.64637707582369,1.21346577965474,4.21717364070306,0.225165495787848,0.977423000944027,5.79924449731015,3.87073709826987,5.16195873721536,5.71635264843824];

% 
% for k=15:15
%     k
%     for j=1:40000
%         if m>50000
%             break;
%         end
%         angle=rand(1,k)*2*pi;
%         
%         er(m)=square_error(angle,2,1);
%         if er(m)<=5
%             m=m+1;
%         end
%     end
%     mean_error(k-14)=mean(er);
% end
% 
% for k=1:30
%     er(k)=square_error(angle(k,:),2,1);
% end
N_v=20;
% num_1=0;
% num_2=0;

%for aa=1:100
    angle=2*pi*rand(1,N_v);
    sigma_2=0.5*ones(1,N_v)+2*rand(1,N_v);
% for l=3:3
l=6;
c=combnk(1:N_v,l);
l
for k=1:length(c(:,1))
    for j=1:l
    select_angle(j)=angle(c(k,j));
    select_noise(j)=sigma_2(c(k,j));
    end
    [er(k),e0(k),e1(k)]=square_error_diff(select_angle,2,select_noise,0);
%     if er(k)<=0.7
%         square_error(select_angle,2,0.09,1)
%     end
end
s_er=sort(er);
s_er0=sort(e0);
s_er1=sort(e1);
[a,b]=min(er);
[opt_angle,I_opt]=sort(angle(c(b,:)));
opt_noise=sigma_2(c(b,:));
opt_noise=opt_noise(I_opt);
[er_opt,e0_opt,e1_opt]=square_error_diff(opt_angle,2,opt_noise,1);
grid on
s_noise=sort(sigma_2);
%best=min(er);
%clear er select_angle
%end
% if min(best)==best(end)
%     num_1=num_1+1;
% end
% if min(best)==best(1)
%     num_2=num_2+1;
% end

%end