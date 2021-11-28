;; workaround for an anki-connect/request package incompatibility
;; https://github.com/louietan/anki-editor/issues/76#issuecomment-691430533
(defun anki-editor--anki-connect-invoke! (orig-fun &rest args)
    (let ((request--curl-callback
           (lambda (proc event) (request--curl-callback "localhost" proc event))))
      (apply orig-fun args)))

(advice-add 'anki-editor--anki-connect-invoke :around #'anki-editor--anki-connect-invoke!)

(require 'request)
(require 'anki-editor)
;; require the subr-x package for some string manipulation functions
(eval-when-compile (require 'subr-x))

(define-key anki-editor-mode-map (kbd "C-c a s") #'anki-editor-note-section)
(define-key anki-editor-mode-map (kbd "C-c a n") #'anki-editor-insert-note)
(define-key anki-editor-mode-map (kbd "C-c a p") #'anki-editor-push-notes)

;; create a new deck if the requested deck doesn't exist yet
(setq anki-editor-create-decks t)
(anki-editor-mode +1)

