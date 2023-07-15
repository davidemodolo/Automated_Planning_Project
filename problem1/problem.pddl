(define (problem problem1)
    (:domain problem1)

    (:objects
        location0 location1 location2 location3 - location
        supply1 supply2 - supply
        person1 person2 - person
        robot1 - robotic_agent
    )

    (:init
        ; Initial locations
        (location_person person1 location2)
        (location_person person2 location3)
        (location_robot robot1 location1)
        (location_supply supply1 location0)
        (location_supply supply2 location0)
    )
    
    (:goal
        (and
            (delivered person1 supply1)
            (delivered person2 supply2)
        )
    )
)
