ruleset Wheel {
  meta {
    shares __testing
  }
  global {
    //config= {};
    __testing = { "queries": [ { "name": "__testing" } ],
                  "events": [{ "domain": "rover", "type": "run",
                                "attrs": ["direction"] },
                             { "domain": "rover", "type": "stop",
                                "attrs": [  ] },
                              { "domain": "rover", "type": "speed",
                              "attrs": [ "speed" ] },
                              { "domain": "rover", "type": "motorIndex",
                              "attrs": [ "motorIndex" ] } ] }
  
    frequency = defaction(frequency){
      motorHat:dc_setFrequency(ent:motorIndex,frequency.defaultsTo(1600));
    }
    
    speed = defaction(speed){
      motorHat:dc_setSpeed(ent:motorIndex,speed.as("Number").defaultsTo(50));
    }
    
    run = defaction(direction){
      motorHat:dc_run(ent:motorIndex,direction == "fwd" => "back" | "fwd" );// reverse direction for build.
    }  
    
    stop = defaction(){
      motorHat:dc_stop(ent:motorIndex);
    }  
  
  }

  rule setMotorIndex { 
    select when rover motorIndex
    always{ ent:motorIndex := event:attr("motorIndex")}
  }

  rule speed { 
    select when rover speed speed(event:attr("speed"))
  }

  rule run { 
    select when rover run run(event:attr("direction"))
  }

  rule stop { 
    select when rover stop stop()
  }


}
