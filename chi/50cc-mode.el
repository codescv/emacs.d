(require 'cc-mode)

(add-hook 'c-mode-hook
	  '(lambda ()
	     (c-set-style "stroustrup")))

(add-hook 'c++-mode-hook
       '(lambda ()
       (c-set-style "stroustrup")))

(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
;(define-key c-mode-base-map (kbd "M-/") 'senator-complete-symbol)
;(define-key c-mode-base-map (kbd "C--") 'senator-fold-tag)
;(define-key c-mode-base-map (kbd "C-=") 'senator-unfold-tag)
;(define-key c-mode-base-map (kbd "C-c p") 'semantic-analyze-proto-impl-toggle)
;(define-key c-mode-base-map (kbd "C-c h") 'semantic-decoration-include-visit)
;(define-key c-mode-base-map (kbd "C-c =") 'eassist-switch-h-cpp)
;(define-key c-mode-base-map (kbd "M-/") 'semantic-complete-analyze-inline)

;; (defun my-c-mode-cedet-hook ()
;;  (local-set-key "." 'semantic-complete-self-insert)
;;  (local-set-key ">" 'semantic-complete-self-insert))
;(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

(setq-default gdb-many-windows t)

;(define-key c++-mode-map (kbd "RET") 'newline-and-indent)
