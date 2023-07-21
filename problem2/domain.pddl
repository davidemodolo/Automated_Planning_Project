(define (domain problem2)
    (:requirements :strips :typing :equality :negative-preconditions :disjunctive-preconditions :conditional-effects :existential-preconditions :universal-preconditions)
    (:types
        person robotic_agent location box carrier supply - object
        food medicine tools - supply
    )
    (:predicates
        (location_robot ?r - robotic_agent ?l - location)
        (location_box ?b - box ?l - location)
        (location_carrier ?c - carrier ?l - location)
        (location_supply ?s - supply ?l - location)
        (location_person ?p - person ?l - location)
        (box_on_carrier ?b - box ?c - carrier)
        (box_loaded ?b - box)
        (box_is_empty ?b - box)
        (box_with_supply ?b - box ?s - supply)
        (carrier_has_no_robot ?c - carrier)
        (robot_has_no_carrier ?r - robotic_agent)
        (robot_carrier_attached ?r - robotic_agent ?c - carrier)
        ; since a carrier can load only up to 4 boxes, we create all the predicates
        (carrier_has_box1 ?c - carrier)
        (carrier_has_box2 ?c - carrier)
        (carrier_has_box3 ?c - carrier)
        (carrier_has_box4 ?c - carrier)
        (carrier_loaded_1 ?c - carrier ?b - box)
        (carrier_loaded_2 ?c - carrier ?b - box)
        (carrier_loaded_3 ?c - carrier ?b - box)
        (carrier_loaded_4 ?c - carrier ?b - box)
        (delivered ?p - person ?s - supply)
    )

    ; move the robot
    (:action move_robot
        :parameters (?r - robotic_agent ?l1 - location ?l2 - location)
        :precondition (and (location_robot ?r ?l1) (not (= ?l1 ?l2)) (robot_has_no_carrier ?r))
        :effect (and
            (not (location_robot ?r ?l1))
            (location_robot ?r ?l2)
        )
    )

    ; attach a carrier to a robot
    (:action attach_carrier_to_robot
        :parameters (?r - robotic_agent ?l1 - location ?c - carrier)
        :precondition (and (location_robot ?r ?l1) (location_carrier ?c ?l1) (carrier_has_no_robot ?c) (robot_has_no_carrier ?r))
        :effect (and (not (carrier_has_no_robot ?c)) (not (robot_has_no_carrier ?r)) (robot_carrier_attached ?r ?c))
    )

    ; detatch a carrier from a robot
    (:action detatch_carrier_from_robot
        :parameters (?r - robotic_agent ?l1 - location ?c - carrier)
        :precondition (and (location_robot ?r ?l1) (robot_carrier_attached ?r ?c))
        :effect (and (carrier_has_no_robot ?c) (robot_has_no_carrier ?r)
            (not (robot_carrier_attached ?r ?c)))
    )

    ; move a robot with a carrier attached
    (:action move_robot_with_carrier_no_box
        :parameters (?r - robotic_agent ?l1 - location ?l2 - location ?c - carrier)
        :precondition (and
            (location_robot ?r ?l1)
            (location_carrier ?c ?l1)
            (robot_carrier_attached ?r ?c)
            (not (= ?l1 ?l2))
            (not (carrier_has_box1 ?c))
            (not (carrier_has_box2 ?c))
            (not (carrier_has_box3 ?c))
            (not (carrier_has_box4 ?c))
        )
        :effect (and
            (not (location_robot ?r ?l1))
            (location_robot ?r ?l2)
            (not (location_carrier ?c ?l1))
            (location_carrier ?c ?l2)
        )
    )

    (:action move_robot_with_carrier_box1
        :parameters (?r - robotic_agent ?l1 - location ?l2 - location ?c - carrier ?b - box)
        :precondition (and
            (location_robot ?r ?l1)
            (location_carrier ?c ?l1)
            (location_box ?b ?l1)
            (robot_carrier_attached ?r ?c)
            (not (= ?l1 ?l2)) (carrier_has_box1 ?c)
            (carrier_loaded_1 ?c ?b)
            (not (carrier_has_box2 ?c)) (not (carrier_has_box3 ?c)) (not (carrier_has_box4 ?c))
            (box_loaded ?b)
        )
        :effect (and
            (not (location_robot ?r ?l1))
            (location_robot ?r ?l2)
            (not (location_carrier ?c ?l1))
            (location_carrier ?c ?l2)
            (not (location_box ?b ?l1))
            (location_box ?b ?l2)
        )
    )

    (:action move_robot_with_carrier_box12
        :parameters (?r - robotic_agent ?l1 - location ?l2 - location ?c - carrier ?b1 - box ?b2 - box)
        :precondition (and
            (location_robot ?r ?l1)
            (location_carrier ?c ?l1)
            (location_box ?b1 ?l1)
            (location_box ?b2 ?l1)
            (robot_carrier_attached ?r ?c)
            (not (= ?l1 ?l2)) (carrier_has_box1 ?c) (carrier_has_box2 ?c)
            (carrier_loaded_1 ?c ?b1) (carrier_loaded_2 ?c ?b2)
            (not (carrier_has_box3 ?c)) (not (carrier_has_box4 ?c))
            (box_loaded ?b1) (box_loaded ?b2)
        )
        :effect (and
            (not (location_robot ?r ?l1))
            (location_robot ?r ?l2)
            (not (location_carrier ?c ?l1))
            (location_carrier ?c ?l2)
            (not (location_box ?b1 ?l1))
            (location_box ?b1 ?l2)
            (not (location_box ?b2 ?l1))
            (location_box ?b2 ?l2)
        )

    )

    (:action move_robot_with_carrier_box123
        :parameters (?r - robotic_agent ?l1 - location ?l2 - location ?c - carrier ?b1 - box ?b2 - box ?b3 - box)
        :precondition (and
            (location_robot ?r ?l1)
            (location_carrier ?c ?l1)
            (location_box ?b1 ?l1)
            (location_box ?b2 ?l1)
            (location_box ?b3 ?l1)
            (robot_carrier_attached ?r ?c)
            (not (= ?l1 ?l2)) (carrier_has_box1 ?c) (carrier_has_box2 ?c) (carrier_has_box3 ?c)
            (carrier_loaded_1 ?c ?b1) (carrier_loaded_2 ?c ?b2) (carrier_loaded_3 ?c ?b3)
            (box_loaded ?b1) (box_loaded ?b2) (box_loaded ?b3)
            (not (carrier_has_box4 ?c))
        )
        :effect (and
            (not (location_robot ?r ?l1))
            (location_robot ?r ?l2)
            (not (location_carrier ?c ?l1))
            (location_carrier ?c ?l2)
            (not (location_box ?b1 ?l1))
            (location_box ?b1 ?l2)
            (not (location_box ?b2 ?l1))
            (location_box ?b2 ?l2)
            (not (location_box ?b3 ?l1))
            (location_box ?b3 ?l2)
        )
    )

    (:action move_robot_with_carrier_box1234
        :parameters (?r - robotic_agent ?l1 - location ?l2 - location ?c - carrier ?b1 - box ?b2 - box ?b3 - box ?b4 - box)
        :precondition (and
            (location_robot ?r ?l1)
            (location_carrier ?c ?l1)
            (location_box ?b1 ?l1)
            (location_box ?b2 ?l1)
            (location_box ?b3 ?l1)
            (location_box ?b4 ?l1)
            (robot_carrier_attached ?r ?c)
            (not (= ?l1 ?l2)) (carrier_has_box1 ?c) (carrier_has_box2 ?c) (carrier_has_box3 ?c) (carrier_has_box4 ?c)
            (carrier_loaded_1 ?c ?b1) (carrier_loaded_2 ?c ?b2) (carrier_loaded_3 ?c ?b3) (carrier_loaded_4 ?c ?b4)
            (box_loaded ?b1) (box_loaded ?b2) (box_loaded ?b3) (box_loaded ?b4)
        )
        :effect (and
            (not (location_robot ?r ?l1))
            (location_robot ?r ?l2)
            (not (location_carrier ?c ?l1))
            (location_carrier ?c ?l2)
            (not (location_box ?b1 ?l1))
            (location_box ?b1 ?l2)
            (not (location_box ?b2 ?l1))
            (location_box ?b2 ?l2)
            (not (location_box ?b3 ?l1))
            (location_box ?b3 ?l2)
            (not (location_box ?b4 ?l1))
            (location_box ?b4 ?l2)
        )
    )

    ; assumption: a box can be loaded by a robot even if it is not attached to the carrier
    (:action load_box1_on_carrier
        :parameters (?c - carrier ?b - box ?l - location ?r - robotic_agent)
        :precondition (and
            (location_carrier ?c ?l)
            (location_box ?b ?l)
            (location_robot ?r ?l)
            (not (box_loaded ?b))
            (not(carrier_has_box1 ?c))
        )
        :effect (and
            (box_on_carrier ?b ?c)
            (box_loaded ?b)
            (carrier_has_box1 ?c)
            (carrier_loaded_1 ?c ?b)
        )
    )

    ; now the unload
    (:action unload_box1_from_carrier
        :parameters (?c - carrier ?b - box ?l - location ?r - robotic_agent)
        :precondition (and
            (location_carrier ?c ?l)
            (location_box ?b ?l)
            (box_on_carrier ?b ?c)
            (box_loaded ?b)
            (location_robot ?r ?l)
            (carrier_loaded_1 ?c ?b)
            (carrier_has_box1 ?c)
            (not (carrier_has_box2 ?c)) (not (carrier_has_box3 ?c)) (not (carrier_has_box4 ?c))
        )
        :effect (and
            (not (box_on_carrier ?b ?c))
            (not (box_loaded ?b))
            (location_box ?b ?l)
            (not (carrier_has_box1 ?c))
            (not (carrier_loaded_1 ?c ?b))
        )
    )

    (:action load_box2_on_carrier
        :parameters (?c - carrier ?b - box ?l - location ?r - robotic_agent)
        :precondition (and
            (location_carrier ?c ?l)
            (location_box ?b ?l)
            (location_robot ?r ?l)
            (not (box_loaded ?b))
            (carrier_has_box1 ?c)
            (not(carrier_has_box2 ?c))
        )
        :effect (and
            (box_on_carrier ?b ?c)
            (box_loaded ?b)
            (carrier_has_box2 ?c)
            (carrier_loaded_2 ?c ?b)
        )
    )

    (:action unload_box2_from_carrier
        :parameters (?c - carrier ?b - box ?l - location ?r - robotic_agent)
        :precondition (and 
            (location_carrier ?c ?l)
            (location_box ?b ?l)
            (box_on_carrier ?b ?c)
            (box_loaded ?b)
            (location_robot ?r ?l)
            (carrier_loaded_2 ?c ?b)
            (carrier_has_box2 ?c)
            (not (carrier_has_box3 ?c)) (not (carrier_has_box4 ?c))
        )
        :effect (and
            (not (box_on_carrier ?b ?c))
            (not (box_loaded ?b))
            (location_box ?b ?l)
            (not (carrier_has_box2 ?c))
            (not (carrier_loaded_2 ?c ?b))
        )
    )

    (:action load_box3_on_carrier
        :parameters (?c - carrier ?b - box ?l - location ?r - robotic_agent)
        :precondition (and
            (location_carrier ?c ?l)
            (location_box ?b ?l)
            (location_robot ?r ?l)
            (not (box_loaded ?b))
            (carrier_has_box1 ?c)
            (carrier_has_box2 ?c)
            (not(carrier_has_box3 ?c))
        )
        :effect (and
            (box_on_carrier ?b ?c)
            (box_loaded ?b)
            (carrier_has_box3 ?c)
            (carrier_loaded_3 ?c ?b)
        )
    )
    

    (:action unload_box3_from_carrier
        :parameters (?c - carrier ?b - box ?l - location ?r - robotic_agent)
        :precondition (and 
            (location_carrier ?c ?l)
            (location_box ?b ?l)
            (box_on_carrier ?b ?c)
            (box_loaded ?b)
            (location_robot ?r ?l)
            (carrier_loaded_3 ?c ?b)
            (carrier_has_box3 ?c)
            (not (carrier_has_box4 ?c))
        )
        :effect (and
            (not (box_on_carrier ?b ?c))
            (not (box_loaded ?b))
            (location_box ?b ?l)
            (not (carrier_has_box3 ?c))
            (not (carrier_loaded_3 ?c ?b))
        )
    )

    (:action load_box4_on_carrier
        :parameters (?c - carrier ?b - box ?l - location ?r - robotic_agent)
        :precondition (and
            (location_carrier ?c ?l)
            (location_box ?b ?l)
            (location_robot ?r ?l)
            (not (box_loaded ?b))
            (carrier_has_box1 ?c)
            (carrier_has_box2 ?c)
            (carrier_has_box3 ?c)
            (not(carrier_has_box4 ?c))
        )
        :effect (and
            (box_on_carrier ?b ?c)
            (box_loaded ?b)
            (carrier_has_box4 ?c)
            (carrier_loaded_4 ?c ?b)
        )
    )
    

    (:action unload_box4_from_carrier
        :parameters (?c - carrier ?b - box ?l - location ?r - robotic_agent)
        :precondition (and 
            (location_carrier ?c ?l)
            (location_box ?b ?l)
            (box_on_carrier ?b ?c)
            (box_loaded ?b)
            (location_robot ?r ?l)
            (carrier_loaded_4 ?c ?b)
            (carrier_has_box4 ?c)
        )
        :effect (and
            (not (box_on_carrier ?b ?c))
            (not (box_loaded ?b))
            (location_box ?b ?l)
            (not (carrier_has_box4 ?c))
            (not (carrier_loaded_4 ?c ?b))
        )
    )
    

    (:action fill_box ; box is required to not be on a carrier to be filled
        :parameters (?r - robotic_agent ?l1 - location ?b - box ?s - supply)
        :precondition (and (location_robot ?r ?l1) (location_supply ?s ?l1) (box_is_empty ?b) (location_box ?b ?l1) (not (box_loaded ?b)))
        :effect (and (not (location_supply ?s ?l1)) (box_with_supply ?b ?s) (not (box_is_empty ?b)))
    )

    (:action deliver ; box is required to not be on a carrier to have its supply delivered
        :parameters (?r - robotic_agent ?l1 - location ?p - person ?s - supply ?b - box)
        :precondition (and (location_robot ?r ?l1) (location_person ?p ?l1) (location_box ?b ?l1) (box_with_supply ?b ?s) (not (box_is_empty ?b)) (not (box_loaded ?b)))
        :effect (and (not (box_with_supply ?b ?s)) (delivered ?p ?s) (box_is_empty ?b))
    )

)