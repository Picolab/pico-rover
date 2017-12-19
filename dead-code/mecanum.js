
var Mecanum = require('mecanum')

var mec = new Mecanum({
    'cw': 60,
    'ccw': 40,
    'stop': 51,
  });

module.exports = {
    move: {
        type: "action",
        args: ["direction"],
        fn: function(args, callback){
			callback(null, mec.move(args.direction));
        },
    }
};
