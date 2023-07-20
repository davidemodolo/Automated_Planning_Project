(define (problem problem2T)
    (:domain problem2T)

    (:objects
        location0 location1 - location
        carrier1 - carrier
        box1 box2 - box
        robot1 - robotic_agent
        med1 - medicine
        per1 - person
    )

    (:init
        (location_robot robot1 location1)
        (location_person per1 location1)
        (location_box box1 location0)
        (location_box box2 location0)
        (location_supply med1 location0)
        (location_carrier carrier1 location1)
        (carrier_has_no_robot carrier1)
        (robot_has_no_carrier robot1)
        (box_is_empty box1)
        (box_is_empty box2)
        (= (num-boxes carrier1) 0)
        ; closed world assumptions
    )
    
    (:goal
        (and
            (delivered per1 med1)
        )
    )
)