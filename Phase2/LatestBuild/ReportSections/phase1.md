# Introduction

This report analyses the effectiveness of a using a PID controller derived in Phase 2 on a Quanser-rig. Before implementing the controller on the Quanser-rig, nonlinearities in the form of a rate limiter and saturation were added to the simulation. By implementing a design process,  new control objectives were met, then implemented on the Quanser-rig  The following report discusses both the design process, results and any observations made through creating an effective controller for the Quanser-rig.

The following transfer function was used to design the controller, taken from Phase 1:

\begin{align*}
&\text{$2^{nd}$ Order: }k \cdot \frac { 1.109\cdot \frac{180} {\pi} }{ s^2 + 0.1313s +1.109 }
&&\text{$1^{st}$ Order: }k \cdot \frac { 1 }{ 15.24s +1 }
\end{align*}

Where $k = 0.26$.


# Nonlinearity Simulation Control Refinement

\begin{wrapfigure}{r}{0.45\textwidth}
 \vspace{-10pt}
 \centering
  \includegraphics[trim = 0 0 0 0, clip, width=0.449\textwidth]{origcontrol.pdf}
\vspace{-5pt}
  \caption{Showing original Controller Architecture}
  \vspace{-20pt}
  \label{origcontrol}
 \end{wrapfigure}

In Quanser Control Part 3, the improved PID controller successfully met the Phase 2 requirements but failed to meet the overshoot (OS) condition for the refined controller. The PID control architecture in Figure \ref{origcontrol} from Part 2 was tested using both non-linear simulation and on the Quanser setup.

\begin{wrapfigure}{r}{0.45\textwidth}
 \vspace{-10pt}
 \centering
  \includegraphics[trim = 0 0 0 0, clip, width=0.449\textwidth]{fincontrol.pdf}
\vspace{-5pt}
  \caption{Showing Improved Controller Architecture}
  \vspace{-20pt}
  \label{fincontrol}
 \end{wrapfigure}

At this stage, the design process for the controller consisted of; extracting preliminary responses from the Quanser-rig, analysing the responses to obtain a simulated plant transfer function. The transfer function was designed to represent small changes in elevation angle, whereby purely tuning the gains, manifested a desirable response. The controller, therefore, was  built to achieve a good response in the simulation, so is susceptible to errors when translating to the real Quanser-rig.

For the controller to meet the overshoot requirement, the controller was further refined in the simulation. Through using understanding taken from Phase 2, shown in Table \ref{paramtab}, gains were modified to improve the results further. Starting with the integrator gain ($K_i$), which had the greatest effect on reducing the steady-state error, this was increased by an increment, until the transfer function response began to deteriorate. $K_i$ had only a small range in which the response could be altered without degrading the results; suggesting that the original $K_i$ value was a good fit. Maximising $K_i$ first, meant that the effects of varying derivative gain ($K_d$) on the steady state would be minimised. A similar process was followed for then the proportional gain ($K_p$) and $K_d$, where $K_p$ was maximised to reduce the rise time ($T_R$) and $K_d$ was optimised to reduce the overshoot $OS$. Maximising these values, helped improve the performance characteristics without heavily deteriorating other properties.

To test the controller performance more vigorously, the PID was run in a new simulation, with non-linearities added; in the form of a rate limiter and saturation block. A rate limiter block limits the speed of change of the signal, and the saturation represents a limit in amplitude. This new simulation would improve the accuracy of emulation to expected Quanser response. A marginal change could be seen when comparing the results of the non-linear simulation to the original, where overshoot would increase slightly. Further experimentation found that increasing gain values by an order of magnitude, destabilised the results revealing much greater non-linear effects; further confirming that the PID gains selected, fell within an acceptable region. With a small additional tweaking following the same design process, the final gain values are shown in in Table \ref{gains} met the requirements of the Phase 3 design characteristics.

Figure \ref{fincontrol} shows the original controller configuration utilised the numerical Simulink derivative block within the PID controller. It was found that the control architecture could also be improved for the actual control rig.  Using the derivative as output directly `y_elevdot` from the Quanser - it was expected that the numerical derivative block would not be as representative of the observed rate of change as the actual derivative output. This view was confirmed by the improved experimental results from provisional testing on the Quanser-rig. The difference in architecture was unobservable in simulation, highlighting a noticeable difference between real and simulated output data.

 \begin{figure}[H]
\begin{center}
\begin{minipage}{.45\textwidth}
\vspace{-10pt}
\centering
\caption{Effect of Increasing PID Gains on Objectives}
\vspace{-5pt}
 \includegraphics[trim = 0 0 0 0, clip, width=1\textwidth]{tableobj.pdf}
 \vspace{-20pt}
 \label{paramtab}
