**Combined SolutionCentralized Deconfliction Service Functional Specification**

Last updated: March 21, 2024

1.      **Deconfliction Service (aka, Deconfliction Pipeline) Workflow**

1.1.  **Setpoint Processor**

1.1.1.Compiles setpointrequests into the ConflictMatrix data structure. Note there may be thepotential for a “don’t-care” status for a device rather than a setpoint value. TheConflictMatrix is updated as soon as a new setpoint request is made so that itis always up to date.

1.1.2.Every setpoint requestmessage is processed through the workflow to resolution. This may or may notresult in setpoints being dispatched to devices.

1.1.3.Design rationale: Sinceevery setpoint request from every app will trigger the deconflictionmethodology being invoked, this will potentially lead to as many deconflictionsbeing done per a given timestamp as there are apps, subject to the frequencyeach app is requesting new setpoints. While this might be considered inefficient to do many deconflictions “ontop of each other” for a timestamp, it is central to the design. Given theinherent uncertainty in apps making setpoint requests, there is no way topredict anything beyond setpoint requests that have arrived.

1.2.  **Feasibility Maintainer**

1.2.1.Ensures theConflictMatrix includes only feasible setpoints. Infeasible setpoints exceedphysical or impose device limits. The Feasibility Maintainer may reject ormodify values in the ConflictMatrix.

1.2.2.The FeasibilityMaintainer constrains setpoints requests to hardware/device physical limits.  It is a simple set of constraints that areapplied that updates the ConflictMatrix insuring all setpoint requests arefeasible.

1.2.3.The first two steps ofthe deconfliction pipeline, Setpoint Processor and Feasibility Maintainer, areconsidered the “problem setup” part of the workflow.  The Deconflictor is considered the “problemsolution”.  These first three steps alldeal with the ConflictMatrix. The final two steps, Setpoint Validator andDevice Dispatcher, are considered “resolution disposition” as they deal withthe ResolutionVector.

1.3.  **Deconflictor**

1.3.1.Uses ConflictMatrix tocreate ResolutionVector through application of a deconfliction methodology. Thedeconflictor may exchange contextual information using GridAPPS-D platform messageswith applications such as Deconfliction Signals (e.g., coordination orincentive signals), the current ConflictMatrix, the current ResolutionVector,App Status, and/or App Metrics.

1.3.2.An architecturalseparation between the pipeline and the specific deconfliction methodology willexist so that different methodologies can be easily swapped in. For instance,during initial development before staged deconfliction is implemented, the methodologymay simply average the setpoint request values for a device for the resolution.

1.3.3.Because this separationis just for breaking up the development of the deconfliction service, it may berudimentary rather than separate processes. A swappable Python class is alikely design as used in the FY23 deconfliction pipeline prototype.

1.3.4.Three pieces of data thatare passed from the pipeline to the methodology and then back from the methodologyto the pipeline to perform deconfliction are:

1.3.4.1.             ConflictMatrix

1.3.4.2.             Set-point request that triggered thedeconfliction (includes not only the device/value pairs, but also the name ofthe app making the request and the timestamp for which it is being made). Thiscan be used during the deconfliction step to examine just the setpoint requeststhat have been introduced since the last time deconfliction was performed.

1.3.4.3.             ResolutionVector

1.3.5.The pipeline will alwaysinvoke the methodology and the methodology will determine if there is aconflict and must produce a ResolutionVector as output from the Deconflictorstep even if there is no newly introduced conflict.

1.4.  **Setpoint Validator**

1.4.1.Ensures that final setpointsin the ResolutionVector are consistent with operational requirements (e.g.,safety or regulatory). If setpoints are not consistent, automatic (or operator)intervention is taken. For the deconfliction service likely only automaticintervention will be supported.

1.4.2.The Setpoint Validatorimplementation may be similar to the Feasibility Maintainer.  They operate on different data structures,but how rules are specified and applied will be the same.

1.5.  **Device Dispatcher**

1.5.1.Compares ResolutionVectorto operational values of setpoints and issues platform-level control commands(CIM “DifferenceBuilder” messages) when needed. For some devices like transformers a change to a tap position will causea control command to be issued.  Forother devices like batteries any non-zero value will cause a control command tobe issued.

2.      **Deconfliction Service Data Structures**

2.1.  **ConflictMatrix**

2.1.1.Dictionary of the mostrecent setpoint requests for each application making requests across alldevices for which there have been requests. The timestamp for each devicerequest for each app is also stored in ConflictMatrix.

