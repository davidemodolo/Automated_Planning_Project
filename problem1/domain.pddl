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
        box supply person robotic_agent location - object
        empty food medicine tools - supply
    )

    (:predicates
        (location_box ?x - box ?l - location)
        (location_person ?p - person ?l - location)
        (location_robot ?r - robotic_agent ?l - location)
        (location_supply ?s - supply ?l - location)
        (is_empty_box ?b - box)
        (content ?b - box ?s - supply)
        (has ?p - person ?b - box)
        (loaded ?r - robotic_agent ?b - box)
        (delivered ?p - person ?s - supply)
        (person_has_supply ?p - person ?s - supply)
    )

    (:action move
        :parameters (?r - robotic_agent ?from - location ?to - location)
        :precondition (and (location_robot ?r ?from) (not (= ?from ?to)))
        :effect (and (not (location_robot ?r ?from)) (location_robot ?r ?to))
    )

    (:action load
        :parameters (?r - robotic_agent ?b - box ?l - location ?s - supply)
        :precondition (and (location_robot ?r ?l) (location_box ?b ?l) (location_supply ?s ?l) (is_empty_box ?b) (content ?b ?s))
        :effect (and (not (is_empty_box ?b)) (not (content ?b ?s)) (loaded ?r ?b))
    )

    (:action unload
        :parameters (?r - robotic_agent ?b - box ?l - location ?s - supply)
        :precondition (and (location_robot ?r ?l) (loaded ?r ?b) (location_supply ?s ?l) (not (content ?b ?s)))
        :effect (and (not (loaded ?r ?b)) (content ?b ?s))
    )

    (:action fill
        :parameters (?r - robotic_agent ?b - box ?l - location ?s - supply)
        :precondition (and (location_robot ?r ?l) (location_box ?b ?l) (location_supply ?s ?l) (is_empty_box ?b) (not (content ?b ?s)))
        :effect (and (not (is_empty_box ?b)) (not (content ?b ?s)) (content ?b ?s))
    )

    (:action deliver
        :parameters (?r - robotic_agent ?b - box ?p - person ?l - location ?s - supply)
        :precondition (and (location_robot ?r ?l) (loaded ?r ?b) (location_person ?p ?l) (has ?p ?b) (content ?b ?s))
        :effect (and (not (loaded ?r ?b)) (not (has ?p ?b)) (delivered ?p ?s))
    )

    (:action give
        :parameters (?r - robotic_agent ?b - box ?p - person ?l - location ?s - supply)
        :precondition (and (location_robot ?r ?l) (loaded ?r ?b) (location_person ?p ?l) (not (has ?p ?b)) (content ?b ?s))
        :effect (and (not (loaded ?r ?b)) (not (has ?p ?b)) (delivered ?p ?s) (person_has_supply ?p ?s))
    )

)