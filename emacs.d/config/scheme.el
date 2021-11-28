;; mit-scheme config
;; copied from https://groups.csail.mit.edu/mac/users/gjs/6.945/dont-panic/

(setq scheme-root "/Applications/MIT-scheme.app/Contents/Resources")
(setq scheme-program-name
      (concat
       scheme-root "/mit-scheme "
       "--library " scheme-root " "
       "--band " scheme-root "/all.com "
       "-heap 10000"))

(load "xscheme")

(add-to-list 'load-path
		(expand-file-name "scheme"
				  "~/.emacs.d"))

;; generic scheme completion
(require 'scheme-complete)
(autoload 'scheme-smart-complete "scheme-complete" nil t)
(autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
(setq lisp-indent-function 'scheme-smart-indent-function)

;; mit-scheme documentation

(require 'mit-scheme-doc)

;; special keys in scheme mode. use <tab> to indent scheme code to the
;; proper level, and use M-. to view mit-scheme-documentation for any
;; symbol.
(eval-after-load
  'scheme
  '(define-key scheme-mode-map "\t" 'scheme-complete-or-indent))

(eval-after-load
  'cmuscheme
  '(define-key inferior-scheme-mode-map "\t" 'scheme-complete-or-indent))

(eval-after-load
  'xscheme
  '(define-key scheme-interaction-mode-map "\t" 'scheme-complete-or-indent))

(eval-after-load
 'scheme
 '(define-key scheme-mode-map (kbd "M-.") 'mit-scheme-doc-lookup))

(eval-after-load
 'cmuscheme
 '(define-key inferior-scheme-mode-map (kbd "M-.")
    'mit-scheme-doc-lookup))

(eval-after-load
 'xscheme
 '(define-key scheme-interaction-mode-map (kbd "M-.")
    'mit-scheme-doc-lookup))

;; activate auto-fill-mode for scheme-mode
(add-hook 'scheme-mode-hook 'turn-on-auto-fill)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Patch for xscheme - Fixing evaluate-expression in debugger ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun xscheme-prompt-for-expression-exit ()
  (interactive)
  (let (
	;; In Emacs 21+, during a minibuffer read the minibuffer
	;; contains the prompt as buffer text and that text is
	;; read only.  So we can no longer assume that (point-min)
	;; is where the user-entered text starts and we must avoid
	;; modifying that prompt text.  The value we want instead
	;; of (point-min) is (minibuffer-prompt-end).
	(point-min (if (fboundp 'minibuffer-prompt-end)
		              (minibuffer-prompt-end)
		            (point-min))))
    (if (eq (xscheme-region-expression-p point-min (point-max)) 'one)
        (exit-minibuffer)
      (error "input must be a single, complete expression"))))