2.1.2.The representation forthe ConflictMatrix is a dictionary of dimension two with “device” as the firstdimension and “app” as the second dimension, i.e.,ConflictMatrix\[device\]\[app\].  Then thevalue for each entry is a tuple of dimension two with the first value being thetimestamp and the second being the set-point value, i.e.,ConflictMatrix\[device\]\[app\] = (timestamp, setpoint). This captures all possibleinformation that the deconfliction methodology can utilize at its discretion.

2.1.3.The ConflictMatrix is aliving data structure throughout the first three steps of the workflow.  Each step potentially modifies theConflictMatrix.  The state of theConflictMatrix at each step will be logged and it is possible that copies ofthe ConflictMatrix after different steps are created should they be needed forsubsequent workflow steps.

2.1.4.Timestamp related notes:

2.1.4.1.             ConflictMatrix maintains timestamps to give thedeconfliction methodology knowledge of how “fresh” vs. “stale” this setpointrequest for a device is. It could be the request was from the very beginning ofa simulation and that the app failed to send any further requests (perhaps itdied/exited) at least for that specific device. A stale setpoint request for adevice based on an old timestamp would be a strong indication to thedeconfliction method to discount if not completely disregard it whendetermining a deconflicted setpoint given how much might have changed in thecurrent operational state since the setpoint request was made.

2.1.4.2.             It is easily possible that new setpoint requestsare associated with timestamps that are prior to timestamps that have alreadybeen processed. Some apps may take much longer to generate setpoint requeststhan other apps. It is imperative that the deconfliction service process these“out of timestamp order” requests since discarding them could mean entirelyignoring some apps just based on them taking longer to generate requests.

2.2.  **ResolutionVector**

2.2.1.Dictionary of the mostrecent deconflicted (resolved) setpoints for each device.

2.2.2.The representation forthe ResolutionVector is a dictionary of dimension one with “device” as thedimension, i.e., ResoutionVector\[device\]. Then the value for each is a tuple ofdimension two with the first value being the timestamp and the second being thedeconflicted set-point value, i.e., ResolutionVector\[device\] = (timestamp,setpoint). The timestamp value is set to the “most recent” timestamp used todetermine the deconflicted setpoint for all apps for the device.

2.2.3.Like ConflictMatrix,ResolutionVector is also a living data structure in that the Setpoint Validatormay modify it.

3.      **Deconfliction Methodology Stages**

3.1.  **Overview**

3.1.1.The first stage isapplying rules that can be implemented as direct heuristics or constraints onan optimization problem. Initially device control budgets are used to reducethe size of the solution space by constraining system setpoints to those thatwill not result in accelerated degradation of physical assets through frequentcontrol actions and oscillating setpoints. System operation rules additionallyconstrain the solution space by eliminating setpoints that result in violationsof system limits or operational best practices. The second stage isfacilitating cooperating starting with status signals that are shared with oramong applications such that they could update their desired setpoints based onthe evolving context. A mediator process incentivizes applications to come to acooperative solution. The third stage is a fallback to a setpoint-informedoptimization problem over any remaining conflict after the previous stages wereapplied.

3.2.  **Rules & Heuristics**

3.2.1.For the full Rules &Heuristics deconfliction methodology a solution is chosen based on a set ofpredictive snapshot power flows used to calculate ranked utility function decisioncriteria formed from system-level objectives and optionally shared appobjectives.

3.2.2.For the Centralized DeconflictionService Rules & Heuristics stage of deconfliction, rules for systemsoperations, asset health, and budgetary controls will be applied. No predictivesnapshot power flows will be utilized.

3.2.3.During the application ofrules, the priority of each application and preference given to each setpointmay be used as weighting criteria for a heuristic solution.

3.2.4.The results of the Rules& Heuristics deconfliction step results will be an updated ConflictMatrix.  Any setpoint requests not meeting the rulesapplied will be modified making them fall within rules.

3.3.  **Cooperation**

3.3.1.Aims to enableapplications to mitigate conflicting operational preferences through mutualcoordination. This can be achieved through exchanging contextual information(deconfliction signals) among applications or through additional system-drivenincentives.  Context and cooperationamong applications can be realized through several methods including gametheory (cooperative decision-making through strategic interaction models) andMCDM techniques (combining conflicting goals and evaluating multipleconflicting criteria to achieve informed decision making).

3.3.2.For the full Cooperationdeconfliction methodology, cooperative game theory strategy based on acombination of press, compensate, advise, and ignore contextual signals isapplied. These signals drive applications to agree on a solution cooperativelythrough a mediator.

3.3.3.For the Centralized DeconflictionService Cooperation stage of deconfliction a mediator will use context signalsto facilitate cooperation between apps.

