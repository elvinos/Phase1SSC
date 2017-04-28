# Introduction

This report analyses the effectiveness of a using a PID controller derived in Phase 2 on a Quanser-rig. Before implementing the controller on the Quanser-rig, nonlinearities in the form of a rate limiter and saturation were added to the simulation. By implementing a design process,  new control objectives were met, then implemented on the Quanser-rig  The following report discusses both the design process, results and any observations made through creating an effective controller for the Quanser-rig.

The following transfer function was used to design the controller, taken from Phase 1:

\begin{align*}
&\text{$2^{nd}$ Order: }k \cdot \frac { 1.109\cdot \frac{180} {\pi} }{ s^2 + 0.1313s +1.109 }
&&\text{$1^{st}$ Order: }k \cdot \frac { 1 }{ 15.24s +1 }
\end{align*}

Where $k = 0.26$.


# Nonlinearity Simulation Control Refinement

\begin{wrapfigure}{r}{0.4\textwidth}
 \vspace{-25pt}
 \centering
  \includegraphics[trim = 0 0 0 0, clip, width=0.395\textwidth]{origcontrol.pdf}
\vspace{-10pt}
  \caption{Showing original Controller Architecture}
  \vspace{-25pt}
  \label{origcontrol}
 \end{wrapfigure}

In Quanser Control Part 3, the improved PID controller successfully met the Phase 2 requirements but failed to meet the overshoot (OS) condition for the refined controller. The PID control architecture in Figure \ref{origcontrol} from Part 2 was tested using both non-linear simulation and on the Quanser setup.

\begin{wrapfigure}{r}{0.4\textwidth}
 \vspace{-25pt}
 \centering
  \includegraphics[trim = 0 0 0 0, clip, width=0.395\textwidth]{fincontrol.pdf}
\vspace{-10pt}
  \caption{Showing Improved Controller Architecture}
  \vspace{-20pt}
  \label{fincontrol}
 \end{wrapfigure}

At this stage, the design process for the controller consisted of; extracting preliminary responses from the Quanser-rig, analysing the responses to obtain a simulated plant transfer function. The transfer function was designed to represent small changes in elevation angle, whereby purely tuning the gains, manifested a desirable response. The controller, therefore, was  built to achieve a good response in the simulation, so is susceptible to errors when translating to the real Quanser-rig.

For the controller to meet the overshoot requirement, the controller was further refined in the simulation. Through using understanding taken from Phase 2, shown in Table \ref{paramtab}, gains were modified to improve the results further. Starting with the integrator gain ($K_i$), which had the greatest effect on reducing the steady-state error, this was increased by an increment, until the transfer function response began to deteriorate. $K_i$ had only a small range in which the response could be altered without degrading the results; suggesting that the original $K_i$ value was a good fit. Maximising $K_i$ first, meant that the effects of varying derivative gain ($K_d$) on the steady state would be minimised. A similar process was followed for then the proportional gain ($K_p$) and $K_d$, where $K_p$ was maximised to reduce the rise time ($T_R$) and $K_d$ was optimised to reduce the overshoot $OS$. Maximising these values, helped improve the performance characteristics without heavily deteriorating other properties.

\begin{wrapfigure}{l}{0.42\textwidth}
 \vspace{-25pt}
\centering
\captionof{table}{Effect of Increasing PID Gains on Objectives}
\vspace{-5pt}
 \includegraphics[trim = 0 0 0 0, clip, width=0.419\textwidth]{tableobj.pdf}
 \vspace{-25pt}
 \label{paramtab}
 \end{wrapfigure}

To test the controller performance more vigorously, the PID was run in a new simulation, with non-linearities added; in the form of a rate limiter and saturation block. A rate limiter block limits the speed of change of the signal, and the saturation represents a limit in amplitude. This new simulation would improve the accuracy of emulation to expected Quanser response. A marginal change could be seen when comparing the results of the non-linear simulation to the original, where overshoot would increase slightly. Further experimentation found that increasing gain values by an order of magnitude, destabilised the results revealing much greater non-linear effects; further confirming that the PID gains selected, fell within an acceptable region. With a small additional tweaking following the same design process, the final gain values are shown in in Table \ref{gains} met the requirements of the Phase 3 design characteristics.

\begin{wrapfigure}{r}{0.255\textwidth}
\vspace{-30pt}
 \centering
  \captionof{table}{Showing Controller Gain Values Used}
 \includegraphics[trim = 0 0 0 0, clip, width=0.254\textwidth]{gains2.pdf}
 \label{gains}
\vspace{-20pt}
 \end{wrapfigure}

Figure \ref{fincontrol} shows the original controller configuration utilised the numerical Simulink derivative block within the PID controller. It was found that the control architecture could also be improved for the actual control rig.  Using the derivative as output directly `y_elevdot` from the Quanser - it was expected that the numerical derivative block would not be as representative of the observed rate of change as the actual derivative output. This view was confirmed by the improved experimental results from provisional testing on the Quanser-Rig. The difference in architecture was unobservable in simulation, highlighting a noticeable difference between real and simulated output data.

# Quanser Controller Refinements

