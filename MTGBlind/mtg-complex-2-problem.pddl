;;;
;;; A highly simplified problem for a MTG game
;;; Created by Vincent Liu
;;;
(define (problem win-with-two-discard-two-counter)
  (:domain mtg)
  (:objects you opponent - player
            thassas_oracle - wincon
            force_of_will pact_of_negation - counter
			unmask duress - discard
	)
  (:init (has you thassas_oracle)
         (has opponent force_of_will)
         (has you pact_of_negation)
		 (has opponent unmask)
         
		 (intends you (won you))
		 (intends you (resolvedby thassas_oracle))
		 (intends opponent (not (won you)))
		 (intends opponent (removed thassas_oracle))
		 
		 (playedby unmask opponent)
		 (targets unmask thassas_oracle)
		 (playedby pact_of_negation you)
		 (targets pact_of_negation unmask)
		 (must-resolve-remove-before-win unmask)
   )
		 
  (:goal 
		(and (removed thassas_oracle)
			 (not (won you))
			 (removed pact_of_negation)
		)
	)
)