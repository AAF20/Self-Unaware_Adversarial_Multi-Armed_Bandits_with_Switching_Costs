function   omega =  Weight (omega,eta,Xhat)
% This function updates the weights on each arm in EXP3 algorithm. 
omega = omega .* (exp ((eta .* Xhat)) );
end