3.3.4.The results of theCooperation deconfliction stage will be an updated ConflictMatrix, analogous tothe Rules & Heuristics stage. The cooperation stage itself is iterative andwill update the ConflictMatrix during iteration as the conflict betweensetpoints is reduced. Iteration will terminate when the reduction in conflictbetween iterations falls below a threshold value over all devices withconflicting setpoints.

3.3.5.The information exchangedbetween the mediator and apps has not been finalized. It may include thecomplete or a reduced version of the ConflictMatrix or a much.

3.3.6.Setpoint requests for anapp potentially have been modified before the Cooperation stage ofdeconfliction has begun through the Feasibility Maintainer and Rules &Heuristics stage of the Deconflictor. Further, previous iterations of theCooperation Stage will also modify app setpoint requests. Apps must accept thesecurrent values as a starting point with any subsequent changes not“backtracking” from the current point contrary to mediator incentives.

3.4.  **Optimization**

3.4.1.For optimization, minimallyapplications provide only setpoints for devices they aim to control while atthe other end of the complexity spectrum applications provide their fullinternal objectives and constraints.  Forthe former conflicts are resolved by minimizing the distance between theResolutionVector and the set of application setpoint vectors. For the latter,multi-objective optimization techniques are used to form a single system-levelobjective. This objective is augmented to a system-level optimization problemthrough the aggregation of constraints provided by different applications withsystem-level constraints.

3.4.2.Combines setpoints and/orobjective functions of each application into a global optimization. Forexample, the problem can be solved using utility functions supplied by eachapplication with varying weights applied to each optimization goal shared bythe applications.

3.4.3.For the CentralizedDeconfliction Service, an algebraic formulation for the optimization will beused to close any remaining gap between setpoint requests. This couldpotentially include app and device weighting factors.

3.4.4.The results of theOptimization deconfliction stage will be the ResolutionVector meaning just asingle setpoint value per device as given in the ConflictMatrix.

4.      **Deconfliction Service Interface**

4.1.  **Interface with GridAPPS-D**

4.1.1.Deconflicted setpointsare sent to simulations (aka, dispatched to devices) via CIM“DifferenceBuilder” messages.

4.2.  **Interface with Applications**

4.2.1.Intercepts CIM“DifferenceBuilder” messages that are normally sent to simulations. Thesemessages are the setpoint requests by the applications. The message interceptwill be implemented by modifying the GOSS-HELICS bridge for the GridAPPS-Dplatform.

4.2.2.For the “Cooperative”stage of deconfliction, messages will be sent between the deconfliction serviceand applications (two-way messaging) on the GridAPPS-D message bus in order toperform deconfliction. The details of these messages have not been established.

5.      **Application Interface**

5.1.  **Interface with GridAPPS-D**

5.1.1.Subscribes to simulationmeasurement messages on the GridAPPS-D message bus

5.1.2.Applications need to beable to retrieve current device setpoints and battery SoC values from GridLAB-Dsimulations.

5.2.  **Interface with Deconfliction Service**

5.2.1.Exchange messages by “intelligent”applications for the Cooperation stage of deconfliction.

6.      **Implementation Considerations**

6.1.   The existing FY23 deconfliction pipelineprototype handles the basics of the workflow around performing thedeconfliction and will be used as the starting point for this deconflictionservice. Besides implementing the combined/staged deconfliction, it also needsto run GridLAB-D simulations via the GridAPPS-D platform instead of the “sim-sim”simulation that feeds file-based data to applications.

6.2.   The existing FY23 prototype competing apps willbe updated to also work with a GridAPPS-D simulation. It is possible only theresilience and decarbonization apps are initially updated, not profit\_cvr.There is also a “peak shaving” application that was created outside the FY23deconfliction pipeline prototype that will be considered as ak CentralizedDeconfliction Service demonstration application.

6.3.   The preliminary steps to implement thedeconfliction service are:

6.3.1.Updates to datastructures and anything else needed to be compliant with this specificationsdocument prior to any GridAPPS-D platform or staged deconfliction methodologyimplementation.

6.3.2.Integration withGridLAB-D simulations and GridAPPS-D platform with the FY23 sampledeconfliction methodology classes (no staged deconfliction).

6.3.3.Staged deconflictionimplementation.

6.4.   For initial development the workflow-basedcompeting apps running the 9500-node model will be used as this has batteriesthat other GridAPPS-D integrated models do not. The FY23 special version of the123-node model that includes batteries will be included as part of theGridAPPS-D platform during this work making it available as a test case.

6.5.   Even if the staged deconfliction methodology isimplemented within a single deconfliction pipeline process initially, it may bethat separate processes are subsequently implemented with data such as theConflictMatrix being passed on the GridAPPS-D message bus as a follow-on implementation.This is seen as a critical step for implementing a distributed decentralizeddeconfliction service.
