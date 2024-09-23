## Functional Specification: Combined Solution Centralized Deconfliction Service

<ul>
<li>Last updated: September 23, 2024</li>
<li>Author: Gary Black</li>
</ul>

This is the as-implemented functional specification for the FY24 deconfliction service final deliverable.

**1.**     ***Deconfliction Service (aka, Deconfliction Pipeline) Workflow***

**1.1.**   **Setpoint Processor**

1.1.1. Compiles setpoint requests into the ConflictMatrix data structure. Note there may be the potential for a “don’t-care” status for a device rather than a setpoint value, but the FY24 deconfliction service test applications do not do this so there no provision has been coded to support this. The ConflictMatrix is updated as soon as a new setpoint request is made so that it is always up-to-date.

1.1.2. For the FY23 prototype deconfliction pipeline, every setpoint request message is processed through the workflow to resolution, which may or may not result in setpoints being dispatched to devices. For the FY24 service, specfically with the addition of support for the cooperation stage of deconfliction, there is a special case where every setpoint request message is no longer processed through resolution. This occurs when multiple apps are sending setpoint requests based off the same newly arriving simulation measurements and therefore the requests are effectively right on top of each other regarding the timestamp as part of the request and their arrival in the deconfliction pipeline message processing queue. In this case the cooperation stage has just recently been kicked off based on the first arriving setpoint request and processing this first request to resolution would ultimately be counterproductive given the new request. Instead, the ConflictMatrix data structure is updated based on the newly arriving setpoint request and the cooperation stage only is reset or restarted with no device dispatch being done solely based on the original request.

1.1.3. Design rationale: Without the cooperation stage of deconfliction as per the FY23 prototype, the previous design of insuring processing through resolution for every setpoint request was correct. With the FY24 service adding the cooperation stage, insuring the coooperation that is currently being run is up-to-date with setpoint requests is the better design. If the old design of a guaranteed resolution/dispatch per setpoint request was maintained, it would result in new device dispatches being based on old/irrelevant requests, ultimately leading to the deconfliction service not accurately representing the intention of applications. Note this design change still fulfills the underlying requirement of never disregarding a setpoint request as well as accomodating the inherent uncertainty of these requests.

**1.2.**   **Feasibility Maintainer**

1.2.1. Ensures the ConflictMatrix includes only feasible setpoints. Infeasible setpoints exceed physical or impose device limits. The Feasibility Maintainer may reject or modify values in the ConflictMatrix to insure feasibility.

1.2.2. The Feasibility Maintainer constrains setpoints requests to hardware/device physical limits.  It is a simple set of constraints that are applied that updates the ConflictMatrix insuring all setpoint requests are feasible.

1.2.3. The first two steps of the deconfliction pipeline, Setpoint Processor and Feasibility Maintainer, are considered the “problem setup” part of the workflow.  The Deconflictor is considered the “problem solution”.  These first three steps all deal with the ConflictMatrix, although the closing step of the Deconflictor creates a ResolutionVector. The final two steps, Setpoint Validator and Device Dispatcher, are considered “resolution disposition” as they deal solely with the ResolutionVector.

1.2.4. For the FY24 deconfliction service the Feasibility Maintainer checks both battery and regulator setpoint request values in the ConflictMatrix. For batteries the requests are constrained so the state-of-charge, SoC, will not fall outside the range of 0.2 and 0.9 and that any requests do not exceed the rated power for the battery either for charging or discharging. For regulators the Feasibility Maintainer insures the setpoint requests are within the physical range of -16 and +16 for the tap position.

**1.3.**   **Deconflictor**

1.3.1. Uses ConflictMatrix to create ResolutionVector through application of a deconfliction methodology. The deconflictor may exchange contextual information using GridAPPS-D platform messages with applications such as Deconfliction Signals (e.g., coordination or incentive signals), the current ConflictMatrix, the current ResolutionVector, App Status, and/or App Metrics.

