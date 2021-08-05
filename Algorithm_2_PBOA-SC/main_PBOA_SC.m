%% Algorithm 2: Play-But-Observer-Another with Switching Costs (PBOA-SC)
% This is the main m-file in this folder.
% Author: Amir Alipour-Fanid
% George Mason University
%%
clc ; close all ; clear ;

%% Parameters
% The users are free to change the following setting parameters.
T = 30000;   % finite time horizon.
K = 32;       % number of arms (K>2).
iteration = 500;  % number of runs (for accurate estimates use larger iterations).
m = 1;         % m denotes the number of observation. 
             % For Fig. 12, set m = 1.
             % For Fig. 13, set m according to the values illustrated in the figure. 
             % For Fig. 14, set m according to the values illustrated in the figure. 
             % Note that m must satisfy $m \leq K-1$
c = 1;       % c denotes the switching cost.
             % For Fig. 12, set c = 1. 
             % For Fig. 13, set c = 1.
             % For Fig. 14, set c = 1/m.
%%
% The following code runs Algorithm 1 (PORO-SC) over the setting parameters defined
% above, and plots the empirical and analytical expected regret of the player.
gama = 0.5;
eps=((((K-1)/m) * log(K))/T)^(1/3);
temp1 = (((K-1)/m) * log(K));
temp2= 7/((temp1)^(1/3));
temp3 = (temp1)/ (((T^(1/3))-(temp1^(1/3)))^4)   ;
eta =  (4/(T^(2/3)))* sqrt((log(K))/(((K-1)/m)*(exp(1)-2))) * ((temp2+temp3)^(-1/2)); % learning rate
Gmax_PBOA_SC = zeros(T,iteration) ; 
G_PBOA_SC = zeros(T,iteration) ;
for itr = 1 : iteration
    disp(itr)                    
    D = AdversarialEnvironment(T+1,K);  % rewards on the arms (adversarial environment.
    t=1;
    pr = (1/K)*ones(K,1);                 % initialization probability distribution over the arms.
    arm = Arm_Selection(pr);              % select an arm for t = 1.
    Saved_arm(t) = arm ;                  % save the selected arm.
    notPlayed(t) = {setdiff(1:K,arm)};    % exclude the played arm from set [K].
    Observe(t) = {randsample(notPlayed{(t)},m)};  % sample the arm for observation.
    omega = ones(K,1);                    % weight matrix.
    for t = 2 : T+1
        alpha = min((1-eps),((((((K-1)/m) * log(K))/t)^(1/3))));  % switching probability.
        u = rand ;
        if  alpha >= u            % switch if true.
            ct = c;               % set the switching cost.
            hat_x = zeros(K,1);
            pr = Arm_Distribution(omega(:,1),gama,K,[]) ;  % probability distribution over the arms.
            P = pr ;
            arm = Arm_Selection(pr);                      % selected arm to be palyed.
            Saved_arm(t) = arm;
            notPlayed(t) = {setdiff(1:K,arm)};
            Observe(t) = {randsample(notPlayed{(t)},m)};
            x = D(arm,t);                                % reward received on the played arm.
            xx = D(cell2mat(Observe(t)),t);              % reward received on the played arm.
            hat_x(cell2mat(Observe(t))) = ((K-1)*xx)./(2*m*alpha*(1-P(cell2mat(Observe(t)))));  % unbiased estimated reward.
            omega =  Weight (omega,eta,hat_x) ;  % updating the weights.
        else          % no switching
            ct = 0;
            hat_x = zeros(K,1);
            P = pr ;
            arm = Saved_arm(t-1);
            Saved_arm(t) = arm;
            Observe(t) = Observe(t-1);
            x = D(arm,t);                           % reward received on the played arm.
            xx = D(cell2mat(Observe(t)),t);         % reward received on the played arm.
            hat_x(cell2mat(Observe(t))) = ((K-1)*xx)./((2*m*(1-alpha)*(1-P(cell2mat(Observe(t))))));     % unbiased estimated reward.
            omega =  Weight (omega,eta,hat_x) ;  % updating the weights.
        end
        reward(:,t-1) = x - (ct*(m+1)) ;                  % gained reward and switching costs.
        sum_reward (:,t-1) = sum (reward(:,1:t-1),2) ;  % accumulated reward
    end
    Gmax_PBOA_SC(:,itr) = cumsum(D(1,2:end),2); % maximum reward on the best arm in hindsight.
    G_PBOA_SC(:,itr) = sum_reward ;   % the accumulated reward gained by the Algorithm 1.
end
%%
figure;

Regret_PBOA_SC = Gmax_PBOA_SC' - G_PBOA_SC' ;
shadedErrorBar(1:T,mean(Regret_PBOA_SC,1),std(Regret_PBOA_SC),'lineProps',{'b-','markerfacecolor','b'});
hold on

Analytical_regret_PBOA_SC = (sqrt(7*(exp(1)-2))+(1.5*c*(m+1)))*((((K-1)*log(K))/m)^(1/3))*((1:T).^(2/3)); % Analytical regret of Algorithm 1.
plot(1:T,Analytical_regret_PBOA_SC,'r','LineWidth',2);
xlabel('t'); ylabel('Expected Regret')
legend('PBOA-SC (simulation)', 'PBOA-SC (analytical)')
grid on; box on;