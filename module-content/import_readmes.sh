
git clone https://github.com/shpoudel/WSU-Restoration.git
cp -vr ./WSU-Restoration/docs/source/ ./docs/source/applications/restoration-WSU/
rm -rf WSU-Restoration

#curl --url https://github.com/shpoudel/WSU-Restoration/trunk/docs/source --output ./docs/source/applications/restoration-WSU --create-dirs

curl --url https://raw.githubusercontent.com/NREL/DER-Dispatch/master/README.md --output ./docs/source/applications/DER-dispatch-NREL/README.md --create-dirs

curl --url https://raw.githubusercontent.com/NREL/Solar-Forecasting/master/README.md --output ./docs/source/applications/solar-forecast-NREL/README.md --create-dirs

curl --url https://raw.githubusercontent.com/NREL/Grid-Forecasting/master/README.md --output ./docs/source/applications/grid-forecast-NREL/README.md --create-dirs

curl --url https://raw.githubusercontent.com/therahuljha/WSU-VVO-app/master/README.md --output ./docs/source/applications/VVO-WSU/README.md --create-dirs

#curl --url https://raw.githubusercontent.com/GRIDAPPSD/gridappsd-pyvvo/master/README.md --output ./docs/source/applications/py-VVO-PNNL/README.md --create-dirs

git clone https://github.com/GRIDAPPSD/gridappsd-dnp3.git
# mkdir ./docs/source/services/dnp3
cp -vr ./gridappsd-dnp3/docs/source/ ./docs/source/services/dnp3
rm -rf gridappsd-dnp3

git clone https://github.com/GRIDAPPSD/gridappsd-sensor-simulator.git
# mkdir ./docs/source/services/sensor-simulator
cp -vr ./gridappsd-sensor-simulator/docs/source ./docs/source/services/sensor-simulator
rm -rf gridappsd-sensor-simulator

curl --url https://raw.githubusercontent.com/GRIDAPPSD/gridappsd-voltage-violation/master/README.md --output ./docs/source/services/voltage-violation/README.md --create-dirs

curl --url https://raw.githubusercontent.com/GRIDAPPSD/gridappsd-state-estimator/master/README.md --output ./docs/source/services/state-estimator/README.md --create-dirs

curl --url https://raw.githubusercontent.com/GRIDAPPSD/gridappsd-2030_5/main/README.md?token=AEYDCD5E2YCQXWOMFSKMLKTA6IRTC --output ./docs/source/services/ieee2030_5/README.md --create-dirs

curl --url https://raw.githubusercontent.com/GRIDAPPSD/gridappsd-alarms/master/README.md --output ./docs/source/services/alarms/README.md --create-dirs


