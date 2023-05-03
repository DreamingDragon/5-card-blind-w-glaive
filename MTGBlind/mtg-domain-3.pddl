;;;
;;; A domain for modeling stories for a variant of MTG
;;; Created by Vincent Liu
;;;
(define (domain mtg)
  (:requirements :adl :domain-axioms :intentionality)
  (:types ; Players/Hands.
          player - character
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
			   (playedby ?card - card ?player - character)
			   ; A card is resolved by
               (resolvedby ?card - card ?player - character)
			   
			   ; An interaction targets a card
			   (targets ?interaction - interaction ?target - card)
			   
			   ; A player has a card
               (has ?player - character ?card - card)
			   
			   ; A card must resolve or remove before win
			   (must-resolve-remove-before-win ?card - card)
			   
			   ;A player has won
			   (won ?player - character))

  ;; A player plays a wincon.
  (:action play_wincon
    :parameters   (?player - character ?wincon - wincon)
    :precondition (and (has ?player ?wincon)
					   (not (playedby ?wincon ?player))
					   (not (exists (?interaction - card) (must-resolve-remove-before-win ?interaction))))
    :effect       (and (playedby ?wincon ?player)
                       (not (has ?player ?wincon)))
    :agents       (?player))
	
  ;; A player plays a counter.
  (:action play_counter
    :parameters   (?player - character ?opponent - character ?counter - counter ?target - card)
    :precondition (and (has ?player ?counter)
					   (not (playedby ?counter ?player))
					   (playedby ?target ?opponent)
					   (not (or (resolvedby ?target ?player)
					            (resolvedby ?target ?opponent)))
					   (not (removed ?target)))
					   
    :effect       (and (playedby ?counter ?player)
                       (targets ?counter ?target)
					   (not (has ?player ?counter))
					   (must-resolve-remove-before-win ?counter))
					   
    :agents       (?player))
	
  ;; A player plays a discard.
  (:action play_discard
    :parameters   (?player - character ?opponent - character ?discard - discard ?target - card)
    :precondition (and (has ?player ?discard)
					   (not (playedby ?discard ?player))
					   (has ?opponent ?target - card))
    :effect       (and (playedby ?discard ?player)
                       (not (has ?player ?discard))
					   (targets ?discard ?target)
					   (must-resolve-remove-before-win ?discard))
    :agents       (?player))
	
	
  ;; A player resolves a wincon.
  (:action resolve_wincon
    :parameters   (?player - character ?wincon - wincon)
    :precondition (and (playedby ?wincon ?player)
					   (not (resolvedby ?wincon ?player))
					   (not (removed ?wincon))
					   (not (exists (?interaction - card) (must-resolve-remove-before-win ?interaction))))
    :effect       (and (resolvedby ?wincon ?player)
					   (won ?player))
    :agents       (?player))
	
  ;; A player resolves an interaction.
  (:action resolve_interaction
    :parameters   (?player - character ?opponent - character ?interaction - interaction ?target - card)
    :precondition (and (playedby ?interaction ?player)
					   (not (resolvedby ?interaction ?player))
					   (not (removed ?target))
					   (targets ?interaction ?target))
    :effect       (and (resolvedby ?interaction ?player)
					   (not (has ?player ?interaction))
					   (not (has ?opponent ?target))
					   (removed ?target)
					   (removed ?interaction))
    :agents       (?player))
	
	;; When a card is removed, it is not on the stack.
  (:axiom
    :vars    (?card - card)
    :context (removed ?card)
    :implies (not (must-resolve-remove-before-win ?card)))
	)