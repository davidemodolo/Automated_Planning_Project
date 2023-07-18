(define (domain problem2)
    (:requirements :strips :typing :equality :negative-preconditions :disjunctive-preconditions :conditional-effects :existential-preconditions :universal-preconditions) ; :numeric-fluents
    (:types
        person robotic_agent location box carrier supply - object
        food medicine tools - supply
    )
    (:functions
        (num-boxes ?c - carrier)
    )
    ;   (= (num-boxes ?c) 4) , (- (num-boxes ?c) 1) and (forall (?b - box) (and (in ?b ?c) (loaded ?b)))
    (:predicates
        (location_robot ?r - robotic_agent ?l - location)
        (location_box ?b - box ?l - location)
        (location_carrier ?c - carrier ?l - location)
        (box_on_carrier ?b - box ?c - carrier)
        (box_loaded ?b - box)
        (carrier_has_no_robot ?c - carrier)
        (robot_has_no_carrier ?r - robotic_agent)
        (robot_carrier_attached ?r - robotic_agent ?c - carrier)
    )

    ; move the robot
    (:action move_robot
        :parameters (?r - robotic_agent ?l1 - location ?l2 - location)
        :precondition (and (location_robot ?r ?l1) (not (= ?l1 ?l2)))
        :effect (and
            (not (location_robot ?r ?l1))
            (location_robot ?r ?l2)
            (forall
                (?c - carrier)
                (when
                    (robot_carrier_attached ?r ?c)
                    (and (not (location_carrier ?c ?l1))
                        (location_carrier ?c ?l2))
                )
            )

            (forall
                (?b - box)
                (when
                    (exists
                        (?c - carrier)
                        (and
                            (robot_carrier_attached ?r ?c)
                            (box_on_carrier ?b ?c)
                        )
                    )
                    (and
                        (not (location_box ?b ?l1))
                        (location_box ?b ?l2)
                    )
                   
                )
            )
        )
    )

    ; attach a carrier to a robot
    (:action attach_carrier_to_robot
        :parameters (?r - robotic_agent ?l1 - location ?c - carrier)
        :precondition (and (location_robot ?r ?l1) (location_carrier ?c ?l1) (carrier_has_no_robot ?c) (robot_has_no_carrier ?r))
        :effect (and (not (location_carrier ?c ?l1)) (not (carrier_has_no_robot ?c)) (not (robot_has_no_carrier ?r)) (location_carrier ?c ?l1) (robot_carrier_attached ?r ?c))
    )
    ; move a robot with a carrier attached
    ; (:action move_robot_with_carrier
    ;     :parameters (?r - robotic_agent ?l1 - location ?l2 - location ?c - carrier)
    ;     :precondition (and (location_robot ?r ?l1) (location_carrier ?c ?l1) (not (= ?l1 ?l2)) (robot_carrier_attached ?r ?c))
    ;     :effect (and
    ;         (not (location_robot ?r ?l1))
    ;         (location_robot ?r ?l2)
    ;         (not (location_carrier ?c ?l1))
    ;         (location_carrier ?c ?l2)
    ;         ; move every box
    ;         (forall (?b - box)
    ;             (when (box_on_carrier ?b ?c)
    ;                  (location_box ?b ?l2)
    ;             )
    ;         )
    ;     )
    ; )

    ; detatch a carrier from a robot
    (:action detatch_carrier_from_robot
        :parameters (?r - robotic_agent ?l1 - location ?c - carrier)
        :precondition (and (location_robot ?r ?l1) (location_carrier ?c ?l1) (not (carrier_has_no_robot ?c)) (not (robot_has_no_carrier ?r)) (robot_carrier_attached ?r ?c))
        :effect (and (location_robot ?r ?l1) (carrier_has_no_robot ?c) (robot_has_no_carrier ?r) (location_carrier ?c ?l1) (not (robot_carrier_attached ?r ?c)))
    )

    ; assumption: a box can be loaded by a robot even if it is not attached
    (:action load_box_on_carrier
        :parameters (?c - carrier ?b - box ?l - location ?r - robotic_agent)
        :precondition (and (location_carrier ?c ?l) (location_box ?b ?l) (not (box_loaded ?b)) (< (num-boxes ?c) 4) (location_robot ?r ?l))
        :effect (and (not (location_box ?b ?l)) (box_on_carrier ?b ?c) (box_loaded ?b) (increase (num-boxes ?c) 1))
    )

)