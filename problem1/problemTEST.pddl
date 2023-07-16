(define (problem problem1)
(:domain problem1)
(:objects
location0 location1 location2 location3 - location
box0 box1 box2 box3 - box
food0 - food
medicine0 medicine1 medicine2 - medicine
tools0 - tools
person0 person1 person2 person3 person4 - person
robot0 robot1 - robotic_agent
)
(:init
(location_robot robot0 location0)
(location_robot robot1 location0)
(location_box box0 location0)
(location_box box1 location0)
(location_box box2 location0)
(location_box box3 location0)
(location_supply food0 location0)
(location_supply medicine0 location0)
(location_supply medicine1 location0)
(location_supply medicine2 location0)
(location_supply tools0 location0)
(location_person person0 location2)
(location_person person1 location2)
(location_person person2 location2)
(location_person person3 location2)
(location_person person4 location2)
(box_is_empty box0)
(box_is_empty box1)
(box_is_empty box2)
(box_is_empty box3)
(robot_has_no_box robot0)
(robot_has_no_box robot1)
)
(:goal (and
(delivered person0 tools0)
(delivered person1 medicine0)
(delivered person2 medicine2)
(delivered person3 food0)
(delivered person4 medicine1)
(box_is_empty box0)
(box_is_empty box1)
(box_is_empty box2)
(box_is_empty box3)
(location_box box0 location0)
(location_box box1 location0)
(location_box box2 location0)
(location_box box3 location0)
(location_robot robot0 location0)
(location_robot robot1 location0)
)
)
)
