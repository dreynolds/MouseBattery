#!/bin/bash

PERCENT=$(ioreg -l | grep '"BatteryPercent" =' | sed -e 's/.*BatteryPercent" = //; s/$/%/')
if [ "${#PERCENT}" -eq 0 ];
then
    echo "N/A"
else
    echo $PERCENT
fi