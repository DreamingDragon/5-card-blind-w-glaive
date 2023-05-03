;;;
;;; A highly simplified problem for a MTG game
;;; Created by Vincent Liu
;;;
(define (problem win)
  (:domain mtg)
  (:objects you opponent - player
            thassas_oracle - wincon
            force_of_will - counter
			unmask - discard)
; First Half End
;; Init stuff
;
  (:init (has you thassas_oracle)
         (has you force_of_will)
		 (has opponent force_of_will)
		 (intends you (won you))
		 (intends opponent (not (has opponent force_of_will)))
		 (intends opponent (not (won you))))
;
; End Init stuff;
; Second Half Start
		 
  (:goal (and(won you)
		     (not (has opponent force_of_will)))))