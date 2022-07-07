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
i_c=[0 0 0 0 1 0 0 0 0 0 1 0 1]; %Initial condition
x0=i_c
x_c=sum(i_c); % Sum of active/inactive nodes for the initial condition (Value between 0-13)
%% Iterative variation of parameter k
for k=0:1:300
    %% First controller u1
    % Via AP1, OR operator, transition from I1 to SE 
    i1=1;
    for tu=0:1:300
        if (tu>=0 && tu<=k)
             u1(:,i1)=1; %High level
             i1=i1+1;
        else
            u1(:,i1)=0;  %Low level
            i1=i1+1;
        end
    end
    %% Second controller u2
    % Via AP3, OR operator, transition from SE to PE1
%     i2=1;
%     for tu=0:0.01:20
%         if (tu>=0 && tu<=k)
%              u2(:,i2)=1;  %High level
%              i2=i2+1;
%         else
%             u2(:,i2)=0;
%             i2=i2+1;   %Low level
%         end
%     end
    %% Third controller u3
    % Via AG, OR operator, transition from PE1 to ST1
%     i3=1;
%     for tu=0:0.01:20
%         if (tu>=0 && tu<=k)
%              u3(:,i3)=1;  %High level
%              i3=i3+1;
%         else
%             u3(:,i3)=0;   %Low level
%             i3=i3+1;
%         end
%     end
%     
    %% Fourth controller u4
    % Via AP3, AND operator, transition from PE1 to CAR
%     i4=1;
%     for tu=0:0.01:20
%         if (tu>0 && tu<=k)
%              u4(:,i4)=0;  %Low level
%              i4=i4+1;
%         else
%             u4(:,i4)=1;  %High level
%             i4=i4+1;
%         end
%     end
    tu=0:1:300; %Active time of controller
    options = odeset('RelTol',1e-3,'AbsTol',[1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4]); %Configuration of ODE45 solver
    [T,X] = ode45(@(t,x) FOSGRN_simulation_u(t,x,tu,u1),[0 300],i_c,options); %ODE45 solver 
    x_1=X(:,1); x_2=X(:,2); x_3=X(:,3); x_4=X(:,4); x_5=X(:,5); x_6=X(:,6); x_7=X(:,7); x_8=X(:,8); x_9=X(:,9); x_10=X(:,10); x_11=X(:,11); x_12=X(:,12); x_13=X(:,13);
    X_i=[x_1 x_2 x_3 x_4 x_5 x_6 x_7 x_8 x_9 x_10 x_11 x_12 x_13];
    
    %Sum of active/inactive nodes after solvig differential equation (Value between 0-13)
    x_s=x_1(end)+x_2(end)+x_3(end)+x_4(end)+x_5(end)+x_6(end)+x_7(end)+x_8(end)+x_9(end)+x_10(end)+x_11(end)+x_12(end)++x_13(end); 
    x_c=[x_c,x_s];
    %% Visualization of solved differential equation system
%     subplot(3,5,1);
%     plot(T,X(:,1),'o-.')
%     subplot(3,5,2);
%     plot(T,X(:,2),'o-.')
%     subplot(3,5,3);
%     plot(T,X(:,3),'o-.')
%     subplot(3,5,4);
%     plot(T,X(:,4),'o-.')
%     subplot(3,5,5);
%     plot(T,X(:,5),'o-.')
%     subplot(3,5,6);
%     plot(T,X(:,6),'o-.')
%     subplot(3,5,7);
%     plot(T,X(:,7),'o-.')
%     subplot(3,5,8);
%     plot(T,X(:,8),'o-.')
%     subplot(3,5,9);
%     plot(T,X(:,9),'o-.')
%     subplot(3,5,10);
%     plot(T,X(:,10),'o-.')
%     subplot(3,5,11);
%     plot(T,X(:,11),'o-.')
%     subplot(3,5,12);
     %plot(T,X(:,6),'o-.')
%     subplot(3,5,13);
%     plot(T,X(:,13),'o-.')
      %xlim([0 30])
     %ylim([0 1])
     %pause(0.1);
end
%% Visualization of bifurcation diagram
figure
plot(x_c','o')





