;;;
;;; A highly simplified problem for a MTG game
;;; Created by Vincent Liu
;;;
(define (problem win-with-two-discard-two-counter)
  (:domain mtg)
  (:objects you opponent - player
            thassas_oracle - wincon
            force_of_will pact_of_negation - counter
			unmask duress - discard)
  (:init (has you thassas_oracle)
         (has opponent force_of_will)
         (has you unmask)
		 (has you duress)
		 (has opponent pact_of_negation)
         
		 (intends you (won you))
		 (intends you (resolvedby unmask you))
		 (intends opponent(resolvedby force_of_will opponent))
		 
		 (intends you (resolvedby duress you))
		 (intends opponent(resolvedby pact_of_negation opponent)))
		 
  (:goal (and (won you)
			  (removed force_of_will)
			  (removed unmask)
			  (removed duress)
			  (removed pact_of_negation))))