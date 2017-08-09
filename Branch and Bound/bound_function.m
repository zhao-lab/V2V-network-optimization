function y=bound_function(P)
global H;
global dif_angle;
global optimal_value;
fixed_angle=[];
N=length(P);
for k=1:N
    vec(k,1)=dif_angle(k,P(k));
end
% Aeq=eye(N);
% Aeq(:,N+1:size(H,1))=0;
ind(1:N,1)=0;%inactive
ind(N+1:size(H,1))=1;  %active
vec(N+1:size(H,1))=0;
min_value=quadratic_prog(H,ind,vec);
y=min_value+optimal_value;
end
