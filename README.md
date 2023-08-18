**REPOSITORY FOR _AUTOMATED PLANNING: THEORY AND PRACTICE_ PROJECT**

by [Davide Modolo](https://github.com/davidemodolo/) & [Francesco Laiti](https://github.com/laitifranz)

![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54) ![PDDL](https://raw.githubusercontent.com/davidemodolo/PDDL_SVG_Icons/c978884225eca6e5e887515b6db818f94ac3cd0a/pddl.svg) ![HDDL](https://raw.githubusercontent.com/davidemodolo/PDDL_SVG_Icons/c978884225eca6e5e887515b6db818f94ac3cd0a/hddl.svg)
# TODO
- [x] Sistemare i files python nelle rispettive cartelle
- [x] Creare il readme di questa repo
- [ ] Pulizia della cartella problem3 con tutti i test effettuati
- [ ] Guardare commenti problem3 in cima
- [ ] Commentare codice bene e togliere cose commentate in italiano e in più
- [ ] Aggiornare tree

# PDDL/HDDL for Emergency Services Logistics Problems

The goal of this project was to solve five different scenarios involving injured/needy people and delivery robots using PDDL/HDDL planners.

The first problem is solved using two planners, the second problem has two different variations (with and without `:numeric-fluents`), the third and the fourth are solved using PANDA and the fifth using PlanSys2.

The second scenario is built on the first, the third and the fourth are built on the second and the fifth is built on the fourth.

## Task

The main goals of this assignment are to model planning problems using PDDL/HDDL and use state-of-the-art planners like planutils, fast downward, or optic to solve them.

The scenario considered is inspired by an emergency services logistics problem. The objective is to use robotic agents to deliver boxes containing emergency supplies to injured individuals who are located in fixed positions.

We used `planner.domains` API, `planutils` docker image, `PANDA` and `PlanSys2` to compute the plans.

### Problem 1

A robotic agent can deliver one supply in one box at a time.

### Problem 2

The number of boxes increased to 4 thanks to the ability of a robot to attach to a carrier. We created a version with the number coded as variable (using `:numeric-fluents`) and another version with innested `when` statements.

### Problem 3

Created HDDL files to implement hierarchical planning.

### Problem 4

Added durative actions.

### Problem 5

Problem 4 but implemented with PlanSys2 and fake actions.

## Our results and thought

Our resulting plans can be found in the markdown files in each folder.

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