\end{minipage}
\hfill
\begin{minipage}{.255\textwidth}
\centering
  \caption{Showing Controller Gain Values Used}
 \includegraphics[trim = 0 0 0 0, clip, width=1\textwidth]{gains2.pdf}
 \label{gains}
\end{minipage}
\end{center}
\vspace{-20pt}
\end{figure}# Quanser Controller Refinements
After satisfying the desired requirements in the simulated response, the controller was tested on the Quanser rig. It was found that the controller performed well, meeting the desired requirements, where a small improvement in overshoot was noticed. Due sampling errors small deviations from the steady state could be seen  (see \ref{quanscomp}) of $\pm 0.4$\% could be seen from elevation angle. As the sampling rate was limited by the sensors on the Quanser, results appeared jagged, reducing the precision of the results; this was great enough however, for the general trends to be seen.

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

The original controller design did not satisfy these requirements so it was decided to tune the PID further.  Figure \ref{quanscomp} highlights the experimental difference between the original tuned PID controller (as taken directly from Part 2 after non linear simulation) and the iteratively improved, tuned (alternative architecture ) PID controller. The improved Quanser response displayed a rise time of 2.18 seconds, settling time of 2.18 seconds (as the 4% error limits were satisfied at the same time as the rise time), a Overshoot of 0.48% and a negligible steady state error. These values comfortably satisfied the required objectives of 6s, 5s, 15% and 0% respectively and also improved upon and satisfied the desired objectives of 4s, 10s, 5% and 0%.  The improved controller showed a faster rise time, faster settling time and greater overshoot % over the original controller design. In an engineering context, it is critical the response to controller input is as sharp and responsive as possible and the improved controller achieves this to a greater accuracy. Observing the step input time more closely it can be seen that the choice of controller also effects the delay/error when the step kicks in. The Quanser was allowed to settle to a reasonable level before the step input was tested, but the original controller showed larger settling oscillations, this likely  contributed towards the amplitude and phase error displayed in \ref{origresult} between the simulated Quanser response and the experimental Quanser response. This observation is also reinforced by Figure \ref{improvresult} as the 'perfect' simulink step input shows less delay.


A key assumption in place during transfer from simulation to real world response was the idealisation of the elevator actuation, this is with the assumption that no physical limitations are in place. Realistically, this may be misrepresenting the physical actuator and likely introduced error through the form of actuator delay.  The results presented above highlight the step response for the tuned PID controller for a step input of 2 , this value was chosen as the design process was derived from experimental results with a -2 to 2 step input range. It was expected that for steps higher than this range (although the PID controller may function correctly for these inputs) the derived transfer function was not completely representative of higher step input responses. To summarise, it was expected the system will be accurate near the near the 'fix-point' and potentially show deviations at higher step inputs. Additionally it is important to note that the Quanser was allowed to settle to account for unknown nonlinearities during start up, however an error is introduced here due oscillations never really settling completely to zero, this implied when the step 'kicked' in the response was likely mid oscillations - hence the step response was added to this. As this effect is likely present in real world rotatory wing aircraft, the design parameters were estimated conservatively to meet the requirements in any case.  

\begin{wrapfigure}{r}{0.45\textwidth}
\vspace{-10pt}
\centering
 \includegraphics[trim = 0 0 0 0, clip, width=0.45\textwidth]{ampresmark.pdf}
\vspace{-5pt}
\caption{Showing Magnitude of Rate Response}
 \vspace{-20pt}
 \label{ampres}
\end{wrapfigure}

The Quanser experiment was set in a reasonably controlled 'lab' environment with few assumed non linearities  ( as discussed previously  ) and hence the PID was designed with the assumption of "weak non linearities". This resulted in a fairly simple tuning process to meet the specified requirements and resulted in a 'good' response. However, for further, more complex engineering applications - the system in question may display a larger number of non linear effects. This may be accounted for using the method of gain scheduling. Gain Scheduling \cite{stackcont} achieves control of a non linear system by linearising the problem at various operation states; resulting in a "family" of PID controllers which will each respectively activate when a certain operation state is achieved. Each of these PID controllers must be tuned independently to optimise for their respective linearisation. The design then switches between each of these models to achieve the "best response" for the current state. More conclusively, within limits of this study - the obtained tuned PID controller for the Quanser is effective and meets the desired time domain requirements. For further accuracy of either Quanser control, or more complex systems; additional control structures should be considered.


In an aircraft control context, the control parameters may be altitude or Mach.

# Conclusions


This experiment has been a useful exercise in illustrating common pitfalls, and behaviour  transferring a theoretically functioning tuned PID controller to a real world system.  Whist it was difficult to initially predict the Quanser response using the provided SIMULINK non linear simulation, further Quanser analysis allowed for re-tunign of gains to the given final values. It was interesting to note that the real world response always varied from the expected simulations for every tested tuned PID controller and configuration - this difference is likely an artefact of the  non linearities present.
