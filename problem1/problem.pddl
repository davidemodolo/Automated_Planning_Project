(define (problem problem1)
    (:domain problem1)

    (:objects
        location0 location1 location2 location3 - location
        box1 box2 - box
        food1 food2  - food
        medicine1 - medicine
        tools1 - tools
        person1 person2 person3 - person
        robot1 robot2 - robotic_agent
    )

    (:init
        ; Initial locations
        (location_person person1 location2)
        (location_person person2 location3)
        (location_person person3 location3)
        (location_robot robot1 location1)
        (location_robot robot2 location1)
        (location_supply food1 location0)
        (location_supply food2 location0)
        (location_supply medicine1 location0)
        (location_supply tools1 location0)
        (location_box box1 location0)
        (location_box box2 location0)
        (box_is_empty box1)
        (box_is_empty box2)
        (robot_has_no_box robot1)
        (robot_has_no_box robot2)
        ; closed world assumptions
    )
    
    (:goal
        (and
            (or (and (delivered person1 food1) (delivered person2 food2)) (and (delivered person1 food2) (delivered person2 food1)))
            ; (delivered person2 medicine1)
            (delivered person2 tools1)
            (box_is_empty box1)
            (box_is_empty box2)
            (location_box box1 location0)
            (location_box box2 location0)
            (location_robot robot1 location0)
            (location_robot robot2 location0)
        )
    )
)
