(define (problem problem1)
  (:domain problem1)
  (:objects
    agent1 - robotic_agent
    person1 person2 - person
    box1 box2 - box
    location1 location2 location3 location4 location5 - location
    food1 medicine1 tools1 - supply
  )
  (:init
    ; Locations
    (location_robot agent1 location1)
    (location_person person1 location1)
    (location_person person2 location2)
    (location_box box1 location3)
    (location_box box2 location4)
    (location_supply food1 location5)
    (location_supply medicine1 location5)
    (location_supply tools1 location5)

    ; Boxes
    (is_empty_box box1)
    (is_empty_box box2)

    ; Contents
    (content box1 food1)
    (content box2 medicine1)

    ; People and their supplies
    (has person1 box1)
    (person_has_supply person1 food1)
    (delivered person2 medicine1)
  )
  (:goal
    (and
      (delivered person1 food1)
      (delivered person1 medicine1)
      (delivered person1 tools1)
    )
  )
)
