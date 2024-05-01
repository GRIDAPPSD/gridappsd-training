## Functional Specification: Combined Solution Centralized Deconfliction Service

<ul>
<li>Last updated: May 1, 2024</li>
<li>Author: Gary Black</li>
</ul>

**1.**     ***Deconfliction Service (aka, Deconfliction Pipeline) Workflow***

**1.1.**   **Setpoint Processor**

1.1.1. Compiles setpoint requests into the ConflictMatrix data structure. Note there may be the potential for a “don’t-care” status for a device rather than a setpoint value. The ConflictMatrix is updated as soon as a new setpoint request is made so that it is always up-to-date.

1.1.2. Every setpoint request message is processed through the workflow to resolution. This may or may not result in setpoints being dispatched to devices.

1.1.3. Design rationale: Since every setpoint request from every app will trigger the deconfliction methodology, this will potentially lead to as many deconflictions being done per a given timestamp as there are apps, subject to the frequency each app is requesting new setpoints.  While this might be considered inefficient to do many deconflictions “on top of each other” for a timestamp, it is central to the design. Given the inherent uncertainty in apps making setpoint requests, there is no way to predict anything beyond setpoint requests that have arrived.

**1.2.**   **Feasibility Maintainer**

1.2.1. Ensures the ConflictMatrix includes only feasible setpoints. Infeasible setpoints exceed physical or impose device limits. The Feasibility Maintainer may reject or modify values in the ConflictMatrix.

1.2.2. The Feasibility Maintainer constrains setpoints requests to hardware/device physical limits.  It is a simple set of constraints that are applied that updates the ConflictMatrix insuring all setpoint requests are feasible.

1.2.3. The first two steps of the deconfliction pipeline, Setpoint Processor and Feasibility Maintainer, are considered the “problem setup” part of the workflow.  The Deconflictor is considered the “problem solution”.  These first three steps all deal with the ConflictMatrix. The final two steps, Setpoint Validator and Device Dispatcher, are considered “resolution disposition” as they deal with the ResolutionVector.

**1.3.**   **Deconflictor**

1.3.1. Uses ConflictMatrix to create ResolutionVector through application of a deconfliction methodology. The deconflictor may exchange contextual information using GridAPPS-D platform messages with applications such as Deconfliction Signals (e.g., coordination or incentive signals), the current ConflictMatrix, the current ResolutionVector, App Status, and/or App Metrics.

1.3.2. An architectural separation between the pipeline and the specific deconfliction methodology will exist so that different methodologies can be easily swapped in. For instance, during initial development before staged deconfliction is implemented, the methodology may simply average the setpoint request values for a device to produce the resolution.

1.3.3. Because this separation is just for breaking up the development of the deconfliction service, it may be rudimentary rather than separate processes. A swappable Python class is a likely design as used in the FY23 deconfliction pipeline prototype.

1.3.4. Three pieces of data that are passed from the pipeline to the methodology and then back from the methodology to the pipeline to perform deconfliction are:

<ol>
<li>ConflictMatrix</li>
<li>Set-point request that triggered the deconfliction (includes not only the device/value pairs, but also the name of the app making the request and the timestamp for which it is being made). This can be used during the deconfliction step to examine just the setpoint requests that have been introduced since the last time deconfliction was performed.</li>
<li>ResolutionVector</li>
</ol>

1.3.5. The pipeline will always invoke the deconfliction methodology and the methodology will determine if there is a conflict and must produce a ResolutionVector as output from the Deconflictor step even if there is no newly introduced conflict.

**1.4.**   **Setpoint Validator**

1.4.1. Ensures that final setpoints in the ResolutionVector are consistent with operational requirements (e.g., safety or regulatory). If setpoints are not consistent, automatic (or operator) intervention is taken. For the deconfliction service likely only automatic intervention will be supported.

1.4.2. The Setpoint Validator implementation may be similar to the Feasibility Maintainer.  They operate on different data structures, but how rules are specified and applied will likely be the same.

**1.5.**   **Device Dispatcher**

1.5.1. Compares ResolutionVector to operational values of setpoints and issues platform-level control commands (i.e., CIM “DifferenceBuilder” messages) when needed.  For some devices like transformers a change to a tap position will cause a control command to be issued.  For other devices like batteries any non-zero value will cause a control command to be issued.

**2.**       ***Deconfliction Service Data Structures***

**2.1.**   **ConflictMatrix**

2.1.1. Dictionary of the most recent setpoint requests for each application making requests across all devices for which there have been requests. The timestamp for each device request for each app is also stored in ConflictMatrix.

