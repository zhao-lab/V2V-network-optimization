function H=cal_hessian(N,w,sigma2)
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
end