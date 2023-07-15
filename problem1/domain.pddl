; number of persons known a priori and not moving have been injured
; orchestrate the activities of a set of different robotic agents to deliver boxes containing emergency supplies to each person

; ASSUMPTIONS
; Each injured person is at a specific location, and does not move.
; Each box is initially at a specific location and can be filled with a specific content such as food or medicine or tools, if empty
; Each person either has or does not have a box with a specific content.
; There can be more than one person at any given location

; EACH ROBOTIC AGENT CAN
; fill a box with a content, if the box is empty (box and agent are in the same location)
; empty a box by leaving the content to the current location (giving the person the content)
; pick up a single box and load it on the robotic agent
; move to another location

(define (domain problem1)
    (:requirements :strips :typing :equality :negative-preconditions)
    (:types
        person robotic_agent location - object
        supply - object
        food medicine tools - supply
    )

    (:predicates
        (location_person ?p - person ?l - location)
        (location_robot ?r - robotic_agent ?l - location)
        (location_supply ?s - supply ?l - location)
        (robot_has_supply ?r - robotic_agent ?s - supply)
        (delivered ?p - person ?s - supply)
    )
    
    (:action move_robot
        :parameters (?r - robotic_agent ?l1 - location ?l2 - location)
        :precondition (and (location_robot ?r ?l1) (not (= ?l1 ?l2)))
        :effect (and (not (location_robot ?r ?l1)) (location_robot ?r ?l2))
    )

    (:action load
        :parameters (?r - robotic_agent ?l - location ?s - supply)
        ; this gives the robot the supply if it is in the same location as the supply
        :precondition (and (location_robot ?r ?l) (location_supply ?s ?l))
        :effect (and (not (location_supply ?s ?l)) (robot_has_supply ?r ?s))
    )

    (:action unload
        :parameters (?r - robotic_agent ?s - supply ?l - location)
        :precondition (and (robot_has_supply ?r ?s) (location_robot ?r ?l))
        :effect (and (not (robot_has_supply ?r ?s)) (location_supply ?s ?l))
    )

    (:action deliver
        :parameters (?r - robotic_agent ?p - person ?s - supply ?l - location)
        ; if the robot is in the same location as the person, it can deliver the supply
        :precondition (and (robot_has_supply ?r ?s) (location_robot ?r ?l) (location_person ?p ?l))
        :effect (and (not (robot_has_supply ?r ?s)) (delivered ?p ?s) (location_supply ?s ?l))
    )
)


