#!/bin/bash

ioreg -l | grep '"BatteryPercent" =' | sed -e 's/.*BatteryPercent" = //; s/$/%/'