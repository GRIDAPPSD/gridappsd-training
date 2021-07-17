# GridAPPS-D Voltage Violation Service

## Purpose

This is a GridAPPS-D service that calculates and publishes voltage voilations during a simulation.
Voltage violations are published every 15 seconds by default.

## Topics

- Subscribes to simulation output topic /topic/goss.gridappsd.simulation.output.[simulation_id]
- Publishes on topic /topic/goss.gridappsd.simulation.voltage_violation.[simulation_id].output

## Message Structure
 
- Simulation output message structure is available here: https://gridappsd.readthedocs.io/en/master/using_gridappsd/index.html#subscribe-to-simulation-output
- Voltage violation service publishes a JSON message with measurement MRIDs and their per unit voltage value. For example, 

```
{	
	"_00730ee5-04e1-48bf-917f-e47d5be16e6f": 1.07, 
	"_078cfc25-8a2e-4f34-8631-0346abe2214d": 1.06, 
	"_40df103f-b458-4c15-a2eb-ffe7d029ef65": 1.06, 
	"_51fe8d20-a89e-497f-8c4b-d5bd654449bf": 1.08
}
```