1.3.2. For the FY24 deconfliction service three stages of deconfliction are applied as described in more detail below. The first is Rules & Heuristics, followed by Cooperation, and finally Optimization. Because the application of these stages is tightly intertwined in the pipeline workflow code, there is no architectural separation between the pipeline and these deconfliction stages as there was with the FY23 prototype. The Cooperation stage specifically is a sophisticated workflow with GridAPPS-D messages being exchanged between the pipeline and applications in an iterative fashion until thresholds are met to conclude cooperation.

1.3.3. The deconfliction methodology stages operate on two data structures, the ConflictMatrix and ResolutionVector. The first two stages, Rules & Heuristics and Cooperation process the ConflictMatrix solely as both input and output while the Optimization stage takes the ConflictMatrix as input and produces a ResolutionVector as output.

1.3.4. The pipeline determines if based on the most recent setpoint request a conflict exists as represented within the ConflictMatrix. If a conflict exists, the pipeline then invokes the stages of deconfliction as part of its processing workflow. Processing must produce a ResolutionVector as output from the Deconflictor step, which is done whether there was newly introduced conflict or not.

**1.4.**   **Setpoint Validator**

1.4.1. Ensures that final setpoints in the ResolutionVector are consistent with operational requirements (e.g., safety or regulatory). If setpoints are not consistent, automatic or operator intervention would need to be taken. For the FY24 deconfliction service only automatic intervention is supported.

1.4.2. For the FY24 deconfliction service the Setpoint Validator makes the same checks on battery (SoC and rated power) and regulator (-16 to +16 tap position) setpoints as the Feasibility Maintainer. However, the Setpoint Validator operates on the ResolutionVector data structure while the Feasibility Maintainer operates on the ConflictMatrix. In the future a more sophisticated Setpoint Validator that makes specific checks not part of the Feasibility Maintainer may be implemented.

**1.5.**   **Device Dispatcher**

1.5.1. Compares ResolutionVector to operational values of setpoints and issues platform-level control commands (i.e., CIM “DifferenceBuilder” messages) when needed.  For some devices like regulators/transformers a change to a tap position causes a control command to be issued.  For other devices like batteries any non-zero value causes a control command to be issued.

**2.**     ***Deconfliction Service Data Structures***

**2.1.**   **ConflictMatrix**

2.1.1. Dictionary of the most recent setpoint requests for each application making requests across all devices for which there have been requests. The timestamp for each device request for each app is also stored in ConflictMatrix.

2.1.2. The representation for the ConflictMatrix is a dictionary of dimension two with “device” as the first dimension and “app” as the second dimension, i.e., ConflictMatrix\[device\]\[app\].  Then the value for each entry is a tuple of dimension two with the first value being the timestamp and the second being the set-point value, i.e., ConflictMatrix\[device\]\[app\] = (timestamp, setpoint). This captures all possible information that the deconfliction methodology can utilize at its discretion.

2.1.3. The ConflictMatrix is a living data structure throughout the first three steps of the deconfliction pipeline: Setpoint Processor, Feasibility Maintainer, and Deconflictor.  The Setpoint Processor purpose is to modify the ConflictMatrix and the other two steps potentially modify the ConflictMatrix based on need.  During the Deconflictor step copies of the ConflictMatrix are created as it could be, based on subsequent processing, that a previous state of the ConflictMatrix is the one used for creating the ResolutionVector for device dispatch.

