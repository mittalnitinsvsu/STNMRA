%__________________________________________________________________________%
% Sooty Tern Naked Mole Rat Algorithm(STNMRA) source codes demo version 1.0%
%            By "Supreet Singh and Nitin Mittal"                           %
%__________________________________________________________________________%

function [NMRbest,fmin,bb]=STNMRA(function_name,n,maxiter)
display('NMRA_STOA is optimizing your problem');
[d,Fun,Ub, Lb]  = Select_Functions(function_name);
% n=50;                % colonny size of NMR
bp=0.05;

breeders=n/5;        % breeder population

% workers=n-breeders;  % worker population
iter=1;
% bp=1-iter*((1)/maxiter);              % breeding parameter
% bp=(0.95-0.4-0.2)*exp(1/(1+(2*iter)/maxiter));
for i=1:n,
    %     Lb+(Ub-Lb).*rand(1,d)
    NMRsolution(i,:)=Lb+(Ub-Lb).*rand(1,d);
    NMRfitness(i)=Fun(NMRsolution(i,:));
end
% NMRfitness=sort(NMRfitness);
% Find the current NMRbest
[fmin,I]=min(NMRfitness);
NMRbest=NMRsolution(I,:);
S=NMRsolution;
% W=zeros(n,d);

while (iter<=maxiter) % Loop over worker and breeders
    %For workers
    for i=((n/5)+1):n,
%        lambda=rand;
       % weight-6 **** Simulated Annealing Inertia weight *******
           alpha_min=0.5;%0.25;
           alpha_max=0.9; k=rand; p=0.95;
           lambda=alpha_min+((alpha_max-alpha_min)*p^(k-1));
%         lambda=2-iter*((2)/maxiter);
        % Find random NMR in the neighbourhood
        ab=randperm(n);
        L=Levy(d);
         if iter<maxiter/2
            %%%%%%%%%%%%%%%STOA%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Sa=2-iter*((2)/maxiter); 
            r1=0.5*rand();              
            X1=2*Sa*r1-Sa;  
            b=1;             
            ll=(Sa-1)*rand()+1;         
            D_alphs=Sa*(NMRsolution(i,:)+X1*(NMRbest-NMRsolution(i,:)));                   
            res=D_alphs*exp(b.*ll).*cos(ll.*2*pi)+NMRbest;
            S(i,:)=res;
         else
         %%%%%%%%%%%%%%NMRA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         S(i,:)=(NMRsolution(i,:)+L.*(NMRsolution(ab(1),:)-NMRsolution(ab(2),:)));
         end
        Fnew=Fun(S(i,:));
        % If NMRfitness improves (better NMRsolutions found), update then
        if (Fnew<=NMRfitness(i)),
            NMRsolution(i,:)=S(i,:);
            NMRfitness(i)=Fnew;
        end
        
    end
    %For Breeders
    for z=1:breeders;
        if rand>bp,
            NMRneighbours=randperm(breeders);
            S(z,:)=(1-lambda).*(S(z,:))+(lambda*(NMRbest-NMRsolution(NMRneighbours(1),:)));
            % Evaluate new NMRsolutions
            Fnew=Fun(S(z,:));
            % If NMRfitness improves (better NMRsolutions found), update then
            if (Fnew<=NMRfitness(z)),
                NMRsolution(z,:)=S(z,:);
                NMRfitness(z)=Fnew;
            end
        end
    end
    for i=1:n
            Flag4Ub=S(i,:)>Ub';
        Flag4Lb=S(i,:)<Lb';
        S(i,:)=(S(i,:).*(~(Flag4Ub+Flag4Lb)))+Ub'.*Flag4Ub+Lb'.*Flag4Lb;
    end
%     NMRfitness=sort(NMRfitness);
    [fmin,I]=min(NMRfitness);
    NMRbest=NMRsolution(I,:);
    S=NMRsolution;
%     S=(1/4)*sin(pi*S);
    bb(iter)=fmin;
    iter=iter+1;
end

function L=Levy(d)
beta=3/2;
sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
u=randn(1,d)*sigma;
v=randn(1,d);
step=u./abs(v).^(1/beta);
L=0.01*step;
