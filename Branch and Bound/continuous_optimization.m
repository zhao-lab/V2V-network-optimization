% for N_v=15:15
%     N_v
% angle=2*pi*rand(1,10);
% angle=[4.18473579635023,4.76497989105900,1.87071752652456,3.01069347870357,1.92007770503973,1.26918034736393,2.85125031627114,0.214647648900359];

% clear
% angle(1)=0;
% N_angle=120;
% for jj=1:N_angle
%     for kk=1:jj
%     jj
%     angle(2)=2*pi/N_angle*jj;
%     angle(3)=2*pi/N_angle*kk;
%     er(jj,kk)=square_error(angle,2,0.1,0);
%     end
% end
% 
% er=er.*(er<=5);
% a=(er==0);
% er=er+5*a;
clear all
w=2;
sigma2=1;
N=3;
angle=0:2*pi/N:2*pi*(N-1)/N;
y=square_error(angle,w,sigma2,0);
d=0.01;   %pertubation for numerical differentiation
for k=1:N-1
    for j=1:N-1
        if k==j
            dangle=angle;
            dangle(k+1)=dangle(k+1)+d;
            fp=square_error(dangle,w,sigma2,0);
            dangle(k+1)=dangle(k+1)-2*d;
            fm=square_error(dangle,w,sigma2,0);
            H(k,j)=(fp+fm-2*y)/d^2;
        else
            dangle=angle;
            dangle(k+1)=dangle(k+1)+d;
            dangle(j+1)=dangle(j+1)+d;
            fpp=square_error(dangle,w,sigma2,0);
            dangle(k+1)=dangle(k+1)-2*d;
            fmp=square_error(dangle,w,sigma2,0);
            dangle(j+1)=dangle(j+1)-2*d;
            fmm=square_error(dangle,w,sigma2,0);
            dangle(k+1)=dangle(k+1)+2*d;
            fpm=square_error(dangle,w,sigma2,0);
            H(k,j)=(fpp-fmp-fpm+fmm)/4/d^2;
        end
    end
end
            
        
    