2.1.2. The representation for the ConflictMatrix is a dictionary of dimension two with “device” as the first dimension and “app” as the second dimension, i.e., ConflictMatrix\[device\]\[app\].  Then the value for each entry is a tuple of dimension two with the first value being the timestamp and the second being the set-point value, i.e., ConflictMatrix\[device\]\[app\] = (timestamp, setpoint). This captures all possible information that the deconfliction methodology can utilize at its discretion.

2.1.3. The ConflictMatrix is a living data structure throughout the first three steps of the workflow.  Each step potentially modifies the ConflictMatrix.  The state of the ConflictMatrix at each step will be logged and it is possible that copies of the ConflictMatrix after different steps are created should they be needed for subsequent workflow steps.

2.1.4. Timestamp related notes:
<ul>
<li>ConflictMatrix maintains timestamps to give the deconfliction methodology knowledge of how “fresh” vs. “stale” this setpoint request for a device is. It could be the request was from the very beginning of a simulation and that the app failed to send any further requests (perhaps it died/exited) at least for that specific device. A stale setpoint request for a device based on an old timestamp would be a strong indication to the deconfliction method to discount if not completely disregard it when determining a deconflicted setpoint given how much might have changed in the current operational state since the setpoint request was made.</li>
<li>It is easily possible that new setpoint requests are associated with timestamps that are prior to timestamps that have already been processed. Some apps may take much longer to generate setpoint requests than other apps. It is imperative that the deconfliction service process these “out of timestamp order” requests since discarding them could mean entirely ignoring some apps just based on them taking longer to generate requests.</li>
</ul>

**2.2.**   **ResolutionVector**

2.2.1. Dictionary of the most recent deconflicted (resolved) setpoints for each device.

2.2.2. The representation for the ResolutionVector is a dictionary of dimension one with “device” as the dimension, i.e., ResoutionVector\[device\]. Then the value for each is a tuple of dimension two with the first value being the timestamp and the second being the deconflicted set-point value, i.e., ResolutionVector\[device\] = (timestamp, setpoint). The timestamp value is set to the “most recent” timestamp used to determine the deconflicted setpoint for all apps for the device.

2.2.3. Like ConflictMatrix, ResolutionVector is also a living data structure in that the Setpoint Validator may modify it.

**3.**       ***Deconfliction Methodology Stages***

**3.1.**   **Overview**

3.1.1. The first stage is applying rules that can be implemented as direct heuristics or constraints on an optimization problem. Initially device control budgets are used to reduce the size of the solution space by constraining system setpoints to those that will not result in accelerated degradation of physical assets through frequent control actions and oscillating setpoints. System operation rules additionally constrain the solution space by eliminating setpoints that result in violations of system limits or operational best practices. The second stage is facilitating cooperation starting with status signals that are shared with or among applications such that they could update their desired setpoints based on the evolving context. A mediator process incentivizes applications to come to a cooperative solution. The third stage is a fallback to a setpoint-informed optimization problem over any remaining conflict after the previous stages have been applied.

**3.2.**   **Rules & Heuristics**

3.2.1. For the full Rules & Heuristics deconfliction methodology a solution is chosen based on a set of predictive snapshot power flows used to calculate ranked utility function decision criteria formed from system-level objectives and optionally shared app objectives.

3.2.2. For the Centralized Deconfliction Service Rules & Heuristics stage of deconfliction, rules for systems operations, asset health, and budgetary controls will be applied. No predictive snapshot power flows will be utilized.

3.2.3. During the application of rules, the priority of each application and preference given to each setpoint may be used as weighting criteria for a heuristic solution.

3.2.4. The results of the Rules & Heuristics deconfliction step results will be an updated ConflictMatrix.  Any setpoint requests not meeting the rules applied will be modified making them fall within rules.

**3.3.**   **Cooperation**

3.3.1. Aims to enable applications to mitigate conflicting operational preferences through mutual coordination. This can be achieved through exchanging contextual information (deconfliction signals) among applications or through additional system-driven incentives.  Context and cooperation among applications can be realized through several methods including game theory (cooperative decision-making through strategic interaction models) and MCDM techniques (combining conflicting goals and evaluating multiple conflicting criteria to achieve informed decision making).

3.3.2. For the full Cooperation deconfliction methodology, cooperative game theory strategy based on a combination of press, compensate, advise, and ignore contextual signals is applied. These signals drive applications to agree on a solution cooperatively through a mediator.

3.3.3. For the Centralized Deconfliction Service Cooperation stage of deconfliction a mediator will use context signals to facilitate cooperation between apps.

