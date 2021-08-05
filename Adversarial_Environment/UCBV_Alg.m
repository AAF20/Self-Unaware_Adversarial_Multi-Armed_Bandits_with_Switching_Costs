function [Gmax_UCBV, G_UCBV] = UCBV_Alg(K,T,iteration)
% This function implements UCBV algorithm.
% The algorithm is available at:
% http://imagine.enpc.fr/~audibert/Mes%20articles/TCS08.pdf
Gmax_UCBV = zeros(iteration,T);
G_UCBV = zeros(iteration,T);
for itr = 1:iteration
    D = AdversarialEnvironment(T,K);   % rewards on the arms (adversarial environment)
    gainUCBV   = [];
    s1  = zeros(1,K);
    s2 = zeros(1,K);
    NumberPlayedArm = ones(1,K);
    PlayedArms = [];
    for t = 1:T
        m =  s1./NumberPlayedArm;
        V = s2./NumberPlayedArm - m.^2;
        ucb = m + sqrt(2*log(t).*V./NumberPlayedArm) + 3*log(t)./NumberPlayedArm;
        mm = max(ucb);
        if ( ~isnan(mm))
            I = find(ucb == mm);
            Arm = I(1+floor(length(I)*rand)); % Breaking randomly the tie
        else
            Arm = randi(length(ucb));
        end
        reward = D(Arm,t); % Reward received by playing the chosen arm
        gainUCBV = [gainUCBV reward]; % update the gained reward
        s2(Arm) = s2(Arm) + reward.^2;
        s1(Arm) = s1(Arm) + reward;
        NumberPlayedArm(Arm) = NumberPlayedArm(Arm) + 1;
        PlayedArms = [PlayedArms Arm];
        reward1(t) = reward ;
        GUCBV (t) = sum(reward1(1:t)) ;   % accumulated reward
    end
    Gmax_UCBV(itr,:) = cumsum(D(1,:)); % maximum reward on the best arm.
    G_UCBV(itr,:) = GUCBV ;            % the accumulated reward gained by the algorithm.
end
end
