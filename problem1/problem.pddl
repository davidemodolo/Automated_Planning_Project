(define (problem problem1)
    (:domain domain1)

    (:objects
        ; as required, we have the depot where everything (a part from the injured people) is located
        depot location1 location2 location3 - location
        ; boxes to store the supplies
        box1 box2 - box
        ; food supplies for person1 and person2
        food1 food2  - food
        ; medicine supplies for person2
        medicine1 - medicine
        ; tools for person2
        tools1 - tools
        ; injured people
        person1 person2 - person
        ; robot to deliver the supplies
        robot1 - robotic_agent
    )

    (:init
        ; Initial locations of people
        (located_at person1 location2)
        (located_at person2 location3)
        ; depot is the initial location of the robot and the supplies
        (located_at robot1 depot)
        (located_at food1 depot)
        (located_at food2 depot)
        (located_at medicine1 depot)
        (located_at tools1 depot)
        (located_at box1 depot)
        (located_at box2 depot)
        ; Initial state of objects
        (box_is_empty box1)
        (box_is_empty box2)
        (robot_has_no_box robot1)
        
        ; closed world assumptions
    )
    
    (:goal
        (and
            ; as specified in the assignment, it doesn't matter whether the food1 is delivered to person1 or person2 and the same for food2
            (or (and (delivered person1 food1) (delivered person2 food2)) (and (delivered person1 food2) (delivered person2 food1))) ;remark note on assignment
            (delivered person2 tools1)
            (delivered person2 medicine1)
        )
    )
)
