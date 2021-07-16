.. _weather:

The weather data is based on exported data collected from the Solar Radiation Research Laboratory (39.74N,105.18W,1829 meter elevation)  January - December 2013.  The original dataset was based in Mountain Standard Time (MST). 

The original column names included engineering units, but could not be included on the import.  Below is a mapping between the exported column headers and the fields in the Influx database management system.

.. code-block:: console

	Original Exported Data                      Influx Measurement Field Key       Field Type
	------------------------------------        ----------------------------       ----------
	DATE (MM/DD/YYYY)                           DATE                               String
	MST	                                    MST                                String
	Global CM22 (vent/cor) [W/ft^2]	            GlobalCM22                         Float
	Direct CH1 [W/ft^2]	                    DirectCH1                          Float
	Diffuse CM22 (vent/cor) [W/ft^2]	    Diffuse                            Float
	Tower Dry Bulb Temp [deg F]	            TowerDryBulbTemp                   Float
	Tower RH [%]	                            TowerRH                            Float
	Avg Wind Speed @ 42ft [MPH]	            AvgWindSpeed                       Float
	Avg Wind Direction @ 42ft [deg from N]      AvgWindDirection                   Float
	
	Original Exported Data                      Influx Measurement Tag             Type
	------------------------------------        ----------------------------       ----------
	n/a                                         lat                                String
	n/a                                         long                               String
	n/a                                         place                              String


**Influx database details:**

Database name:  "proven",  Measurement name: "weather"
