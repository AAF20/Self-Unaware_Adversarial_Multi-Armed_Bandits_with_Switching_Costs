function D = AdversarialEnvironment(T,K)
% This fuction returns matrix D as the stochastically adversarial
% environment. The function accepts finite time horizon T and number of
% arms K.
%% finding number of phases which depends on T.
n=1;c=0;
while c < T
    c = floor(1.6^n)+c;
    h(n) = c ;
    n = n+1;           % n denotes the number of phases.
end
h(length(h)) =  T;
delta = 1/K; % the gap between arms.
D = zeros(K,h(end));   % matrix D initialization.
%%  Generating rewards on the best arm in odd and even phases.
temp = 1 ;
for i = 1:length(h)
    y = mod(i,2);
    if y==1
        D(1,temp:h(i)) = ones(length(temp:h(i)),1)';
        temp = h(i)+1;
    else
        D(1,temp:h(i)) = binornd(1, delta*ones(length(temp:h(i)),1))';
        temp = h(i)+1;
    end
end
%%  Generating rewards on the other K-1 arms in odd and even phases.
for j = 2:K
    temp = 1 ;
    for i = 1:length(h)
        y = mod(i,2);
        if y==1
            D(j,temp:h(i)) = binornd(1, (1-delta)*ones(length(temp:h(i)),1))';
            temp = h(i)+1;
        else
            D(j,temp:h(i)) = zeros(length(temp:h(i)),1)';
            temp = h(i)+1;
        end
    end
end
end
