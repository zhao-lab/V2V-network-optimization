function BB(P,i)  
global Best_comb;   %store the current best combination
global Best_value;  %store the corresponding minimum error according to the local expansion
global M;    %number of vehicle selected
global n;

if length(P)+1~=i
    'Warning: length(P)+1~=i'
end

%require external value M
if i>M-1
    'Warning:i>M,there is some error in B&B'
end
    
    
if i==M-1   %leaf nodes
    
    for j=1:n(i)   %n(i) store the number of options for the i-th section
        value=cost_function([P,j]);
        if value<Best_value
            %better solution possible, search
        Best_comb=[P,j];
        Best_value=value;
        end
    end
    
end

if i<M-1   %havent reach the leaf, only partial solution
    
    for j=1:n(i)
        if bound_function([P,j])<Best_value
            %better solution possible, search
        BB([P,j],i+1)
        end
    end
    
end

end