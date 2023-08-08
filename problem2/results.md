# Problem 2
## Results

### Machine setup:
- Planner: LAMA
- Command line ``lama domain.pddl problem.pddl``
- Runned on Docker image from https://hub.docker.com/r/aiplanning/planutils

### Solution found 

> Plan length: 20 steps.

1. attach_carrier_to_robot robot1 depot carrier1 (1)
2. fill_box robot1 depot box1 med1 (1)
3. load_box_on_carrier carrier1 box1 depot robot1 (1)
4. fill_box robot1 depot box4 tools1 (1)
5. load_box_on_carrier carrier1 box4 depot robot1 (1)
6. fill_box robot1 depot box2 food1 (1)
7. fill_box robot1 depot box3 food2 (1)
8. load_box_on_carrier carrier1 box2 depot robot1 (1)
9. load_box_on_carrier carrier1 box3 depot robot1 (1)
10. move_robot_with_carrier robot1 carrier1 depot location1 (1)
11. unload_box_from_carrier carrier1 box1 location1 robot1 (1)
12. unload_box_from_carrier carrier1 box4 location1 robot1 (1)
13. deliver robot1 location1 per1 med1 box1 (1)
14. deliver robot1 location1 per1 tools1 box4 (1)
15. move_robot_with_carrier robot1 carrier1 location1 location2 (1)
16. unload_box_from_carrier carrier1 box2 location2 robot1 (1)
17. deliver robot1 location2 per2 food1 box2 (1)
18. move_robot_with_carrier robot1 carrier1 location2 location3 (1)
19. unload_box_from_carrier carrier1 box3 location3 robot1 (1)
20. deliver robot1 location3 per3 food2 box3 (1)