clear all
clc
%% Initial conditions
%I1  =  [0 0 0 0 1 0 0 0 0 0 1 0 0]  De= 260    IM
%I2  =  [0 0 0 0 1 0 0 0 0 0 1 1 0]  De= 262    IM
%I3  =  [0 0 0 0 1 0 0 0 0 0 1 1 1]  De= 263    IM
%I4  =  [0 0 0 0 1 0 0 0 0 0 1 0 1]  De= 261    IM
%SE  =  [0 1 1 0 0 1 0 1 0 1 0 0 0]  De= 3240   FM
%PE1 =  [0 1 1 1 0 1 0 1 1 1 0 0 0]  De= 3768   FM
%PE2 =  [0 1 1 1 0 1 0 1 1 1 0 1 0]  De= 3770   FM
%ST1 =  [1 0 1 1 0 1 1 1 1 1 0 0 0]  De= 5880   FM
%ST2 =  [1 0 1 1 0 1 1 1 1 1 0 1 0]  De= 5882   FM
%CAR =  [1 0 1 0 0 1 1 1 1 1 0 0 0]  De= 5368   FM
i_c=[0     1     0     1     1     0     0     1     1     1     0     0     1]; %Initial condition
x0=i_c
x_c=sum(i_c); % Sum of active/inactive nodes for the initial condition (Value between 0-13)
%% Solving ODEs
    options = odeset('RelTol',1e-3,'AbsTol',[1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4],'MaxStep',0.01); %Configuration of ODE45 solver
    [T,X] = ode45(@(t,x) FOSGRN_simulation(t,x),[0 8],i_c,options); %ODE45 solverr 
     x_1=X(:,1); x_2=X(:,2); x_3=X(:,3); x_4=X(:,4); x_5=X(:,5); x_6=X(:,6); x_7=X(:,7); x_8=X(:,8); x_9=X(:,9); x_10=X(:,10); x_11=X(:,11); x_12=X(:,12); x_13=X(:,13);
     X_i=[x_1 x_2 x_3 x_4 x_5 x_6 x_7 x_8 x_9 x_10 x_11 x_12 x_13];
    
    %Sum of active/inactive nodes after solvig differential equation (Value between 0-7)
     x_s=x_1(end)+x_2(end)+x_3(end)+x_4(end)+x_5(end)+x_6(end)+x_7(end)+x_8(end)+x_9(end)+x_10(end)+x_11(end)+x_12(end)++x_13(end); 
     x_c=[x_c,x_s];
    
    %% Visualization of solved differential equation system
    figure
    plot(T,X(:,1),'-')
    hold on
    plot(T,X(:,2),'-')
    plot(T,X(:,3),'-')
    plot(T,X(:,4),'-')
    plot(T,X(:,5),'-')
    plot(T,X(:,6),'-')
    plot(T,X(:,7),'-')
    plot(T,X(:,8),'-')
    plot(T,X(:,9),'-')
    plot(T,X(:,10),'-')
    plot(T,X(:,11),'-')
    plot(T,X(:,12),'-')
    plot(T,X(:,13),'-')
%% Visualization of bifurcation diagram
% figure
% plot(x_c','o')