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
