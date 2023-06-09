(define (space win)
  (:literals (has opponent force_of_will)
             (not (has opponent force_of_will))
             (not (has opponent thassas_oracle))
             (has you force_of_will)
             (not (has you force_of_will))
             (has you thassas_oracle)
             (not (has you thassas_oracle))
             (intends opponent (not (has opponent force_of_will)))
             (intends opponent (not (won you)))
             (intends you (won you))
             (must-resolve-remove-before-win force_of_will)
             (not (must-resolve-remove-before-win force_of_will))
             (not (must-resolve-remove-before-win thassas_oracle))
             (not (must-resolve-remove-before-win unmask))
             (playedby force_of_will opponent)
             (not (playedby force_of_will opponent))
             (playedby force_of_will you)
             (not (playedby force_of_will you))
             (playedby thassas_oracle you)
             (not (playedby thassas_oracle you))
             (removed force_of_will)
             (not (removed force_of_will))
             (removed thassas_oracle)
             (not (removed thassas_oracle))
             (resolvedby force_of_will opponent)
             (not (resolvedby force_of_will opponent))
             (resolvedby force_of_will you)
             (not (resolvedby force_of_will you))
             (not (resolvedby thassas_oracle opponent))
             (resolvedby thassas_oracle you)
             (not (resolvedby thassas_oracle you))
             (targets force_of_will force_of_will)
             (targets force_of_will thassas_oracle)
             (won you))
  (:steps (play_wincon you thassas_oracle)
          (play_counter you you force_of_will thassas_oracle)
          (play_counter you you force_of_will force_of_will)
          (play_counter you opponent force_of_will force_of_will)
          (play_counter opponent you force_of_will thassas_oracle)
          (play_counter opponent you force_of_will force_of_will)
          (play_counter opponent opponent force_of_will force_of_will)
          (resolve_wincon you thassas_oracle)
          (resolve_interaction you you force_of_will thassas_oracle)
          (resolve_interaction you you force_of_will force_of_will)
          (resolve_interaction you opponent force_of_will thassas_oracle)
          (resolve_interaction you opponent force_of_will force_of_will)
          (resolve_interaction opponent you force_of_will thassas_oracle)
          (resolve_interaction opponent you force_of_will force_of_will)
          (resolve_interaction opponent opponent force_of_will thassas_oracle)
          (resolve_interaction opponent opponent force_of_will force_of_will))
  (:axioms (:axiom
             :context (removed thassas_oracle)
             :implies (not (must-resolve-remove-before-win thassas_oracle)))
           (:axiom
             :context (removed force_of_will)
             :implies (not (must-resolve-remove-before-win force_of_will)))))