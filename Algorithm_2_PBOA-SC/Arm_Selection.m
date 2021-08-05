function index = Arm_Selection(p)
% This function returns the index of the arm to be played by the player.
p(length(p)+1)= 0 ;
[p_prim,dim] = sort(p) ;
d = rand ;
s = sum( d > cumsum(p_prim) ) ;
index = dim(s+1) ;  % The arm selected to be played.
end