%__________________________________________________________________________%
% Sooty Tern Naked Mole Rat Algorithm(STNMRA) source codes demo version 1.0%
%            By "Supreet Singh and Nitin Mittal"                           %
%__________________________________________________________________________%

clc;
clear all;
close all;
%% Parameters setting
SearchAgents_no =50;
Max_iteration=300;
for iji=10;%2:1:10
    if iji==1;F=('cec01');elseif iji==2;F=('cec02');elseif iji==3;F=('cec03');elseif iji==4;F=('cec04');elseif iji==5;F=('cec05'); ...
     elseif iji==6;F=('cec06');elseif iji==7; F=('cec07'); elseif iji==8; F=('cec08');elseif iji==9; F=('cec09'); ... 
     elseif iji==10; F=('cec10');
     end
function_name=F;%'cec02'; % Name of the test function that can be from F1 to F19 and cec01 t0 cec10 (Table 1,2 in the paper)
disp(function_name);
no_of_runs=51;

 %% STNMRA%%%%%%%%%%%%%%%%%%%%%
cg_curve_STNMRA=zeros(no_of_runs,Max_iteration);
Best_pos_STNMRA=[];
Best_score_STNMRA=zeros(1,no_of_runs);
std_STNMRA=[];
for j=1:1:no_of_runs
[Best_pos_STNMR,Best_score_STNMR,cg_curv_STNMR]=STNMRA(function_name,SearchAgents_no,Max_iteration);
cg_curve_STNMRA(j,:)=cg_curv_STNMR;
Best_pos_STNMRA(j,:)=Best_pos_STNMR;
Best_score_STNMRA(1,j)=Best_score_STNMR;
end
a_STNMRA=sum(cg_curve_STNMRA);
b_STNMRA=(a_STNMRA/no_of_runs);
sorted_STNMRA=sort(Best_score_STNMRA);
Best_STNMRA=sorted_STNMRA(1);
Worst_STNMRA=sorted_STNMRA(:,end);
avg_STNMRA=mean(Best_score_STNMRA);
median_STNMRA=median(Best_score_STNMRA);
std_STNMRA=std(Best_score_STNMRA);
Output_STNMRA=[Best_STNMRA Worst_STNMRA avg_STNMRA median_STNMRA std_STNMRA]
end
