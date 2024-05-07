 # Paper Airplane Numerical Study
  Final Project: AEM 3103 Spring 2024

  - By: Daniel Tereshko & Ashton Rodgers

  ## Summary of Findings

  |Variation| Minimum| Nominal| Maximum|
  |---------|--------|--------|--------|
  | Velocity|2 m/s   |3.55 m/s| 7.5 m/s|
  | Gamma   |-0.5 rad|-0.18 rad| 0.4 rad|

  This study aimed to analyze the trajectory of a paper airplane. The data used was that for an equilibrium glide at a maximum lift/ drag ratio from the file [paperplane.m](http://www.stengel.mycpanel.princeton.edu/PaperPlane.m). There were three major findings; From figure 1, it is clear that if the plane is thrown at its maximum velocity, it will always pitch up and sometimes even flip over as seen in figure 2. The plane will also always return to trim. Lastly the plane   "Paper Airplane Flight Path" which was gathered by Robert Stengel. Summarized what was accomplished in this study.  Describe 2-4 observations from simulating the flight path.
  Reference the figures below as needed.
 
  # Code Listing
  - [EqMotion.m](EqMotion.m)
  This is a function that calculates the equations of motion of a paper plane using the four inputs: The initial velocity, flight path angle, height and range.

  - [PaperPlane.m](PaperPlane.m)
  This is the file that contains all of the code to create all of the visualizations of the paper planes motion. Works in cojunction with [EqMotion.m](EqMotion.m) to create the graphs and figures found in this study.

  # Figures

  ## Fig. 1: Single Parameter Variation
  ![Figure 1](/figures/figure1.jpg)

  The graphs above depict the trajectory of the paper airplane when varying its velocity and gamma.
  

  ## Fig. 2: Monte Carlo Simulation
  ![Figure 2](/figures/figure2.jpg)
  
  The graph above shows the trajectories of the paper airplane after 100 trials of randomly choosing a velocity and gamma value from a range of max and mins. The average trajectory is shown as a black line.

 ## Fig. 3: Time Derivatives
 ![Figure 3](/figures/figure3.jpg)
 <Time-derivative of height and range for the fitted trajectory>
  
  The graphs above show the time derivates of height and range for the average trajectory. 

  # Animation
  ## Point-Mass Animation
  ![Figure 4](/figures/figure4.gif)

  The gif above is a depiction of a comparison between the trajectories for a nominal and scenario flight.
