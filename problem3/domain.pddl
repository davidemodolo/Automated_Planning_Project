(define (domain problem2)
    (:requirements :strips :typing :equality :negative-preconditions :disjunctive-preconditions :conditional-effects :existential-preconditions :universal-preconditions :hierachie)

    ; Define types and predicates (same as in the original domain)

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
)
