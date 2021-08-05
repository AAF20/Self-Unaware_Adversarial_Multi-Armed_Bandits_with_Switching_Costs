function [Gmax_MOSS, G_MOSS] = MOSS_Alg(K,T,iteration)
%This function implements MOSS algorithm. 
% The algorithm is available at: 
%https://www.microsoft.com/en-us/research/wp-content/uploads/2017/01/COLT09_AB.pdf
Gmax_MOSS = zeros(iteration,T);
G_MOSS =zeros(iteration,T);
for itr = 1:iteration
    D = AdversarialEnvironment(T,K);         % rewards on the arms (adversarial environment) 
    Xbar = ones(1,K) ; n = ones(1,K) ;         % initialization 
    for t = 1 : T
        o =  Xbar + sqrt(max(log(T./(length(n).*n)),0)./n);  % MOSS
        [~, arm] = max (o) ;                   % select the arm.
        x = D(arm,t) ;                         % reward received on the played arm.
        Xbar(arm) = (Xbar(arm)*n(arm)+x)/(n(arm)+1);  % compute the average reward on the selected arm.       
        n(arm) = n(arm)+1;
        reward(t) = x;
        sum_reward(t) = sum(reward(1:t));      % accumulated reward
    end
    Gmax_MOSS(itr,:) = cumsum(D(1,:));         % maximum reward on the best arm.
    G_MOSS(itr,:) = sum_reward;                % the accumulated reward gained by the algorithm.
end
end