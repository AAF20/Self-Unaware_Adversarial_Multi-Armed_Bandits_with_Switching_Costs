# Self-Unaware_Adversarial_Multi-Armed_Bandits_with_Switching_Costs

This folder contains Matlab codes for the IEEE Transactions on Neural 
Networks and Learning Systems (TNNLS) submission: 
titled "Self Unaware Adversarial Multi-Armed Bandits with Switching Costs". 
The reader can find the required codes related to the algorithms provided in the paper. All the main 
files and†corresponding†functions include necessary†in-line comments†to 
ease following the algorithms through the codes. 

Below please find the content provided in each folder:

- In the "Adversarial_Environment" folder, the reader can find how 
stochastically constrained adversarial environment is generated and 
tested. 

- In the "Algorithm_1_PORO-SC" folder, the reader can find the main 
m-file and all the required functions to run PORO-SC algorithm. The 
parameters can be set according to the setting provided in the paper. 

- In the "Algorithm_2_PBOA-SC" folder, the reader can find the main 
m-file and all the required functions to run PBOA-SC algorithm: The 
parameters can be set according to the setting provided in the paper. 

## Abstract
We study a family of multi-armed bandit (MAB) problems, wherein, not only the player cannot observe the reward on the played arm (\emph{self-unaware player}), but also it incurs switching costs when shifting to a new arm.
We study two cases: 
In Case 1, at each round the player is able to either \emph{play} or \emph{observe} the chosen arm, but not both.
In Case 2, the player can choose an arm to play, and at the same round, choose another arm to observe. 
In both cases, the player incurs a (potentially time-varying) cost for consecutive arm switching due to playing or observing the arms.
We propose two novel online learning-based algorithms each addressing one of the aforementioned MAB problems.
We theoretically prove that the proposed algorithms for Case 1 and Case 2, achieve sublinear regret of $O(\sqrt[4]{KT^3\ln K})$, and $O(\sqrt[3]{(K-1)T^2\ln K})$, respectively, where the latter regret bound is order-optimal in time, $K$ is the number of arms, and $T$ is the total number of rounds.
In Case 2, we extend the player's capability to multiple $m\!>\!1$ observations and show that more observations do not necessarily improve the regret bound due to incurring switching costs.
However, we derive an upper bound for switching cost as $c\!\leq\!1/\sqrt[3]{m^2}$ for which the regret bound is improved as the number of observations increases.
Finally, through this study we found that a generalized version of our approach gives an interesting sublinear regret upper bound result of $\tilde{O}\left(T^{\frac{s+1}{s+2}}\right)$ for any self-unaware bandit player with $s$ number of binary decision dilemma before taking the action.
To further validate and complement the theoretical findings, we conduct extensive performance evaluations over synthetic data constructed by non-stochastic MAB environment simulations, and wireless spectrum measurement data collected in real-world experiment.

$e^{i \pi} = -1$


### Algorithm 1:Play-OR-Observe with Switching Costs (PORO-SC)

<img width="484" alt="Screen Shot 2021-08-05 at 9 13 04 AM" src="https://user-images.githubusercontent.com/75192031/128355829-f8b31cea-761c-471c-a406-64adc239ec67.png">

### Algorithm 2 Play-But-Observe-Another with Switching Costs (PBOA-SC)

<img width="472" alt="Screen Shot 2021-08-05 at 9 16 54 AM" src="https://user-images.githubusercontent.com/75192031/128356294-1d67aed9-69d5-4aa2-a8d0-949a4c69520d.png">
