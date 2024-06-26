%	Example 1.3-1 Paper Airplane Flight Path
%	Copyright 2005 by Robert Stengel
%	August 23, 2005

	global CL CD S m g rho	
	S		=	0.017;			% Reference Area, m^2
	AR		=	0.86;			% Wing Aspect Ratio
	e		=	0.9;			% Oswald Efficiency Factor;
	m		=	0.003;			% Mass, kg
	g		=	9.8;			% Gravitational acceleration, m/s^2
	rho		=	1.225;			% Air density at Sea Level, kg/m^3	
	CLa		=	3.141592 * AR/(1 + sqrt(1 + (AR / 2)^2));
							% Lift-Coefficient Slope, per rad
	CDo		=	0.02;			% Zero-Lift Drag Coefficient
	epsilon	=	1 / (3.141592 * e * AR);% Induced Drag Factor	
	CL		=	sqrt(CDo / epsilon);	% CL for Maximum Lift/Drag Ratio
	CD		=	CDo + epsilon * CL^2;	% Corresponding CD
	LDmax	=	CL / CD;			% Maximum Lift/Drag Ratio
	Gam		=	-atan(1 / LDmax);	% Corresponding Flight Path Angle, rad
	V		=	sqrt(2 * m * g /(rho * S * (CL * cos(Gam) - CD * sin(Gam))));
							% Corresponding Velocity, m/s
	Alpha	=	CL / CLa;			% Corresponding Angle of Attack, rad

    font = 'Lucida Bright';
%%  Step 2

%	a) Equilibrium Glide at Maximum Lift/Drag Ratio
	H		=	2;			% Initial Height, m
	R		=	0;			% Initial Range, m
	to		=	0;			% Initial Time, sec
	tf		=	6;			% Final Time, sec
	tspan	=	[to tf];
    
%   VELOCITY
%   Minimum Vel
    x0            = [2;Gam;H;R];
	[tMinV,xMinV] =	ode23('EqMotion',tspan,x0);

%   Maximum Vel
    x0            = [7.5;Gam;H;R];
    [tMaxV,xMaxV] = ode23('EqMotion',tspan,x0);

%   Nominal Vel
    x0            = [3.55;Gam;H;R];
    [tNomV,xNomV] = ode23('EqMotion',tspan,x0);

%   GAMMA
%   Minimum Gam
    x0            = [V;-0.5;H;R];
	[tMinG,xMinG] = ode23('EqMotion',tspan,x0);

%   Maximum Gam
    x0            = [V;0.4;H;R];
    [tMaxG,xMaxG] = ode23('EqMotion',tspan,x0);

%   Nominal Gam
    x0            = [V;-0.18;H;R];
    [tNomG,xNomG] = ode23('EqMotion',tspan,x0);
	
%   PLOTTING MODELS
    close
    figure
    subplot(2,1,1)  %Varying velocity plot
    plot(xMaxV(:,4),xMaxV(:,3),DisplayName='Maximum Velocity')
    hold on
    plot(xNomV(:,4),xNomV(:,3),'k--',DisplayName='Nominal Velocity')
    hold on
	plot(xMinV(:,4),xMinV(:,3),DisplayName='Minimum Velocity')
    xlabel("Range (m)");
    ylabel("Height (m)");
    title("Flight Trajectory with Varying Velocity (m/s)");
    grid on
    fontname(font)
    legend show
 
    subplot(2,1,2)  %Varying Gamma Plot
    plot(xMaxG(:,4),xMaxG(:,3),DisplayName='Maximum Gamma')
    ylim([-2,2.5]);
    hold on
    plot(xNomG(:,4),xNomG(:,3),'k--',DisplayName='Nominal Gamma')
    hold on
	plot(xMinG(:,4),xMinG(:,3),DisplayName='Minimum Gamma')
    xlabel("Range (m)");
    ylabel("Height (m)");
    title({'';'Flight Trajectory with Varying Gamma (rad)'})
    grid on
    fontname(font)
    legend show

%% Step 3 - Monte Carlo Simulation
clc
N = 100;
figure
vRange = [0 7.5];
gamRange = [-0.4 0.5];

heights = [];
ranges = [];
times = [];

color = [0 0.4470 0.7410];

for i = 1:N
    V = vRange(1) + (vRange(2) - vRange(1)) *rand(1);
    Gam = gamRange(1) + (gamRange(2) - gamRange(1)) *rand(1);
    x0 = [V;Gam;H;R];
    [t,x] =	ode23('EqMotion',tspan,x0);
    
    heights = [heights; x(:,3)];
    ranges = [ranges; x(:,4)];
    times = [times; t];
    
    plot(x(:,4),x(:,3),'Color',color,'HandleVisibility','off')
    hold on
end

%% Step 4 - Average Trajectory Through Polynomial Fit
polyRange = polyfit(times, ranges,9);
polyHeight = polyfit(times,heights,9);

plot(polyval(polyRange,t), polyval(polyHeight,t),'k','DisplayName','Average Trajectory',LineWidth=2)
xlim([0, 22]);
title("Monte Carlo Simulation of 100 Gliders")
xlabel("Range (m)")
ylabel("Height (m)")
grid on
legend show
fontname(font)
%% Step 5 - First Time Derivatives of Average Trajectory 
derRange = polyder(polyRange);
derHeight = polyder(polyHeight);

tvals = linspace(0, 6, 100);

figure

subplot(2,1,1)
plot(tvals, polyval(derHeight, tvals))
title("Derivative of Height with Respect to Time")
xlabel("Time (s)"); ylabel("dH/dt (m/s)");
grid on
fontname(font)
hold on

subplot(2,1,2)
plot(tvals, polyval(derRange, tvals))
title("Derivative of Range with Respect to Time")
xlabel("Time (s)"); ylabel("dR/dt (m/s)");
grid on
fontname(font)

%% Point-Mass Animation of Trajectory
clc
figure;

x_n = [3.55;-0.18;H;R];
[t_n,x_n] =	ode23('EqMotion',tspan,x_n);

x_s = [7.5;0.4;H;R];
[t_s,x_s] =	ode23('EqMotion',tspan,x_s);


height_n = x_n(:,3);
range_n = x_n(:,4);

height_s = x_s(:,3);
range_s = x_s(:,4);

for k = 1:length(range_s)
    if k < length(range_n)
        plot(range_n(k), height_n(k), 'b.','HandleVisibility','off',LineWidth=3)
        hold on   
        plot(range_n(1:k), height_n(1:k), 'k--','DisplayName','Nominal (v=3.55, gam=-0.18)')
        hold on
    else
        plot(range_n, height_n, 'k--','DisplayName','Nominal (v=3.55, gam=-0.18)')
        hold on
    end


    plot(range_s(k), height_s(k), 'r.','HandleVisibility','off',LineWidth=3)
    hold on

    plot(range_s(1:k), height_s(1:k), 'b','DisplayName','Scenario (v=7.5, gam=0.4)')
    hold on

    axis([0 25 -4 5])
    title('Animation of Nominal and Scenario glider')
    xlabel('Range (m)')
    ylabel('Height(m)')
    fontname(font)
    legend show
    pause(0.01)

    hold off
end