2.1.4. Timestamp related notes:
<ul>
<li>ConflictMatrix maintains timestamps to give the deconfliction methodology knowledge of how “fresh” vs. “stale” this setpoint request for a device is. It could be the request was from the very beginning of a simulation and that the app failed to send any further requests (perhaps it died/exited) at least for that specific device. A stale setpoint request for a device based on an old timestamp would be a strong indication to the deconfliction method to discount if not completely disregard it when determining a deconflicted setpoint given how much might have changed in the current operational state since the setpoint request was made. In the FY24 deconfliction service the timestamp associate with each ConflictMatrix entry is not utilized, but this feature is being maintained for possible future enhancements.</li>
<li>It is likely there will be new setpoint requests associated with timestamps that are prior to timestamps that have already been processed due to some apps taking much longer to generate setpoint requests than other apps. In this case the deconfliction service must process these “out of timestamp order” requests since discarding them could mean entirely ignoring some apps just based on them taking longer to generate requests.</li>
</ul>

**2.2.**   **ResolutionVector**

2.2.1. Dictionary of the most recent deconflicted (resolved) setpoints for each device.

2.2.2. The representation for the ResolutionVector is a dictionary of dimension one with “device” as the dimension, i.e., ResoutionVector\[device\]. Then the value for each is a tuple of dimension two with the first value being the timestamp and the second being the deconflicted set-point value, i.e., ResolutionVector\[device\] = (timestamp, setpoint). The timestamp value is set to the “most recent” timestamp used to determine the deconflicted setpoint for all apps for the device.

2.2.3. Like ConflictMatrix, ResolutionVector is also a living data structure in that the Setpoint Validator may modify it.

**3.**     ***Deconfliction Methodology Stages***

**3.1.**   **Overview**

3.1.1. The first stage is applying rules that can be implemented as direct heuristics or constraints on an optimization problem. Initially device control budgets are used to reduce the size of the solution space by constraining system setpoints to those that will not result in accelerated degradation of physical assets through frequent control actions and oscillating setpoints. System operation rules additionally constrain the solution space by eliminating setpoints that result in violations of system limits or operational best practices. The second stage is facilitating cooperation starting with a message to elicit cooperation with a "target" ResolutionVector provided to apps that decide their willingness to accept the target setpoints and to what degree when providing updated response setpoints. This exchange of target ResolutionVectors and application responses continues until convergence thresholds are reached that halt cooperation. To incentivize apps to cooperate the evolving target ResolutionVectors during cooperation are weighted to favor the desired setpoints of apps that cooperate more. The third stage is a fallback to a setpoint-informed optimization problem over any remaining conflict after the previous stages have been applied.


**3.2.**   **Rules & Heuristics**

3.2.1. For the full Rules & Heuristics deconfliction methodology as implemented for the FY23 Alternatives Analysis paper, a solution is chosen based on a set of predictive snapshot power flows used to calculate ranked utility function decision criteria formed from system-level objectives and optionally shared app objectives.

3.2.2. For the Centralized Deconfliction Service Rules & Heuristics stage of deconfliction, rules for systems operations, asset health, and budgetary controls will be applied. No predictive snapshot power flows will be utilized.

3.2.3. The results of the Rules & Heuristics deconfliction step results will be an updated ConflictMatrix.  Any setpoint requests not meeting the rules applied will be modified making them fall within rules.

3.2.4. For the FY24 deconfliction service, simple rules are implemented for battery and regulator asset health. For batteries the concept of restricting repeatedly and rapidly switching between charge and discharge cycles was implemented. A history of changes between charging and discharging and vice versa is maintained over a simulation with a rule that no more than a single change between charge/discharge states is allowed within a rolling 60 second period.  The period was chosen solely based on typical simulation durations for testing and demonstration rather than any realistic attempt to maintain asset health. Further, there is no attempt to insure that charges and discharges are of a "full cycle" nature as would also enhance asset health. For regulators a history of tap position changes for each device is maintained to limit the total number of tap position or step changes within a rolling 60 second simulation period. As with batteries the time period is based on typical simulation durations and the total number of step changes allowed, 6, was also set to best test/demonstrate this rule.

**3.3.**   **Cooperation**

