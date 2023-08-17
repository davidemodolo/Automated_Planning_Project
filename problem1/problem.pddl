(define (problem problem1)
    (:domain domain1)

    (:objects
        depot location1 location2 location3 - location
        box1 box2 - box
        food1 food2  - food
        medicine1 - medicine
        tools1 - tools
        person1 person2 - person
        robot1 - robotic_agent
    )

    (:init
        ; Initial locations of objects
        (located_at person1 location2)
        (located_at person2 location3)
        (located_at robot1 depot)
        (located_at food1 depot)
        (located_at food2 depot)
        (located_at medicine1 depot)
        (located_at tools1 depot)
        (located_at box1 depot)
        (located_at box2 depot)
        (located_at box2 depot)

        ; Initial state of objects
        (box_is_empty box1)
        (box_is_empty box2)
        (robot_has_no_box robot1)
        
        ; closed world assumptions
    )
    
    (:goal
        (and
            (or (and (delivered person1 food1) (delivered person2 food2)) (and (delivered person1 food2) (delivered person2 food1))) ;remark note on assignment
            (delivered person2 tools1)
            (delivered person2 medicine1)
        )
    )
)
