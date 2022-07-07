function [dxi]=FOSGRN_simulation_u(t,x,tu,u1,u2,u3,u4)
%% Initial parameters
h=15;
dxi=zeros(13,1); 
w_x=zeros(13,1);
% Initial conditions for each node
AG=x(1);
AP1=x(2);
AP2=x(3);
AP3=x(4);
EMF1=x(5);
FT=x(6);
FUL=x(7);
LFY=x(8);
PI=x(9);
SEP=x(10);
TFL1=x(11);
UFO=x(12);
WUS=x(13);
%% Interpolation between tu of controller and t of the solver since u is a time-dependant paramater
u1= interp1(tu,u1,t);
u2= interp1(tu,u2,t);
u3= interp1(tu,u3,t);
u4= interp1(tu,u4,t);

%% Transformation of Boolean equations into continuos equations
% Continuos equation to gene AG
% w_x(1)=(LFY*(1-EMF1)*(1-((AP1*AP2*(1-WUS))*(1-AG*SEP*(1-TFL1))))...
%         +(1-EMF1)*(1-TFL1)*(1-AP2)-(LFY*(1-EMF1)*(1-((AP1*AP2*(1-WUS))...
%         *(1-AG*SEP*(1-TFL1)))))*((1-EMF1)*(1-TFL1)*(1-AP2)));
%     
% Continuos equation to gene AG and controller u3    
f_w_x1=(LFY*(1-EMF1)*(1-((AP1*AP2*(1-WUS))*(1-AG*SEP*(1-TFL1))))...
        +(1-EMF1)*(1-TFL1)*(1-AP2)-(LFY*(1-EMF1)*(1-((AP1*AP2*(1-WUS))...
        *(1-AG*SEP*(1-TFL1)))))*((1-EMF1)*(1-TFL1)*(1-AP2)));
w_x(1)= f_w_x1+u3-f_w_x1*u3; 

% Continuos equation to gene AP1
% w_x(2)=(1-AG)*(1-TFL1*(1-LFY*FT));

% Continuos equation to gene AP1 and controller u2
f_w_x2=(1-AG)*(1-TFL1*(1-LFY*FT));
w_x(2)=(f_w_x2+u1-f_w_x2*u1);

% Continuos equation to gene AP2
w_x(3)=1-TFL1;

% Continuos equation to gene AP3
% w_x(4)=(LFY*UFO)+(PI*SEP*AP3*(AG+AP1-AG*AP1))-(LFY*UFO)*(PI*SEP*AP3*(AG+AP1-AG*AP1));

% Continuos equation to gene AP3 and controller u2 and u4
f_w_x4=(LFY*UFO)+(PI*SEP*AP3*(AG+AP1-AG*AP1))-(LFY*UFO)*(PI*SEP*AP3*(AG+AP1-AG*AP1));
w_x(4)=(f_w_x4+u2-f_w_x4*u2)*u4;

% Continuos equation to gene EMF1
w_x(5)=(1-LFY);

% Continuos equation to gene FT
w_x(6)=1-EMF1;

% Continuos equation to gene FUL
w_x(7)=(1-AP1)*(1-TFL1);

% Continuos equation to gene LFY
w_x(8)=1-EMF1*TFL1;

% Continuos equation to gene PI
w_x(9)=(LFY*(AG+AP3-AG*AP3))+(PI*SEP*AP3*(AG+AP1-AG*AP1))-(LFY*(AG+AP3-AG*AP3))...
       *(PI*SEP*AP3*(AG+AP1-AG*AP1));
   
% Continuos equation to gene SEP
w_x(10)=LFY;

% Continuos equation to gene TFL1
w_x(11)=(1-AP1)*(1-LFY)*EMF1;

% Continuos equation to gene UFO
w_x(12)=UFO;

% Continuos equation to gene WUS
w_x(13)=WUS*(1-AG*SEP);


%% ODE's system
dxi(1)=1/(1+exp(-h*(w_x(1)-0.5)))-x(1);
dxi(2)=1/(1+exp(-h*(w_x(2)-0.5)))-x(2);
dxi(3)=1/(1+exp(-h*((w_x(3)-0.5))))-x(3);
dxi(4)=1/(1+exp(-h*(w_x(4)-0.5)))-x(4);
dxi(5)=1/(1+exp(-h*(w_x(5)-0.5)))-x(5);
dxi(6)=1/(1+exp(-h*((w_x(6)-0.5))))-x(6);
dxi(7)=1/(1+exp(-h*(w_x(7)-0.5)))-x(7);
dxi(8)=1/(1+exp(-h*(w_x(8)-0.5)))-x(8);
dxi(9)=1/(1+exp(-h*(w_x(9)-0.5)))-x(9);
dxi(10)=1/(1+exp(-h*((w_x(10)-0.5))))-x(10);
dxi(11)=1/(1+exp(-h*(w_x(11)-0.5)))-x(11);
dxi(12)=1/(1+exp(-h*(w_x(12)-0.5)))-x(12);
dxi(13)=1/(1+exp(-h*(w_x(13)-0.5)))-x(13);