3.3.1. Aims to enable applications to mitigate conflicting operational preferences through mutual coordination. This can be achieved through exchanging contextual information (deconfliction signals) among applications or through additional system-driven incentives.  Context and cooperation among applications can be realized through several methods including game theory (cooperative decision-making through strategic interaction models) and MCDM techniques (combining conflicting goals and evaluating multiple conflicting criteria to achieve informed decision making).

3.3.2. For the full Cooperation deconfliction methodology, cooperative game theory strategy based on a combination of press, compensate, advise, and ignore contextual signals is applied. These signals drive applications to agree on a solution cooperatively through a mediator.

3.3.3. For the FY24 Centralized Deconfliction Service Cooperation stage of deconfliction a mediator for the running applications is built into the pipeline that sends cooperation messages and then processes application responses.

3.3.4. The results of the Cooperation deconfliction stage will be an updated ConflictMatrix, analogous to the Rules & Heuristics stage. The cooperation stage itself is iterative and updates the ConflictMatrix during iteration as the conflict between setpoints is reduced. Iteration will terminate when the reduction in conflict between iterations falls below threshold values over all devices with conflicting setpoints.

3.3.5. Setpoint requests for an app potentially have been modified before the Cooperation stage of deconfliction has begun through the Feasibility Maintainer and Rules & Heuristics stage of the Deconflictor. Further, previous iterations of the Cooperation Stage will also modify app setpoint requests. Apps must accept these current values as a starting point with any subsequent changes not “backtracking” from the current point contrary to mediator incentives.

3.3.6. For the FY24 deconfliction service the mediator provided message to elicit cooperation contains a "target" ResolutionVector meaning a desired setpoint value for each device in the ConflictMatrix. These target setpoints are weighted centroids of the ConflictMatrix setpoint values. Weights are determined by evaluating cooperation from each app during the current iterative phase of cooperation. Apps that cooperate more with the target setpoints receive weights that more closely reflect their desired setpoints as given in the ConflictMatrix than apps that either cooperated less or not at all. These weights are the means to incentivize apps to participate in the cooperation stage of deconfliction.

3.3.7. Evaluating both the degree of cooperation for apps and whether to end a cooperation phase utilizes the existing conflict metric computation. The rationale is that if an app is cooperating more, the conflict metric value between its setpoints responses and the target setpoints will be less than apps cooperating to a lesser degree. Similarly, two of the three criteria used for ending a cooperation phase are based on the conflict metric. If either the computed conflict metric over the ConflictMatrix is below a threshold value as it is updated through cooperation iteration within a phase (meaning there is no longer enough remaining conflict to justify continuing) or the percent change in the conflict metric between two iterations is below another threshold value, coopeation will be ended. The final criteria for ending cooperation is a failsafe in case neither of the two threshold criteria can't be met and that is a total maximum number of cooperation responses from any single application being over a set value, currently 10.

**3.4.**   **Optimization**

3.4.1. For optimization, minimally applications provide only setpoints for devices they aim to control while at the other end of the complexity spectrum applications provide their full internal objectives and constraints.  For the former conflicts are resolved by minimizing the distance between the ResolutionVector and the set of application setpoint vectors. For the latter, multi-objective optimization techniques are used to form a single system-level objective. This objective is augmented to a system-level optimization problem through the aggregation of constraints provided by different applications with system-level constraints.

3.4.2. Combines setpoints and/or objective functions of each application into a global optimization. For example, the problem can be solved using utility functions supplied by each application with varying weights applied to each optimization goal shared by the applications.

3.4.3. The results of the Optimization deconfliction stage will be the ResolutionVector meaning just a single setpoint value per device as given in the ConflictMatrix.

3.4.4. For the FY24 Centralized Deconfliction Service, an algebraic formulation for the optimization will be used to close any remaining gap between setpoint requests. The Cooperation stage code that determines the target ResolutionVector for eliciting cooperation is shared with the Optimization stage code. Therefore the per-app weighting factors used to incentivize apps to cooperate are also part of the final Optimization stage of deconfliction. Specifically a final set of weights are computed based on the total amount of cooperation over the phase and these weights are applied to the Optimization stage that determines the final ResolutionVector.

