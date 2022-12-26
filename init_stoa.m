%__________________________________________________________________________%
% Sooty Tern Naked Mole Rat Algorithm(STNMRA) source codes demo version 1.0%
%            By "Supreet Singh and Nitin Mittal"                           %
%__________________________________________________________________________%

function Pos=init_stoa(SearchAgents,dimension,upperbound,lowerbound)

Boundary= size(upperbound,2); 
if Boundary==1
    Pos=rand(SearchAgents,dimension).*(upperbound-lowerbound)+lowerbound;
end

if Boundary>1
    for i=1:dimension
        ub_i=upperbound(i);
        lb_i=lowerbound(i);
        Pos(:,i)=rand(SearchAgents,1).*(ub_i-lb_i)+lb_i;
    end
end