function y=cost_function_CE(index,M)
global angle;
global w;
global sigma2;
if sum(index)~=M
    'Error,sum(index)~=M'
    a
end
ang=[];
sig=[];
for k=1:length(index)
    if index(k)==1
    ang=[ang,angle(k)];
    sig=[sig,sigma2(k)];
end
y=square_error_diff(ang,w,sig,0);
end