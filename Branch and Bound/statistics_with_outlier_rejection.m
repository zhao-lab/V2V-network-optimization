clearvars -except time_consumed

for i=1:15
    for j=1:4
        t_BB(i,j)=nchoosek(N_val(i),M_val(j))/100000*3.6463;
        time=[];
        for k=1:135
            if time_consumed(i,j,k)>0
                time=[time,time_consumed(i,j,k)];
            end
        end
        mu=mean(time);
        cov=var(time);
        time(find(time>mu+1*sqrt(cov)))=[];
        mu_final(i,j)=mean(time);
        cov_final(i,j)=var(time);
    end
end

N_val=30:5:100;
M_val=4:2:10;
t_100000=3.6463;
for i=1:15
    for j=1:4
        t_BB(i,j)=nchoosek(N_val(i),M_val(j))/100000*3.6463;
    end
end
