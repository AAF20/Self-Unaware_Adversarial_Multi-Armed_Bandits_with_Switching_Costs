function [Gmax_EXP3, G_EXP3] = EXP3_Alg(K,T,iteration)
% This function implements EXP3 algorithm. 
% The algorithm is available at: 
% http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.21.8735&rep=rep1&type=pdf
Gmax_EXP3 = zeros(iteration,T);
G_EXP3 = zeros(iteration,T);
gama = sqrt(((K * log(K))/((exp(1)-1)*T)));
eta = gama/K; % learning rate
for itr = 1 : iteration
    D = AdversarialEnvironment(T,K);  % rewards on the arms (adversarial environment) 
    omega = ones(K,1);                  % weight vector
    for t = 1 : T
        hat_x = zeros(K,1);              
        pr = Arm_Distribution(omega,gama,K);     % probability distribution over the arms.
        arm = Arm_Selection(pr);                 % selected arm to be palyed.
        x = D(arm,t);                            % reward received on the played arm.
        hat_x(arm) = x/(pr(arm));                % unbiased estimated reward.
        omega =  Weight(omega,eta,hat_x);        % updating the weights.
        reward(t) = x;
        sum_reward(t) = sum(reward(1:t));        % accumulated reward
    end
    Gmax_EXP3(itr,:) = cumsum(D(1,:));           % maximum reward on the best arm.
    G_EXP3(itr,:) = sum_reward ;                 % the accumulated reward gained by the algorithm.
end
end