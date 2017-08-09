function y=cost_function(P)
global angle_sec;
global w;
global sigma2;
angle=[0];
for k=1:length(P)
    angle=[angle,angle_sec(k,P(k))];
end
y=square_error(angle,w,sigma2,0);
end