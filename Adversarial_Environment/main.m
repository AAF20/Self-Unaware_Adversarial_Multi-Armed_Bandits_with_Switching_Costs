%% This is the main m-file in this folder.
% This code tests the adversarial environmnet using three well-known 
% stochastic algorithms UCB1, MOSS, and UCBV, and one non-stochastic
% algorithm EXP3.   
% Author: Amir Alipour-Fanid
% George Mason University
%%
clc; close all; clear;

%% The parameters
T = 3e5;           % finite time horizon.
K = 16;            % number of arms.
iteration = 500;   % number of runs (for accurate estimates use larger iterations) 

%% UCB1 (Upper Confidence Bound)
[Gmax_UCB1, G_UCB1] = UCB1_Alg(K,T,iteration);    
Regret_UCB1 = Gmax_UCB1 - G_UCB1; 
shadedErrorBar(1:T,mean(Regret_UCB1,1),std(Regret_UCB1),'lineProps',{'r-s','markerfacecolor','r'});
xlabel('t'); ylabel('Regret')
grid on; box on; hold on;

%% MOSS ((Minimax Optimal Strategy in the Stochastic)
[Gmax_MOSS, G_MOSS] = MOSS_Alg(K,T,iteration);    
Regret_MOSS = Gmax_MOSS - G_MOSS;
shadedErrorBar(1:T,mean(Regret_MOSS,1),std(Regret_MOSS),'lineProps',{'b-o','markerfacecolor','b'});
xlabel('t'); ylabel('Regret')
grid on; box on; hold on;

%% UCBV (Upper Confidence Bound V)
[Gmax_UCBV, G_UCBV] = UCBV_Alg(K,T,iteration);
Regret_UCBV = Gmax_UCBV - G_UCBV;
shadedErrorBar(1:T,mean(Regret_UCBV,1),std(Regret_UCBV),'lineProps',{'m-s','markerfacecolor','m'});
xlabel('t'); ylabel('Regret')
grid on; box on; hold on;

%% EXP3 ((Exploration-Exploitation with Exponential weights)
[Gmax_EXP3, G_EXP3] = EXP3_Alg(K,T,iteration);    
Regret_EXP3 = Gmax_EXP3 - G_EXP3;
shadedErrorBar(1:T,mean(Regret_EXP3,1),std(Regret_EXP3),'lineProps',{'g-*','markerfacecolor','g'});
xlabel('t'); ylabel('Regret')
grid on; box on; hold on;

%%
legend('UCB1','MOSS','UCBV','EXP3')

