(define (domain problem2)
  (:requirements :strips :typing :equality :negative-preconditions :disjunctive-preconditions)
  (:types
    person robotic_agent location box carrier supply - object
    food medicine tools - supply
  )

  (:predicates
    (location_person ?p - person ?l - location)
    (location_robot ?r - robotic_agent ?l - location)
    (location_box ?b - box ?l - location)
    (location_supply ?s - supply ?l - location)
    (location_carrier ?c - carrier ?l - location)
    (box_with_supply ?b - box ?s - supply)
    (box_is_empty ?b - box)
    (delivered ?p - person ?s - supply)
    (box_on_carrier ?b - box ?c - carrier)
    (boxes_on_carrier ?c - carrier ?n - number)
    (box_off_carrier ?b - box ?c - carrier ?l - location)
    (carrier_has_no_robot ?c - carrier)
    (robot_has_no_carrier ?r - robotic_agent)
  )

  (:action move_robot
    :parameters (?r - robotic_agent ?l1 - location ?l2 - location)
    :precondition (and (location_robot ?r ?l1) (not (= ?l1 ?l2)))
    :effect (and (not (location_robot ?r ?l1)) (location_robot ?r ?l2))
  )

;   (:action attach_carrier_to_robot
;     :parameters (?r - robotic_agent ?l1 - location ?c - carrier)

;   )

)
