%% Initialization
clear all; clc;
k = 2; % Fixing logical variables as two values ones.
ME = lme(k); % equivalence matrix
MI = lmi(k); % inequivalence matrix 
MD = lmd(k); % OR matrix
MN = lmn(k); % NOT matrix
MR = lmr(k); % reduction power matrix
MC = lmc(k); % AND matrix
MU = lmu(k); % dummy matrix
MX = lm([2 1 1 2], 2); % xor
A=textscan(fopen('FOS_GRN.txt'),'%s %s','Delimiter',',');
Genes=A{1}';
Number_Of_Genes=size(Genes,2);
options = lmset('vars',Genes); % Defining the vector of logical variables
%% Attractors and its transition matrix of non-controlled network
[expr,vars]=GetAttractors(A{2},options,k,ME,MI,MD,MN,MR,MC,MU,MX); % Get attractors from uploaded txt
L=ctimes(expr{:}); % Get transition matrix from uploaded matrix from uploaded txt
[n,l,c,r0,T] = bn(L,k);
[Att_Land,Att_Land_size]=ShowAttractors(L,k); % Get and show attractors //Check ShowAttractors function
[Basins,Basins_size]=GetBasin(L,r0,Att_Land,Number_Of_Genes,Att_Land_size);
