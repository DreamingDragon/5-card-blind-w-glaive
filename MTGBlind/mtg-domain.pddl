;;;
;;; A domain for modeling stories for a variant of MTG
;;; Created by Vincent Liu
;;;
(define (domain mtg)
  (:requirements :adl :domain-axioms :intentionality)
  (:types ; Players/Hands.
          you opponent - player
		  ; Cards that exist.
		  black_lotus blue_card black_card thassas_oracle force_of_will unmask - card
		  
		  black_lotus blue_card black_card - resource
		  thassas_oracle - wincon
		  force_of_will - counter
		  unmask - discard

		  ; Establish Turn Order
		  active_player - priority 
		  )
	(:constant 
  (:predicates ; A wincon is resolved.
               (resolvedby ?wincon - wincon ?player - player)
			   ; A wincon is played.
			   (playedby ?wincon - wincon ?player - player)
			   
			   ; A resource is played.
			   (playedby ?resource - resource ?player - player)
			   
			   ; A counter is resolved.
               (resolvedby ?counter - counter ?player - player)
			   ; A counter is played.
			   (playedby ?counter - counter)
			   
			   ; A discard is resolved.
               (resolvedby ?discard - discard)
			   ; A discardby is played.
			   (playedby ?discard - discard)
			   
			   ; A player has a resource.
               (has ?player - player ?resource - resource)
			   ; A player has a discard.
               (has ?player - player ?discard - discard)
			   ; A player has a counter.
               (has ?player - player ?counter - counter)
			   ; A player has a wincon.
               (has ?player - player ?wincon - wincon)
			   ; A play has priority.
               (has ?player - player ?priority - priority)
               ; A counter is paid.
			   (paid ?counter - counter)
			   ; A discard is paid.
			   (paid ?discard - discard)
			   ; A wincon is paid
			   (paid ?wincon - wincon)
			   
			   ;A player has won
			   (won ?player - player)

  ;; A player plays a wincon.
  (:action play_wincon
    :parameters   (?player - player ?wincon - wincon)
    :precondition (and (paid ?wincon)
					   (has ?player ?wincon)
					   (not (playedby ?wincon ?player)))
    :effect       (and (playedby ?wincon ?player)
                       (not (has ?player ?wincon)))
    :agents       (?player))
	
  ;; A player resolves a wincon.
  (:action resolve_wincon
    :parameters   (?player - player ?opponent - player ?wincon - wincon)
    :precondition (and (playedby ?wincon ?opponent)
					   (not (resolvedby ?wincon ?player))
    :effect       (and (resolvedby ?wincon ?player)
                       (won ?opponent))
    :agents       (?player))
	
  ;; A player plays a counter.
  (:action play_counter
    :parameters   (?player - player ?counter - counter)
    :precondition (and (paid ?counter)
					   (has ?player ?wincon)
					   (not (playedby ?wincon ?player)))
    :effect       (and (playedby ?wincon ?player)
                       (not (has ?player ?wincon)))
    :agents       (?player))
	
  ;; A player resolves a counter.
  (:action resolve_counter
    :parameters   (?player - player ?opponent - player ?counter - counter)
    :precondition (and (playedby ?counter ?opponent)
					   (not (resolvedby ?counter ?player))
    :effect       (and (resolvedby ?counter ?player)
                       (not (has ?opponent)))
    :agents       (?player))
	
  ;; A player plays a discard.
  (:action play_wincon
    :parameters   (?player - player ?opponent - player)
    :precondition (and (paid ?discard)
					   (has ?player ?discard)
					   (not (playedby ?discard ?player)))
    :effect       (and (playedby ?discard ?player)
                       (not (has ?player ?discard)))
    :agents       (?player))
	
  ;; A player resolves a discard.
  (:action resolve_wincon
    :parameters   (?player - player ?opponent - player ?discard - discard)
    :precondition (and (playedby ?discard ?opponent)
					   (not (resolvedby ?discard ?player))
    :effect       (and (resolvedby ?discard ?player)
                       (won ?opponent))
    :agents       (?player))

  ;; One person proposes to another.
  (:action propose
    :parameters   (?proposer - person ?proposee - person ?place - place)
	:precondition (and (alive ?proposer)
	                   (at ?proposer ?place)
					   (alive ?proposee)
					   (at ?proposee ?place)
					   (loves ?proposer ?proposee))
	:effect       (hasproposed ?proposer ?proposee)
	:agents       (?proposer))

  ;; One person accepts another's proposal.
  (:action accept
    :parameters   (?accepter - person ?proposer - person ?place - place)
	:precondition (and (alive ?accepter)
	                   (at ?accepter ?place)
					   (alive ?proposer)
					   (at ?proposer ?place)
					   (hasproposed ?proposer ?accepter))
	:effect       (hasaccepted ?accepter ?proposer)
	:agents       (?accepter))

  ;; Two people marry.
  (:action marry
    :parameters   (?groom - person ?bride - person ?place - place)
	:precondition (and (alive ?groom)
	                   (at ?groom ?place)
					   (hasproposed ?groom ?bride)
					   (single ?groom)
					   (alive ?bride)
					   (at ?bride ?place)
					   (hasaccepted ?bride ?groom)
					   (single ?bride))
	:effect       (and (marriedto ?groom ?bride)
					   (marriedto ?bride ?groom)
					   (not (single ?groom))
					   (not (single ?bride))
	                   (forall (?v - valuable)
					           (when (has ?groom ?v)
							         (rich ?bride)))
					   (when (loves ?groom ?bride)
					         (happy ?groom))
					   (when (loves ?bride ?groom)
					         (happy ?bride)))
	:agents       (?groom ?bride))

  ;; A creature steals an object from another creature.
  (:action steal
    :parameters   (?thief - creature ?victim - creature ?item - item ?place - place)
	:precondition (and (not (= ?thief ?victim))
	                   (alive ?thief)
	                   (at ?thief ?place)
					   (at ?item ?place)
					   (belongsto ?item ?victim))
	:effect       (and (has ?thief ?item)
	                   (when (at ?victim ?place)
					         (intends ?victim (has ?victim ?item)))
					   (when (forall (?v - valuable)
                                     (not (has ?victim ?v)))
					         (not (rich ?victim))))
	:agents       (?thief))

  ;; A creature becomes hungry.
  (:action get-hungry
    :parameters   (?creature - creature)
	:precondition (not (hungry ?creature))
	:effect       (and (hungry ?creature)
					   (intends ?creature (not (hungry ?creature))))
	:agents       (?creature))

  ;; A monster eats another creature.
  (:action eat
    :parameters   (?monster - monster ?creature - creature ?place - place)
	:precondition (and (alive ?monster)
	                   (at ?monster ?place)
					   (hungry ?monster)
					   (alive ?creature)
					   (at ?creature ?place))
	:effect       (and (not (hungry ?monster))
	                   (not (alive ?creature))
					   (not (rich ?creature))
					   (not (happy ?creature)))
	:agents       (?monster)))