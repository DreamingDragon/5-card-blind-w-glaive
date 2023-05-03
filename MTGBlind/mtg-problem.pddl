;;;
;;; A highly simplified problem for a MTG game
;;; Created by Vincent Liu
;;;
(define (problem win-with-one-discard-one-counter)
  (:domain mtg)
  (:objects you opponent - player
            thassas_oracle - wincon
            force_of_will pact_of_negation - counter
			unmask - discard)
  (:init (has you thassas_oracle)
         (has opponent force_of_will)
         (has you unmask)
         
		 (intends you (won you))
		 (intends you (resolvedby unmask you))
		 (intends opponent(resolvedby force_of_will opponent)))
		 
  (:goal (and (won you)
			  (removed force_of_will)
			  (removed unmask))))