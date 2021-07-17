Short-Term Grid Forecasting
---------------------------

Objectives
~~~~~~~~~~

Today’s distribution systems have been experiencing a significant transformation due to an increasing amount of smart electric loads and distributed energy resources, such as electric vehicles, smart home appliances, rooftop photovoltaic systems, and energy storage. As more flexible resources integrated into distribution systems, coordination among various flexible resources plays an important role in distribution system operations to optimally manage distribution assets and flexible resources. On the other hand, with the increasing penetration of variable energy resources, it is crucial for system operators to not only monitor and estimate the current grid conditions but also forecast the future system status, which allows for proactive dispatch of controllable resources and better preparation for ever-changing grid conditions. This application develops predictive locational marginal prices (DLMPs) to proactively manage the distribution assets and flexible resources based on forecasted grid conditions. This application enables the distribution system operators to optimally incentivize individual resources to achieve system-level control objectives, such as minimizing total generation cost and optimizing the voltage profile; and it paves the way to a fully functional distribution market with granular prices that reflect the time- and location-specific values of individual participants.

Design
~~~~~~

This application develops a high-resolution, short-term load forecasting method to accurately predict the power consumption of individual customers in distribution systems. Using historical load measurements as inputs, it trains a support vector regression model to forecast the future load. Based on the forecasted load in the short-term future, this application develops a three-phase AC optimal power flow problem to determine the predictive DLMPs in distribution systems. By accurately modeling the losses and the imbalances of distribution networks, it provides time- and location-specific pricing of individual resources.

|nrel_OPF_image0|

Operating/Running
~~~~~~~~~~~~~~~~~

The application was built using Python 3.6. It will be run from the platform GUI.

References
~~~~~~~~~~

[1]	H. Jiang, Y. Zhang, E. Muljadi, J. J. Zhang, and D. W. Gao, "A Short-Term and High-Resolution Distribution System Load Forecasting Approach Using Support Vector Regression with Hybrid Parameters Optimization," in IEEE Transactions on Smart Grid, vol. 9, no. 4, pp. 3341-3350, July 2018.
[2]	R. Yang and Y. Zhang, “Three-Phase AC Optimal Power Flow Based Distribution Locational Marginal Price,” IEEE Innovative Smart Grid Technologies, Arlington, VA, Apr. 2017.


.. |nrel_OPF_image0| image:: NREL_APPS/media/Grid_Forecasting.png
