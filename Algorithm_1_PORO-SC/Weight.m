function   omega =  Weight (omega,eta,Xhat)
% This function updates the weights on each arm.
omega = omega .* (exp ((eta .* Xhat)) ) ;
end
