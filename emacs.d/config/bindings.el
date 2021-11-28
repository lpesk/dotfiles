;; fullscreen with C-c f
(defun fullscreen (&optional f)
  (interactive)
  (set-frame-parameter f 'fullscreen
                       (if (frame-parameter f 'fullscreen) nil 'fullboth)))
(global-set-key (kbd "C-c f") 'fullscreen)
(add-hook 'after-make-frame-functions 'fullscreen)

;; increase or decrease font size
(define-key global-map (kbd "C-+") 'text-scale-increases)
(define-key global-map (kbd "C--") 'text-scale-decreases)

;; search operations:
;; switch standard search keybindings to regexp search
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
;; shortcuts for standard search and replace
(global-set-key (kbd "C-c r") 'replace-string)
(global-set-key (kbd "C-c q r") 'query-replace)

;; cut and paste operations
(global-set-key (kbd "C-c c") 'kill-ring-save)
(global-set-key (kbd "C-c v") 'yank)
;; shortcut for browsing the kill ring when pasting
(global-set-key (kbd "C-c b") 'browse-kill-ring)

;; use visual-regexp to construct searches
;;(require 'visual-regexp)

;; resizing 'windows' (i.e., inside the frame)
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; application-specific keybindings
(global-set-key (kbd "C-x g") 'magit-status)

(provide 'bindings)
(message "bindings loaded")
