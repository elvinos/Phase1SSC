# Introduction

This report analyses the effectiveness of a using a PID controller derived in Phase 2. Before implementing the controller on the Quanser rig, the controller was first tested by placing nonlinearities into the simulation in the form of a rate limiter and saturation. Through applying the design process the new control objectives were met which could them be implemented on the Quanser rig and further refined to create a controller which met requirements. The following report discusses both the design process, results and any observations made through creating an effective controller for the Quanser rig.

The following transfer function was used taken from phase 1:

\begin{align*}
&\text{$2^{nd}$ Order: }k \cdot \frac { 1.109\cdot \frac{180} {\pi} }{ s^2 + 0.1313s +1.109 }
&&\text{$1^{st}$ Order: }k \cdot \frac { 1 }{ 15.24s +1 }
\end{align*}

Where $k = 0.26$.

# Theory Transfer Function Control Refinement

Clearly give the transfer function, control architecture and steps of the design process.
Provide a table with the controller gains obtained from the theoretical part, from the initial
tuning in Simulink, and those finally used in the Quanser.
Show the closed-loop output responses for the plant and controller. Overlay in a single plot the responses from [2] and [3] (using the same step and the same initial condition).

# Nonlinearity Simulation Control Refinement

# Quanser Controller
