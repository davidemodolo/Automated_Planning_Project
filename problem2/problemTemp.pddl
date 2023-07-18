(define (problem problem2)
    (:domain problem2)

    (:objects
        location0 location1 - location
        carrier1 - carrier
        box1 box2 - box
        robot1 - robotic_agent
    )

    (:init
        (location_robot robot1 location1)
        (location_box box1 location0)
        (location_box box2 location0)
        (location_carrier carrier1 location1)
        (carrier_has_no_robot carrier1)
        (robot_has_no_carrier robot1)
        (= (num-boxes carrier1) 0)
        ; closed world assumptions
    )
    
    (:goal
        (and
            (location_box box1 location1)
            (not(box_loaded box1))
            ;(location_box box2 location1)
            (location_carrier carrier1 location0)
            (carrier_has_no_robot carrier1)
        )
    )
)