**4.**     ***Deconfliction Service Interface***

**4.1.**   **Interface with GridAPPS-D**

4.1.1. Deconflicted setpoints are sent to simulations (aka, dispatched to devices) via CIM “DifferenceBuilder” messages.

**4.2.**   **Interface with Applications**

4.2.1. Intercepts CIM “DifferenceBuilder” messages that are normally sent to simulations. These messages are the setpoint requests by the applications. The message intercept will be implemented by modifying the GOSS-HELICS bridge for the GridAPPS-D platform.

4.2.2. For the FY24 deconfliction service applications publish DifferenceBuilder messages as GridAPPS-D service output topic messages rather than sending them to the simulation. Design and implementation changes within the GOSS-HELICS bridge will be made in the future to support intercepting messages sent to the simulation.

4.2.3. For the Cooperation stage of deconfliction, the pipeline publishes service output messages with target ResolutionVectors to elicit cooperation. Applications publish CIM "DifferenceBuilder" messages as responses, just as they do with setpoint messages that are based on new simulation measurements. However, to distinguish the type of message (measurement or cooperation based), different message topics are used.

**5.**     ***Application Interface***

**5.1.**   **Interface with GridAPPS-D**

5.1.1. Subscribes to simulation measurement messages on the GridAPPS-D message bus.

5.1.2. Applications retrieve current device setpoints and battery SoC values from GridLAB-D simulation measurement messages.

**5.2.**   **Interface with Deconfliction Service**

5.2.1. Receives "cooperation" messages containing target ResolutionVectors during the Cooperation stage of deconfliction. Publishes CIM "DifferenceBuilder" messages to two different topics to provide updated device setpoints to the deconfliction service: new simulation measurement based messages and cooperation response messages.

**6.**     ***Implementation Considerations***

6.1. The FY23 deconfliction pipeline prototype was used as the basis for the workflow for the FY24 deconfliction service. This was substantially enhanced though specifically to perform the Cooperation stage deconfliction. Besides supporting the combined/staged deconfliction in FY24, it also supports GridLAB-D simulations via the GridAPPS-D platform instead of the FY23 “sim-sim” simulation that feeds file-based data to applications.

6.2. The existing FY23 prototype competing apps were updated to also work with GridAPPS-D simulations for the FY24 deconfliction service. All three apps (resilience, decarbonization, and profit\_cvr) were updated for both the PuLP and CVXPY optimization libraries. Initially an optimization-based solution for determining Cooperation stage setpoint responses was planned, but the formulation for this was a concave and non-linear problem that was not supported by any of the freely available PuLP and CVXPY solvers. Therefore a simplified methodology was implemented where the half of target setpoints that were the closest to the application preferred setpoints were agreed to and the remainder were rejected for cooperation.

6.3. The FY23 special version of the IEEE 123-node model that includes batteries serves as the test model for FY24 deconfliction service development. This model will subsequently be packaged as part of the standard GridAPPS-D platform to allow others to easily run the deconfliction service.

6.4. Although the FY24 staged deconfliction methodology is currently implemented within the main deconfliction pipeline process, it may be that separate processes are subsequently implemented with data such as the ConflictMatrix being passed on the GridAPPS-D message bus during follow-on development. This is seen as a necessary step for implementing a distributed decentralized deconfliction service.

6.5. FY23 prototype code used descriptive names for the devices kept in ConflictMatrix, etc. E.g., "BatteryUnit.battery1". The FY24 deconfliction service was updated to instead use the mRID values that are used in GridLAB-D simulation measurement messages. This required two additional dictionaries to map from mRID values to names and vice versa as existing code references these names. These dictionaries were made part of the MethodUtil class in case it proves useful for deconfliction methodology code to use these.

