; NOTE
; esecuzione di task in parallelo non ne vedo... si può pensare di farlo se si hanno
; due robot che lavorano contemporaneamente...
; In general, the parallel execution of actions is possible when they involve different entities 
; (robotic agents, carriers, boxes, etc.) and there's no overlap in the preconditions and effects of the actions.

; NOTE DI RIMOZIONE
; tolto equality per vedere se era quello il problema, da riprovare
; non supporta either, cambio con estensione 
; non supporta il formato suggerito dall extension PDDL, bisogna scrivere le conditions una alla volta con at start at and ecc....

(define (domain domain4)
    (:requirements :strips :typing :negative-preconditions :durative-actions)
    (:types
        person robotic_agent location box carrier supply - object
        food medicine tools - supply
    )
    (:predicates
        (located_at_robot ?r - robotic_agent ?l - location)
        (located_at_box ?b - box ?l - location)
        (located_at_supply ?s - supply ?l - location)
        (located_at_person ?p - person ?l - location)
        (located_at_carrier ?c - carrier ?l - location)
        (box_on_carrier ?b - box ?c - carrier)
        (box_loaded ?b - box)
        (box_is_empty ?b - box)
        (box_with_supply ?b - box ?s - supply)
        (carrier_has_no_robot ?c - carrier)
        (robot_has_no_carrier ?r - robotic_agent)
        (robot_carrier_attached ?r - robotic_agent ?c - carrier)
        ; since a carrier can load only up to 4 boxes, we create all the predicates
        ; because :numeric-fluents is not fully supported in many PDDL solvers (we tested using LAMA and other planners)
        (carrier_has_no_boxes ?c - carrier)
        (carrier_has_one_box ?c - carrier)
        (carrier_has_two_boxes ?c - carrier)
        (carrier_has_three_boxes ?c - carrier)
        (carrier_has_four_boxes ?c - carrier)
        (delivered ?p - person ?s - supply)
    )

    ; move the robot
    (:durative-action move_robot
        :parameters (?r - robotic_agent ?l1 ?l2 - location)
        :duration (= ?duration 5)
        :condition (and 
                        (at start (located_at_robot ?r ?l1))
                        (over all (robot_has_no_carrier ?r)) ; does not change along the duration
        )
        :effect (and 
                    (at start (not (located_at_robot ?r ?l1)))
                    (at end (located_at_robot ?r ?l2))
        )
    )

    ; move a robot with a carrier attached
    (:durative-action move_robot_with_carrier
        :parameters (?r - robotic_agent ?c - carrier ?l1 ?l2 - location)
        :duration (= ?duration 7)
        :condition (and 
                        (at start (located_at_robot ?r ?l1))
                        (at start (located_at_carrier ?c ?l1))
                        (over all (robot_carrier_attached ?r ?c))
            )
        :effect (and 
                    (at start (not (located_at_robot ?r ?l1)))
                    (at start (not (located_at_carrier ?c ?l1)))
                    (at end (located_at_robot ?r ?l2))
                    (at end (located_at_carrier ?c ?l2))
        )
    )

    ; attach a carrier to a robot
    (:durative-action attach_carrier_to_robot
        :parameters (?r - robotic_agent ?l1 - location ?c - carrier)
        :duration (= ?duration 2)
        :condition (and 
                        (at start (carrier_has_no_robot ?c)) 
                        (at start (robot_has_no_carrier ?r))
                        (over all (located_at_robot ?r ?l1)) 
                        (over all (located_at_carrier ?c ?l1))
        )
        :effect (and 
                    (at start (not (carrier_has_no_robot ?c))) 
                    (at start (not (robot_has_no_carrier ?r)))
                    (at end (robot_carrier_attached ?r ?c)) 
                    (at end (carrier_has_no_boxes ?c)) ; assumption that the carrier is initially empty or is cleaned from all boxes by external agents
        )
    )

    ; detach a carrier from a robot
    (:durative-action detach_carrier_from_robot
        :parameters (?r - robotic_agent ?l1 - location ?c - carrier)
        :duration (= ?duration 2)
        :condition (and 
                        (at start (robot_carrier_attached ?r ?c)) 
                        (at start (carrier_has_no_boxes ?c))
                        (over all (located_at_robot ?r ?l1)) 
        )
        :effect (and 
                    (at start (not (robot_carrier_attached ?r ?c)))
                    (at start (not (carrier_has_four_boxes ?c))) 
                    (at end (carrier_has_no_robot ?c)) 
                    (at end (robot_has_no_carrier ?r))
        )
    )

    ; load box on the carrier
    (:durative-action load_box_on_carrier
        :parameters (?c - carrier ?b - box ?l - location ?r - robotic_agent)
        :duration (= ?duration 3)
        :condition (and 
                        (at start (located_at_box ?b ?l))
                        (at start (not (box_loaded ?b)))
                        (at start (not (box_on_carrier ?b ?c)))
                        (over all (located_at_carrier ?c ?l))
                        (over all (located_at_robot ?r ?l))
                        (over all (not (box_is_empty ?b)))
                        ; (at start (or 
                        ;         (carrier_has_no_boxes ?c)
                        ;         (carrier_has_one_box ?c)
                        ;         (carrier_has_two_boxes ?c)
                        ;         (carrier_has_three_boxes ?c)) ; if (carrier_has_four_boxes ?c) == TRUE, means we reach max of boxes to load, no more boxes can be loaded
                        ; )
        )
        :effect (and 
            (at start (not (located_at_box ?b ?l)))
            (at end (box_on_carrier ?b ?c))
            (at end (box_loaded ?b))
                ; (when (carrier_has_no_boxes ?c)
                ;     (and
                ;         (not (carrier_has_no_boxes ?c))
                ;         (carrier_has_one_box ?c)))
                ; (when (carrier_has_one_box ?c)
                ;     (and
                ;         (not (carrier_has_one_box ?c))
                ;         (carrier_has_two_boxes ?c)))
                ; (when (carrier_has_two_boxes ?c)
                ;     (and
                ;         (not (carrier_has_two_boxes ?c))
                ;         (carrier_has_three_boxes ?c)))
                ; (when (carrier_has_three_boxes ?c)
                ;     (and
                ;         (not (carrier_has_three_boxes ?c))
                ;         (carrier_has_four_boxes ?c)))
        )
    )

    ; unload box from carrier
    (:durative-action unload_box_from_carrier
        :parameters (?c - carrier ?b - box ?l - location ?r - robotic_agent)
        :duration (= ?duration 3)
        :condition (and 
            (at start (box_on_carrier ?b ?c))
            (at start (box_loaded ?b))
            (over all (located_at_carrier ?c ?l))
            (over all (located_at_robot ?r ?l))
                    ;         (or 
                    ; (carrier_has_one_box ?c)
                    ; (carrier_has_two_boxes ?c)
                    ; (carrier_has_three_boxes ?c)
                    ; (carrier_has_four_boxes ?c))
        )
        :effect (and 
            (at start (located_at_box ?b ?l))
            (at end (not (box_on_carrier ?b ?c)))
            (at end (not (box_loaded ?b)))
                ; (when (carrier_has_one_box ?c)
                ;     (and
                ;         (not (carrier_has_one_box ?c))
                ;         (carrier_has_no_boxes ?c)))
                ; (when (carrier_has_two_boxes ?c)
                ;     (and
                ;         (not (carrier_has_two_boxes ?c))
                ;         (carrier_has_one_box ?c)))
                ; (when (carrier_has_three_boxes ?c)
                ;     (and
                ;         (not (carrier_has_three_boxes ?c))
                ;         (carrier_has_two_boxes ?c)))
                ; (when (carrier_has_four_boxes ?c)
                ;     (and
                ;         (not (carrier_has_four_boxes ?c))
                ;         (carrier_has_three_boxes ?c)))
        )
    )

    ; fill the box with a supply
    (:durative-action fill_box ; box is required to not be on a carrier to be filled
        :parameters (?r - robotic_agent ?l1 - location ?b - box ?s - supply)
        :duration (= ?duration 4)
        :condition (and 
            (at start (located_at_supply ?s ?l1)) 
            (at start (box_is_empty ?b)) 
            (at start (not (box_loaded ?b)))
            (over all (located_at_robot ?r ?l1)) 
            (over all (located_at_box ?b ?l1))
        )
        :effect (and 
            (at start (not (located_at_supply ?s ?l1))) 
            (at start (not (box_is_empty ?b)))
            (at end (box_with_supply ?b ?s)) 
        )
    )
    
    (:durative-action deliver ; box is required to not be on a carrier to have its supply delivered
        :parameters (?r - robotic_agent ?l1 - location ?p - person ?s - supply ?b - box)
        :duration (= ?duration 3)
        :condition (and 
            (at start (box_with_supply ?b ?s)) 
            (at start (not (box_is_empty ?b))) 
            (at start (not (box_loaded ?b)))
            (over all (located_at_robot ?r ?l1)) 
            (over all (located_at_person ?p ?l1)) 
            (over all (located_at_box ?b ?l1)) 
        )
        :effect (and 
            (at start (not (box_with_supply ?b ?s))) 
            (at end (delivered ?p ?s)) 
            (at end (box_is_empty ?b))
        )
    )

)