After satisfying the desired requirements in the non-linear simulation, the controller tests were conducted on the Quanser-rig. The controller performed well, meeting the desired requirements, where a small improvement in overshoot could be observed from the simulation. Due sampling errors small deviations from the steady state could be seen (see \ref{quanscomp}) of $\pm 0.4$\% could be seen from elevation angle. As the sampling rate was limited by the sensors on the Quanser, results appeared jagged, reducing the precision of the results; this was small enough, results to be accurate enough at representing the response of the Quanser.

# Results

\begin{figure}[H]
 \centering
 \includegraphics[trim = 0 0 0 0, clip, width=0.6\textwidth]{quanscomp.eps}
\caption{Showing Difference in Original and Improved Controller Performance on Quanser Response}
 \label{quanscomp}
 \end{figure}

 \begin{figure}[H]
\centering
\begin{minipage}{.49\textwidth}
\centering
\includegraphics[trim = 0 0 0 0, clip, width=1\textwidth]{origresult.eps}
\caption{Showing Difference in Original Controller Performance Comparing Simulated and Quanser Responses}
\label{origresult}
\end{minipage}
\hfill
\begin{minipage}{.49\textwidth}
\centering
\includegraphics[trim = 0 0 0 0, clip, width=1\textwidth]{improvresult.eps}
\caption{Showing Difference in Improved Controller Performance Comparing Simulated and Quanser Responses}
\label{improvresult}
\end{minipage}
\vspace{-20pt}
\end{figure}

 \begin{table}[H]
 \centering
 \caption{Showing Controller Response Results for Simulation and Quanser Tests}
 \includegraphics[trim = 0 0 0 0, clip, width=0.65\textwidth]{resultstab2.pdf}
 \label{resultstab}
 \end{table}

# Discussion

Figure \ref{quanscomp} highlights the experimental difference between the original tuned PID controller (taken directly from Part 2) and the iteratively improved, (with an alternative architecture ) PID controller. The improved Quanser response displayed a rise time of 2.18 seconds, settling time of 2.18 seconds (as the 4% error limits were satisfied at the same time as the rise time), an Overshoot of 0.48% and a negligible steady state error. These values comfortably satisfied the required objectives and also improving upon the desired objectives shown in Table \ref{resultstab}.  The improved controller showed a faster rise time, settling time and reduced overshoot % over the original controller design. In an engineering context, it is critical that the controller response is sharp and responsive, minimising delay times. Observing the step input time in Figure \ref{quanscomp}, it is evident that the choice of the controller effects the delay/error when the Step response. The Quanser was allowed to settle to a reasonable level before the step input was tested, but the original controller showed larger settling oscillations, this likely contributed towards the amplitude and phase error displayed in \ref{origresult} between the simulated Quanser response and the experimental Quanser response. This observation is also reinforced by Figure \ref{improvresult} as the Simulink step input shows less delay. Errors introduced from oscillations never settling completely, also imply that when the step was applied, the response was likely mid oscillations,  adding the step response. This effect is likely to be present in real world rotatory wing aircraft; the design parameters were estimated conservatively to meet the requirements in any case.  


The idealisation of the elevator actuation could also be observed when comparing the simulation to real world response. It was assumed that no physical limitations are in place on the system. Realistically, this may be misrepresenting the physical actuator, likely introducing errors in the form of actuator delay.  

The results presented above highlight the step response for the tuned PID controller for a step input of,  chosen as the transfer function was derived from experimental results of elevator angle step changes between -2 and 2. It is expected that for step inputs out of this range, the tuned controller will perform sub-optimally; accurate near the 'fix-point' and showing deviations at higher step inputs.

\begin{wrapfigure}{r}{0.45\textwidth}
\vspace{-10pt}
\centering
 \includegraphics[trim = 0 0 0 0, clip, width=0.45\textwidth]{ampresmark.pdf}
\vspace{-5pt}
\caption{Showing Magnitude of Rate Response}
 \vspace{-20pt}
 \label{ampres}
\end{wrapfigure}

The Quanser experiment was set in a reasonably controlled 'lab' environment with few assumed non-linearities, and hence the PID was designed with the assumption of weak non-linearities. A simple tuning process was only needed to meet the specified requirements, which resulted in a good response. In more complex engineering applications, the system in question may display a larger number of non-linear effects. This may be accounted for using the method of gain scheduling. Gain Scheduling \cite{stackcont} achieves control of a non-linear system by linearising the problem at various operation states; resulting in a "family" of PID controllers which will each respectively activate when a certain operation state is achieved. Each of these PID controllers must be tuned independently to optimise for their respective linearisation. The design then switches between each of these models to achieve the "best response" for the current state. More conclusively, within limits of this study, the obtained tuned PID controller for the Quanser is effective and meets the desired time domain requirements. For further accuracy of either Quanser control or more complex systems; additional control structures should be considered, particularly if the controller should encompass less stable operations such as take-off and landing.

In an aircraft control context, the control parameters may be altitude or Mach.

# Conclusions


This experiment has been a useful exercise in illustrating methods and common pitfalls when transferring a theoretically functioning tuned PID controller to a real world system.  Predicting the Quanser response using a non-linear simulation, allows for a good controller to be created but exact characteristics are difficult to predict without real experimentation and testing. Further controller refinement is therefore required when transferring to the real system, using the simulation as a method of getting close to the answer. It was interesting to note that the real world response always varied from the expected simulations for every tested tuned PID controller and configuration - this difference is likely an artefact of the non-linearities present in the Quanser-rig.
