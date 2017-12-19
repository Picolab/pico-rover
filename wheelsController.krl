ruleset WheelsController {
  meta {
    shares __testing

   use module io.picolabs.pico alias wrangler
  }
  global {
    config= {
      "FR":"5tYj6Xi4deyAsninzbj7sK",
      "FL":"GyiTnMVWqrzVPXWUx2D2NB",
      "BR":"N7xj7beQx6VYsR9H81NbGD",
      "BL":"XYfv1HUQxcuwXmTHoNS72K"};

    __testing = { "queries": [ { "name": "__testing" } ],
                  "events": [{ "domain": "rover", "type": "fwd" },
                                { "domain": "rover", "type": "ccw" },
                                { "domain": "rover", "type": "cw"},
                                { "domain": "rover", "type": "ul"},
                                { "domain": "rover", "type": "ur"},
                                { "domain": "rover", "type": "ll"},
                                { "domain": "rover", "type": "lr"},
                              { "domain": "rover", "type": "back"},
                              { "domain": "rover", "type": "right"},
                              { "domain": "rover", "type": "left"},
                              { "domain": "rover", "type": "circle"},
                             { "domain": "rover", "type": "allstop"},
                              { "domain": "rover", "type": "allspeed",
                              "attrs": [ "speed" ] } ] }

    to_motors = defaction(event,attr1,attr2,attr3,attr4){
      every{
        event:send( 
            { "eci": config{"FR"},
              "domain": "rover", "type": event,
              "attrs": attr1
              });
        event:send( 
            { "eci": config{"FL"},
              "domain": "rover", "type": event,
              "attrs": attr2
              });
        event:send( 
            { "eci": config{"BR"},
              "domain": "rover", "type": event,
              "attrs": attr3
              });
        event:send( 
            { "eci": config{"BL"},
              "domain": "rover", "type": event,
              "attrs": attr4
              });
      }
    }
    run_motors = defaction(dir1,dir2,dir3,dir4){
      to_motors("run", {"direction": dir1},
                       {"direction": dir2},
                       {"direction": dir3},
                       {"direction": dir4} )
    }
  
    fwd = defaction(){ run_motors("fwd","back","back","fwd") }
    ccw = defaction(){ run_motors("fwd","fwd","back","back") }
    cw  = defaction(){ run_motors("back","back","fwd","fwd") }



    UR = defaction(){
       every{
      event:send( 
          { "eci": config{"FR"},
            "domain": "rover", "type": "run",
            "attrs": ({
              "direction": "fwd"
              })
            });
      event:send( { "eci": config{"FL"},
            "domain": "rover", "type": "stop"
            });
      event:send( 
          { "eci": config{"BL"},
            "domain": "rover", "type": "run",
            "attrs": ({
              "direction": "fwd"
              })
            });
      event:send( { "eci": config{"BR"},
            "domain": "rover", "type": "stop"
            });}
      returns{}
    }

    UL = defaction(){
       every{
      event:send( { "eci": config{"FR"},
            "domain": "rover", "type": "stop"
            });
      event:send( 
          { "eci": config{"FL"},
            "domain": "rover", "type": "run",
            "attrs": ({
              "direction": "back"
              })
            });
      event:send( { "eci": config{"BL"},
            "domain": "rover", "type": "stop"
            });
      event:send( 
          { "eci": config{"BR"},
            "domain": "rover", "type": "run",
            "attrs": ({
              "direction": "back"
              })
            });
      }
      returns{}
    }

    LL = defaction(){
       every{
      event:send( 
          { "eci": config{"FR"},
            "domain": "rover", "type": "run",
            "attrs": ({
              "direction": "back"
              })
            });
      event:send( { "eci": config{"FL"},
            "domain": "rover", "type": "stop"
            });
      event:send( 
          { "eci": config{"BL"},
            "domain": "rover", "type": "run",
            "attrs": ({
              "direction": "back"
              })
            });
      event:send( { "eci": config{"BR"},
            "domain": "rover", "type": "stop"
            });
    }}

    LR = defaction(){
       every{
      event:send( { "eci": config{"FR"},
            "domain": "rover", "type": "stop"
            });
      event:send( 
          { "eci": config{"FL"},
            "domain": "rover", "type": "run",
            "attrs": ({
              "direction": "fwd"
              })
            });
      event:send( 
          { "eci": config{"BR"},
            "domain": "rover", "type": "run",
            "attrs": ({
              "direction": "fwd"
              })
            });
      event:send( { "eci": config{"BL"},
            "domain": "rover", "type": "stop"
            });}
      returns{}
    }

    back = defaction(){   run_motors("back","fwd","fwd","back") }
    right = defaction(){  run_motors("back","back","back","back") }
    left = defaction(){   run_motors("fwd","fwd","fwd","fwd") } 
    stop = defaction(){   to_motors("stop",{},{},{},{} ) }
      /*every{
        event:send( 
            { "eci": config{"FR"},
              "domain": "rover", "type": "stop"
              });
        event:send( 
            { "eci": config{"FL"},
              "domain": "rover", "type": "stop"
              });
        event:send( 
            { "eci": config{"BR"},
              "domain": "rover", "type": "stop"
              });
        event:send( 
            { "eci": config{"BL"},
              "domain": "rover", "type": "stop"
              });
      }
    }  */
  
    speed = defaction(speed){
      to_motors("speed",{"speed": speed},
                        {"speed": speed},
                        {"speed": speed},
                        {"speed": speed} )
    }  

    circle = defaction(){
      every{
        to_motors("speed",{"speed": 50},
                          {"speed": 70},
                          {"speed": 50},
                          {"speed": 70} );
        event:send( 
            { "eci": config{"FR"},
              "domain": "rover", "type": "run",
              "attrs": ({
                "direction": "fwd"
                })
              });
        event:send( { "eci": config{"FL"},
              "domain": "rover", "type": "run",
              "attrs": ({
                "direction": "back"
                })
              });
        event:send( 
            { "eci": config{"BL"},
              "domain": "rover", "type": "run",
              "attrs": ({
                "direction": "fwd"
                })
              });
        event:send( { "eci": config{"BR"},
              "domain": "rover", "type": "run",
              "attrs": ({
                "direction": "back"
                })
              });
        }
    }

    }  
  
  
// rule name :       event domain type     action  
  rule fwd     { select when rover fwd       fwd() }
  rule ccw     { select when rover ccw       ccw() }
  rule cw      { select when rover cw        cw()  }
  rule UR      { select when rover ur        UR()  }
  rule UL      { select when rover ul        UL()  }
  rule LL      { select when rover ll        LL()  }
  rule LR      { select when rover lr        LR()  }
  rule back    { select when rover back      back() }
  rule right   { select when rover right     right() }
  rule left    { select when rover left      left() }
  rule circle  { select when rover circle    circle() }
  rule stop    { select when rover allstop   stop() }
  rule speed   { select when rover allspeed  speed(event:attr("speed")) }

}
