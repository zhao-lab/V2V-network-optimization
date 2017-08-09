function y=quadratic_prog(H,ind,vec)  %H is the Hessian Matrix, ind is the indicator "1" means active vector, "0"means inactive
% vec gives the variable value, with "0" indicate need minimize over
n=length(vec);
active_index=[];
inactive_index=[];
for k=1:n
if ind(k)==1
  active_index=[active_index;k];
else
  inactive_index=[inactive_index;k];
end
end
%constant=0.5*vec.'*H*vec;
inactive_vec=vec(inactive_index);

H_act=H(active_index,active_index);
% C_act=2*H(inactive_index,active_index);
% for k=1:size(C_act,2)
%     C_act(:,k)=C_act(:,k).*vec(inactive_index);
% end
% if size(C_act,1)>=2
% C_act=sum(2*H(inactive_index,active_index),1);
% end
C_act=H(active_index,inactive_index)*inactive_vec;
%C_act=C_act(active_index);
act_arg=-H_act\C_act;    %min_arg of the active index
all_arg(active_index)=act_arg;
all_arg(inactive_index)=inactive_vec;
all_arg=all_arg.';
y=0.5*all_arg.'*H*all_arg;
end
