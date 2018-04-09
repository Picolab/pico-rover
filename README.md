![alt text](https://github.com/Picolab/pico-rover/blob/master/documentation/PicoRover.JPG?raw=true)
# pico-rover
Pico controlled mecanum wheeled rover.

This project was used to drive Dr.Windleys BYU CS497 Fall 2017 research in custom created JavaScript KRL modules.

This repo contains the source code used to create a pico-engine singleton using [NPM motor-hat](https://www.npmjs.com/package/motor-hat) library to 
natively "control Adafruit's MotorHAT for the Raspberry Pi".

[Documentation](https://picolabs.atlassian.net/wiki/spaces/docs/pages/96370693/JavaScript+Modules)

# Proposed Research
KRL is a rule language that is used to solve IoT problems. KRL rulesets are executed by a Node-Pico-Engine.
Node-Pico-Engine is built on Node.js and has the potential to extend KRL rule language with NPM packages. My research
will focus on developing a plug in model for using NPM packages as KRL modules. I will develop KRL plugin model by
creating a GPIO plugin that uses the raspberry pi general-purpose input/output (GPIO) pins. The GPIO plugin will be used
on Node-Pico-Engine’s running on a raspberry pi. Using NPM pigpio package will pioneer NPM plugin model for the
Node-Pico-Engine. Exposing GPIO pins to KRL will allow developers to easily read the state of sensors as well as allow
control of LED’s or motors.
Node-Pico-Engine innovates actor base models with Persistent Compute Objects (Pico). Pico's allow you to abstract all
state information about a physical device including logic about how states should change, into a single place. Pico states
are updated with events, rules select on those events and cause desired behavior. Each Pico is implemented to use its
own thread.
This makes my research difficult because GPIO pins are a shared resource and KRL has no semaphore logic for
globally shared resources. Instead systems must be designed to avoid conflicts. I will be testing single Pico to gpio pin
model limitations. Where Pico’s are used as a type of thread safe semaphores

Specifically, my research will include:
1. Assist in developing KRL plugin model.
2. Extending KRL to use GPIO pins by creating a KRL module using a NPM package.
3. Testing limitations (if any) of using GPIO pins with KRL.
4. Documenting GPIO module functionality with best practices.

# Student Research Conference Abstract
The Pico engine is an emerging IoT platform that manages Picos (Persistent Compute Objects) by evaluating KRL rules against events associated with Picos.  It was believed the Pico engine had the potential to extend KRL with custom JavaScript modules, but was never developed until now.  This research developed user-defined JavaScript modules for the Pico engine and proposed and tested a single Pico to a single resource model.  The research was driven by implementing a simple Pico rover robot.  This robot used a Pico engine running on a raspberry pi with a adafruit motor hat.  The motor-hat npm library was used to extend GPIO pins connected to Mecanum Wheels to KRL as a module.  The single Pico to single resource model was implemented where each wheel motor connected to the motorHat is accessed by a single Pico which controls its direction and speed.
