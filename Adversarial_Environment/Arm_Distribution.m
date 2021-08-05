function  pr = Arm_Distribution(omega,gama,K)
% This function returns the probability distribution over the arms at each
% round t in EXP3 algorithm. 
sum_weights = sum(omega(:)) ;       
pr = ( (1-gama) .* ( omega ./ sum_weights ) ) + ( gama / K );  
end
