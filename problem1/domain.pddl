; PROBLEM DESCRIPTION from the assignment

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

(define (domain domain1)
    (:requirements :strips :typing :equality :negative-preconditions :disjunctive-preconditions)
    (:types
        person robotic_agent location box - object
        ; declare the types of the supplies
        supply - object
        food medicine tools - supply
    )

    (:predicates
        (located_at ?x - (either robotic_agent box supply) ?loc - location)
        
        (robot_has_box ?r - robotic_agent ?b - box)
        (robot_has_no_box ?r - robotic_agent)

        (box_with_supply ?b - box ?s - supply)
        (box_is_empty ?b - box) 

        (delivered ?p - person ?s - supply)
    )

    (:action move_robot
        :parameters (?r - robotic_agent ?l1 ?l2 - location)
        :precondition (and (located_at ?r ?l1) (not (= ?l1 ?l2)))
        :effect (and (not (located_at ?r ?l1)) (located_at ?r ?l2))
    )

    (:action take_box
        :parameters (?r - robotic_agent ?l1 - location ?b - box)
        :precondition (and (located_at ?r ?l1) (located_at ?b ?l1) (not (robot_has_box ?r ?b)) (robot_has_no_box ?r))
        :effect (and (not (located_at ?b ?l1)) (robot_has_box ?r ?b) (not (robot_has_no_box ?r)))
    )

    (:action drop_box
        :parameters (?r - robotic_agent ?l1 - location ?b - box)
        :precondition (and (located_at ?r ?l1) (robot_has_box ?r ?b) (not(robot_has_no_box ?r)))
        :effect (and (not (robot_has_box ?r ?b)) (located_at ?b ?l1) (robot_has_no_box ?r))
    )

    (:action fill_box
        :parameters (?r - robotic_agent ?l1 - location ?b - box ?s - supply)
        :precondition (and (located_at ?r ?l1) (located_at ?s ?l1) (robot_has_box ?r ?b)  (box_is_empty ?b))
        :effect (and (not (located_at ?s ?l1)) (box_with_supply ?b ?s) (not (box_is_empty ?b)))
    )

    (:action empty_box ; not used action, here in the case we want to empty a box that is somehow filled with a supply we don't need to deliver
        :parameters (?r - robotic_agent ?l1 - location ?b - box ?s - supply)
        :precondition (and (located_at ?r ?l1) (robot_has_box ?r ?b) (box_with_supply ?b ?s) (not (box_is_empty ?b)))
        :effect (and (not (box_with_supply ?b ?s)) (located_at ?s ?l1) (box_is_empty ?b))
    )

    (:action deliver
        :parameters (?r - robotic_agent ?l1 - location ?p - person ?s - supply ?b - box)
        :precondition (and (located_at ?r ?l1) (located_at ?p ?l1) (robot_has_box ?r ?b) (box_with_supply ?b ?s) (not (box_is_empty ?b)))
        :effect (and (not (robot_has_box ?r ?b)) (not (box_with_supply ?b ?s)) (delivered ?p ?s) (located_at ?b ?l1) (box_is_empty ?b) (robot_has_no_box ?r))
    )

)