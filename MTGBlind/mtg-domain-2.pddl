;;;
;;; A domain for modeling stories for a variant of MTG
;;; Created by Vincent Liu
;;;
(define (domain mtg)
  (:requirements :adl :domain-axioms :intentionality)
  (:types ; Players/Hands.
          you opponent - player
		  ; Cards that exist.
		  wincon interaction - card
		  counter discard - interaction)
  (:constant )
  (:predicates 
               ; A card is played
			   (played ?card - card)
			   ; A card is resolved
			   (resolved ?card - card)
			   ; A card is removed
			   (removed ?card - card)
			   
			   ; A card is played by
			   (playedby ?card - card ?player - player)
			   ; A card is resolved by
               (resolvedby ?card - card ?player - player)
			   
			   ; An interaction targets a card
			   (targets ?interaction - interaction ?target - card)
			   
			   ; A player has a card
               (has ?player - player ?card - card)
			   
			   ;A player has won
			   (won ?player - player))

  ;; A player plays a wincon.
  (:action play_wincon
    :parameters   (?player - player ?wincon - wincon)
    :precondition (and (has ?player ?wincon)
					   (not (playedby ?wincon ?player)))
    :effect       (and (playedby ?wincon ?player)
                       (not (has ?player ?wincon)))
    :agents       (?player))
	
  ;; A player plays a counter.
  (:action play_counter
    :parameters   (?player - player ?opponent - player ?counter - counter ?target - card)
    :precondition (and (has ?player ?counter)
					   (not (playedby ?counter ?player))
					   (playedby ?target ?opponent)
					   (not (or (resolvedby ?target ?player)
					            (resolvedby ?target ?opponent)))
					   (not (removed ?target)))
					   
    :effect       (and (playedby ?counter ?player)
                       (targets ?counter ?target)
					   (not (has ?player ?counter)))
					   
    :agents       (?player))
	
  ;; A player plays a discard.
  (:action play_discard
    :parameters   (?player - player ?opponent - player ?discard - discard ?target - card)
    :precondition (and (has ?player ?discard)
					   (not (playedby ?discard ?player))
					   (has ?opponent ?target - card))
    :effect       (and (playedby ?discard ?player)
                       (not (has ?player ?discard))
					   (targets ?discard ?target))
    :agents       (?player))
	
	
  ;; A player resolves a wincon.
  (:action resolve_wincon
    :parameters   (?player - player ?card - card)
    :precondition (and (playedby ?card ?player)
					   (not (resolvedby ?card ?player))
					   (not (removed ?card)))
    :effect       (and (resolvedby ?card ?player)
					   (won ?player))
    :agents       (?player))
	
  ;; A player resolves an interaction.
  (:action resolve_interaction
    :parameters   (?player - player ?opponent - player ?interaction - interaction ?target - card)
    :precondition (and (playedby ?interaction ?player)
					   (not (resolvedby ?interaction ?player))
					   (not (removed ?target))
					   (targets ?interaction ?target))
    :effect       (and (resolvedby ?interaction ?player)
					   (not (has ?player ?interaction))
					   (not (has ?opponent ?target))
					   (removed ?target))
    :agents       (?player)))