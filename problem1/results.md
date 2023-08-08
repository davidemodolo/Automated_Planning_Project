# Problem 1
## Results

### Machine setup:
- Planner: LAMA 
- Command line: ``lama domain.pddl problem.pddl``
- Runned on Docker image from https://hub.docker.com/r/aiplanning/planutils

### Solution found 

> Plan length: 22 steps.

1. take_box robot1 depot box1 (1)
2. fill_box robot1 depot box1 food1 (1)
3. move_robot robot1 depot location2 (1)
4. deliver robot1 location2 person1 food1 box1 (1)
5. take_box robot1 location2 box1 (1)
6. move_robot robot1 location2 depot (1)
7. fill_box robot1 depot box1 medicine1 (1)
8. move_robot robot1 depot location3 (1)
9. deliver robot1 location3 person2 medicine1 box1 (1)
10. take_box robot1 location3 box1 (1)
11. move_robot robot1 location3 depot (1)
12. fill_box robot1 depot box1 tools1 (1)
13. move_robot robot1 depot location3 (1)
14. deliver robot1 location3 person2 tools1 box1 (1)
15. take_box robot1 location3 box1 (1)
16. move_robot robot1 location3 depot (1)
17. fill_box robot1 depot box1 food2 (1)
18. move_robot robot1 depot location3 (1)
19. deliver robot1 location3 person2 food2 box1 (1)
20. take_box robot1 location3 box1 (1)
21. move_robot robot1 location3 depot (1)
22. drop_box robot1 depot box1 (1)