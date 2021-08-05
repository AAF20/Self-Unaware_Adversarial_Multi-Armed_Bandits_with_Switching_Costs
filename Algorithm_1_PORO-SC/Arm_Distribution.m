function  pr = Arm_Distribution (w,gama,newK,M)
% This function returns the probability distribution over the arms at each round t. 
sum_weights = sum(w(setdiff(1:end, M)));
w(M) = 0;
id = ones(newK+length(M),1) ; id(M) = 0 ;
pr = ( (1-gama) .* ( w ./ sum_weights ) ) + (id.*( gama / newK )) ;  % probability assigning to each channel at time t
end
