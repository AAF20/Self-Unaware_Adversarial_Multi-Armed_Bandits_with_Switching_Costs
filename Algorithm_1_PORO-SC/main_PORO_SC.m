%% Algorithm 1: Play-OR-Observe with Switching Costs (PORO-SC)
% This is the main m-file in this folder.
% Author: Amir Alipour-Fanid
% George Mason University
%%
clc ; close all ; clear ;

%% Parameters
% The users are free to change the following setting parameters.
T = 3e6;          % finite time horizon.
K = 16;           % number of arms (K>1).
iteration = 500;  % number of runs (for accurate estimates use larger iterations).
c = 1 ;           % switching cost is set to c = 1 for all t.
%%
% The following code runs Algorithm 1 (PORO-SC) over the setting parameters defined
% above, and plots the empirical and analytical expected regret of the player.

gama = ((K * log(K))/(T))^(1/4); % exploration rate
eps = ((K * log(K))/T)^(1/4);
temp1 = (K * log(K));
temp2 = ((T+1)^(3/2))/((temp1)^(1/2));
temp3 = ((T^(1/4))*(temp1^(3/4)))/4;
eta = sqrt((5*log(K))/(2*K*(exp(1)-2))) * ((temp2+temp3)^(-1/2)); % learning rate
Gmax_PORO_SC = zeros(T,iteration); 
G_PORO_SC = zeros(T,iteration) ;
for itr = 1 : iteration
    disp(itr)
    D = AdversarialEnvironment(T+1,K);   % rewards on the arms (adversarial environment.
    t=1;
    pr = (1/K)*ones(1,K);                 % initialization probability distribution over the arms.
    arm = Arm_Selection(pr);              % select an arm for t = 1.
    Saved_arm(t) = arm ;
    omega = ones(K,1);                    % weight matrix.
    for t = 2 : T+1
        alpha = min((1-eps),((((K * log(K))/t)^(1/4))));  % switching probability.
        beta = min(1,((((K * log(K))/t)^(1/4))));         % play probability.
        u = rand ;
        v = rand ;
        if  alpha >= u                % switch if true.
            ct = c;                   % switching cost.
            hat_x = zeros(K,1);
            pr = Arm_Distribution(omega(:,1),gama,K,[]) ;  % probability distribution over the arms.
            P = pr ;
            arm = Arm_Selection(pr);                      % selected arm to be palyed.
            Saved_arm(t) = arm;
            if  beta >= v     % observe the arm if true.
                x = D(arm,t);                                % reward received on the played arm.
                hat_x(arm) = x/(2*alpha*beta*P(arm));          % unbiased estimated reward.
                omega =  Weight (omega,eta,hat_x) ;  % updating the weights.
                x=0;
            else             % play the arm.
                x = D(arm,t);                                % reward received on the played arm.
                hat_x(arm) = 0;          % unbiased estimated reward.
                omega =  Weight (omega,eta,hat_x) ;  % updating the weights.
            end
        else                     % no switching
            ct = 0;
            hat_x = zeros(K,1);
            P = pr ;
            arm = Saved_arm(t-1);   % set the previous arm
            Saved_arm(t) = arm;
            if  beta >= v           % observe the arm if true.
                x = D(arm,t);
                hat_x(arm) = x/(2*(1-alpha)*beta*P(arm));      % unbiased estimated reward.
                omega =  Weight (omega,eta,hat_x) ;           % updating the weights.
                x=0;
            else                    % play the arm.
                play(itr,t)=1;
                x = D(arm,t);
                hat_x(arm) = 0;      % unbiased estimated reward.
                omega =  Weight (omega,eta,hat_x) ;           % updating the weights.
            end
        end
        reward(:,t-1) = x - ct ;                  % gained reward and switching costs.
        sum_reward (:,t-1) = sum (reward(:,1:t-1),2) ;  % accumulated reward
    end
    Gmax_PORO_SC(:,itr) = cumsum(D(1,2:end),2); % maximum reward on the best arm in hindsight.
    G_PORO_SC(:,itr) = sum_reward ;   % the accumulated reward gained by the PORO-SC algorithm.
end
%%
figure; 

Regret_PORO_SC = Gmax_PORO_SC' - G_PORO_SC' ;   % compute the regret. 
shadedErrorBar(1:T,mean(Regret_PORO_SC,1),std(Regret_PORO_SC),'lineProps',{'b-','markerfacecolor','b'});
hold on

Analytical_regret_PORO_SC = (sqrt(1.6*(exp(1)-2))+(11/3))*((K*log(K))^(1/4))*((1:T).^(3/4)); % Analytical regret of PORO-SC algorithm.
plot(1:T,Analytical_regret_PORO_SC,'r','LineWidth',2);

xlabel('t'); ylabel('Regret')
legend('PORO-SC (simulation)', 'PORO-SC (analytical)')
grid on; box on;