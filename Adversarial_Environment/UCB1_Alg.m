function [Gmax_UCB1, G_UCB1] = UCB1_Alg(K,T,iteration)
% This function implements UCB1 algorithm. 
% The algorithm is available at: 
% https://link.springer.com/content/pdf/10.1023/A:1013689704352.pdf
Gmax_UCB1 = zeros(iteration,T);
G_UCB1 = zeros(iteration,T);
for itr = 1:iteration
    D = AdversarialEnvironment(T,K);   % rewards on the arms (adversarial environment) 
    Xbar = ones(1,K); n = ones(1,K);     % initialization 
    for t = 1 : T
        o = Xbar+sqrt(2*log(t)./n);      % UCB  
        [~,arm] = max (o);               % select the arm.
        x = D(arm,t);                    % reward received on the played arm.
        Xbar(arm) = (Xbar(arm)*n(arm)+x)/(n(arm)+1);  % compute the average reward on the selected arm.
        n(arm) = n(arm) + 1;
        reward(t) = x;
        sum_reward(t) = sum(reward(1:t)); % accumulated reward
    end
    Gmax_UCB1(itr,:) = cumsum(D(1,:));   % maximum reward on the best arm.
    G_UCB1(itr,:) = sum_reward;          % the accumulated reward gained by the algorithm.
end
end