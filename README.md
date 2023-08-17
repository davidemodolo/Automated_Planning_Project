**REPOSITORY FOR _AUTOMATED PLANNING: THEORY AND PRACTICE_ PROJECT**

by [Davide Modolo](https://github.com/davidemodolo/) & [Francesco Laiti](https://github.com/laitifranz)

![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54) create PDDL HDDL 
# TODO
- [x] Sistemare i files python nelle rispettive cartelle
- [ ] Creare il readme di questa repo
- [ ] Pulizia della cartella problem3 con tutti i test effettuati
- [ ] Guardare commenti problem3 in cima
- [ ] Commentare codice bene e togliere cose commentate in italiano e in più

# PDDL/HDDL for Emergency Services Logistics Problems

The goal of this project was to solve five different scenarios involving injured/needy people and delivery robots using PDDL/HDDL planners.

The first problem is solved using two planners, the second problem has two different variations (with and without `:numeric-fluents`), the third and the fourth are solved using PANDA and the fifth using PlanSys2.

The second scenario is built on the first, the third and the fourth are built on the second and the fifth is built on the fourth.

## Task

The main goals of this assignment are to model planning problems using PDDL/HDDL and use state-of-the-art planners like planutils, fast downward, or optic to solve them.

The scenario considered is inspired by an emergency services logistics problem. The objective is to use robotic agents to deliver boxes containing emergency supplies to injured individuals who are located in fixed positions.

### Problem 1

### Problem 2

### Problem 3

### Problem 4

### Problem 5

## Our results and thought

## Directory content
Created with `tree /F` command
```bash
│   .gitignore
│   assignment.pdf
│   README.md
│
├───problem1
│       domain.pddl
│       problem.pddl
│       results.md
│       runnerSolverAPI.py
│
├───problem2
│   │   domain.pddl
│   │   problem.pddl
│   │   problemExtra_3boxes.pddl
│   │   results.md
│   │
│   └───numeric_fluents
│           domain.pddl
│           problem.pddl
│           runnerSolverAPI.py
│
├───problem3
│       domain.hddl
│       domainTMP.hddl
│       domain_solution.hddl
│       PANDA.jar
│       problem.hddl
│       problemTMP.hddl
│       problem_solution.hddl
│       results.md
│
├───problem4
│   │   domain.pddl
│   │   problem.pddl
│   │   problemExtra_3boxes.pddl
│   │   results.md
│   │
│   └───no_negative_preconditions
│           domain_no_negative.pddl
│           problem_no_negative.pddl
│
└───problem5
    │   Dockerfile
    │   setup.md
    │
    └───plansys_problem5
        │   CMakeLists.txt
        │   launch_terminal1.sh
        │   launch_terminal2.sh
        │   package.xml
        │   results.md
        │
        ├───launch
        │       plansys2_problem5_launch.py
        │       problem
        │
        ├───pddl
        │       domain.pddl
        │
        └───src
                attach_carrier_to_robot_action_node.cpp
                delivery_or_refactored_possible_action1_action_node.cpp
                delivery_or_refactored_possible_action2_action_node.cpp
                deliver_action_node.cpp
                detach_carrier_from_robot_action_node.cpp
                fill_box_action_node.cpp
                load_box_on_carrier_action_node.cpp
                move_robot_action_node.cpp
                move_robot_with_carrier_action_node.cpp
                unload_box_from_carrier_action_node.cpp

```