3.3.4. The results of the Cooperation deconfliction stage will be an updated ConflictMatrix, analogous to the Rules & Heuristics stage. The cooperation stage itself is iterative and will update the ConflictMatrix during iteration as the conflict between setpoints is reduced. Iteration will terminate when the reduction in conflict between iterations falls below a threshold value over all devices with conflicting setpoints.

3.3.5. The information exchanged between the mediator and apps has not been finalized. It may include the complete or a reduced version of the ConflictMatrix.

3.3.6. Setpoint requests for an app potentially have been modified before the Cooperation stage of deconfliction has begun through the Feasibility Maintainer and Rules & Heuristics stage of the Deconflictor. Further, previous iterations of the Cooperation Stage will also modify app setpoint requests. Apps must accept these current values as a starting point with any subsequent changes not “backtracking” from the current point contrary to mediator incentives.

**3.4.**   **Optimization**

3.4.1. For optimization, minimally applications provide only setpoints for devices they aim to control while at the other end of the complexity spectrum applications provide their full internal objectives and constraints.  For the former conflicts are resolved by minimizing the distance between the ResolutionVector and the set of application setpoint vectors. For the latter, multi-objective optimization techniques are used to form a single system-level objective. This objective is augmented to a system-level optimization problem through the aggregation of constraints provided by different applications with system-level constraints.

3.4.2. Combines setpoints and/or objective functions of each application into a global optimization. For example, the problem can be solved using utility functions supplied by each application with varying weights applied to each optimization goal shared by the applications.

3.4.3. For the Centralized Deconfliction Service, an algebraic formulation for the optimization will be used to close any remaining gap between setpoint requests. This could potentially include app and device weighting factors.

3.4.4. The results of the Optimization deconfliction stage will be the ResolutionVector meaning just a single setpoint value per device as given in the ConflictMatrix.

**4.**      ***Deconfliction Service Interface***

**4.1.**   **Interface with GridAPPS-D**

4.1.1. Deconflicted setpoints are sent to simulations (aka, dispatched to devices) via CIM “DifferenceBuilder” messages.

**4.2.**   **Interface with Applications**

4.2.1. Intercepts CIM “DifferenceBuilder” messages that are normally sent to simulations. These messages are the setpoint requests by the applications. The message intercept will be implemented by modifying the GOSS-HELICS bridge for the GridAPPS-D platform.

4.2.2. For the “Cooperative” stage of deconfliction, messages will be sent between the deconfliction service and applications (two-way messaging) on the GridAPPS-D message bus in order to perform deconfliction. The details of these messages have not been established.

**5.**       ***Application Interface***

**5.1.**   **Interface with GridAPPS-D**

5.1.1. Subscribes to simulation measurement messages on the GridAPPS-D message bus.

5.1.2. Applications need to be able to retrieve current device setpoints and battery SoC values from GridLAB-D simulations.

**5.2.**   **Interface with Deconfliction Service**

5.2.1. Exchange messages by “intelligent” applications for the Cooperation stage of deconfliction.

**6.**       ***Implementation Considerations***

6.1. The existing FY23 deconfliction pipeline prototype handles the basics of the workflow around performing the deconfliction and will be used as the starting point for this deconfliction service. Besides implementing the combined/staged deconfliction, it also needs to run GridLAB-D simulations via the GridAPPS-D platform instead of the “sim-sim” simulation that feeds file-based data to applications.

6.2. The existing FY23 prototype competing apps will be updated to also work with a GridAPPS-D simulation. It is possible only the resilience and decarbonization apps are initially updated, not profit\_cvr. There is also a “peak shaving” application that was created outside the FY23 deconfliction pipeline prototype that will be considered as a Centralized Deconfliction Service demonstration application.

6.3. The preliminary steps to implement the deconfliction service are:
<ol>
<li>Updates to data structures and anything else needed to be compliant with this specifications document prior to any GridAPPS-D platform or staged deconfliction methodology implementation.</li>
<li>Integration with GridLAB-D simulations and GridAPPS-D platform with the FY23 sample deconfliction methodology classes (no staged deconfliction).</li>
<li>Staged deconfliction implementation.</li>
</ol>

6.4. For initial development the workflow-based competing apps running the 9500-node model will be used as this has batteries that other GridAPPS-D integrated models do not. The FY23 special version of the 123-node model that includes batteries will be included as part of the GridAPPS-D platform during this work making it available as a test case.

6.5. Even if the staged deconfliction methodology is implemented within a single deconfliction pipeline process initially, it may be that separate processes are subsequently implemented with data such as the ConflictMatrix being passed on the GridAPPS-D message bus as a follow-on implementation. This is seen as a critical step for implementing a distributed decentralized deconfliction service.

