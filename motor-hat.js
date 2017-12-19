
let spec = {
    address: 0x60,
    steppers: [],
    dcs: ['M1','M2','M3','M4'],
    servos: []
};
var motorHat = require('motor-hat')(spec); // singleton for module 

var ON_DEATH = require('death');

ON_DEATH(function(signal, err) {
  console.log(`\rstoping all motors\r`);
  motorHat.dcs[0].stop();
  motorHat.dcs[1].stop();
  motorHat.dcs[2].stop();
  motorHat.dcs[3].stop();
  process.exit();
})

module.exports = {
/*
    initialize: {
        type: "action",
        args: ["steppers","dcs","servos"],
        fn: function(args, callback){
        	// get a motor-hat instance with the following initialized:
			// * a stepper with winding one on 'M1' and winding two on 'M2' ports
			// * a dc motor on port 'M4'
			// * a servo on channel 0
			// * a servo on channel 14
			let spec = {
			    steppers: args.steppers,//[{ W1: 'M1', W2: 'M2' }],
			    dcs: args.dcs,//['M4'],
			    servos: args.servos//[0,14]
			};
			motorHat = require('motor-hat')(spec);
			callback();
        },
    },
*/
    dc_run: {
        type: "action",
        args: ["index","direction"],
        fn: function(args, callback){
			motorHat.dcs[args.index].run(args.direction);// fwd or anything else for back..
			callback();
        },
    },

    dc_stop: {
        type: "action",
        args: ["index"],
        fn: function(args, callback){
			motorHat.dcs[args.index].stop();
			callback();
        },
    },

    dc_setSpeed: {
        type: "action",
        args: ["index","speed"],
        fn: function(args, callback){
			motorHat.dcs[args.index].setSpeed(args.speed);// 0-100 percent
			callback();
        },
    },

    dc_setFrequency: {
        type: "action",
        args: ["index","frequency"],
        fn: function(args, callback){
			motorHat.dcs[args.index].setFrequency(args.frequency);// default is 1600
			callback();
        },
    } /*,

    servo_calibrate: {
        type: "action",
        args: ["index","PWM_frequency","zero_pulse_duration","hundred_pulse_duration"],
        fn: function(args, callback){
			motorHat.servos[args.index].calibrate(	args.PWM_frequency,
													args.zero_pulse_duration,
													args.hundred_pulse_duration
												  );
			callback();
        },
    servo_moveTo: {
        type: "action",
        args: ["index","position"],
        fn: function(args, callback){
			motorHat.servos[args.index].moveTo(	args.position );
			callback();
        },
    },

    stepper_setSteps: {
        type: "action",
        args: ["index","steps"],
        fn: function(args, callback){
			motorHat.steppers[args.index].setSteps(	args.steps );  // steps/rev (default 200)
			callback();
        },
    },

    stepper_setSpeed: {
        type: "action",
        args: ["index","speed"],
        fn: function(args, callback){
			motorHat.steppers[args.index].setSpeed(	args.speed );  // {rpm:20} or {pps:} of {sps}
			callback();
        },
    },

    stepper_setStyle: {
        type: "action",
        args: ["index","style"],
        fn: function(args, callback){
			motorHat.servos[args.index].setStyle( args.style ); // [ microstep, single, interleaved, double ]
			callback();
        },
    },
    stepper_stepSync: {
        type: "action",
        args: ["index",,"dir","steps"],
        fn: function(args, callback){
			motorHat.servos[args.index].stepSync( args.dir , args.steps ); // dir -> fwd, back
			callback();
        },
    },
    stepper_setMicrosteps: {
        type: "action",
        args: ["index","steps"],
        fn: function(args, callback){
			motorHat.servos[args.index].setMicrosteps( args.steps ); // 
			callback();
        },
    },
    ----checklist----
    stepSync,
    oneStepSync,
    setStyle,
    setFrequency,
    setMicrosteps,
    setSteps,
    setSpeed,
    options,*/
};
