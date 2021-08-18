Solar Forecasting Application
-----------------------------

Objectives
~~~~~~~~~~

When observations of solar radiation are limited, 
persistence and smart persistence solar forecasting 
techniques are frequently the easiest and most 
effective methods to use. Often though, these techniques 
suffer from having no information about current cloud properties, 
which could improve the forecast. At NREL, a 
Physics-based Smart Persistence model (PSPI) 
[1] was created for intra-hour solar forecasting using only 
GHI observations and a cloud retrieval technique. 
This model breaks down common solar radiation components 
such as GHI and solar zenith angle (SZA) using a
two-stream approximation [2] and methods used in [3] 
to forecast future GHI, cloud fraction, and cloud albedo. With 
this information, this technique can then be used to forecast 
solar power (still in development). 
Figure 1 below shows the conceptual framework for PSPI.

.. Figure 1: Conceptual framework for PSPI. PSPI breaks up the GHI and solar zenith angle (SZA) into cloud fraction and cloud albedo components.

|nrel_solar_image0|
**Figure 1 Conceptual framework for PSPI. PSPI breaks up the GHI and solar zenith angle (SZA) into cloud fraction and cloud albedo components.**

Design
~~~~~~

PSPI is designed to operate only using GHI observations. 
Other atmospheric parameters, such as pressure and temperature,
can be ingested into the application as well if those 
observations exist. Currently, site-specific annual averages of 
these parameters are used. Other parameters, such as altitude of 
the site of interest, need to be adjusted prior to running the 
application. Whatever atmospheric variables are available via the 
GridAPPS-D platform, they can be ingested into the PSPI based on 
the user's needs (still in development). Once all desired parameters
are chosen and the application is run, intra-hour GHI forecasts 
can be made (5 to 60-minute forecasts) as frequently as observations 
arrive (usually minutely).

Testing and Validation
~~~~~~~~~~~~~~~~~~~~~~

PSPI was tested and validated using 10 years of GHI data at the 
Solar Radiation Research Laboratory (SRRL) at NREL, in Golden, Colorado. 
More information about this process can be found in [1].

Operating/Running
~~~~~~~~~~~~~~~~~

The application was built using Python 3.6. It will be run from the platform GUI.

References
~~~~~~~~~~

[1] Kumler, A., Xie, Y., & Zhang, Y. (2019). A Physics-based Smart Persistence model for Intra-hour forecasting of solar radiation (PSPI) using GHI measurements and a cloud retrieval technique. Solar Energy, 177, 494-500.

[2] Sagan, C., & Pollack, J. B. (1967). Anisotropic nonconservative scattering and the clouds of Venus. Journal of Geophysical Research, 72(2), 469-477.

[3] Xie, Y., & Liu, Y. (2013). A new approach for simultaneously retrieving cloud albedo and cloud fraction from surface-based shortwave radiation measurements. Environmental Research Letters, 8(4), 044023.

.. |nrel_solar_image0| image:: NREL_APPS/media/Solar_Forecasting_1.png
