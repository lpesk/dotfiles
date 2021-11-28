(require 'org-roam)
(setq org-roam-directory "~/Documents/notes/")
(setq org-roam-dailies-directory "daily/")
(setq org-roam-completion-system 'ivy)
(setq org-roam-capture-templates
      '(
	;; default note template
	("d" "default" plain (function org-roam--capture-get-point)
	 "%?"
	 :file-name "%<%Y%m%d%H%M%S>-${slug}"
	 :head "#+title: ${title}\n#+roam_tags: "
	 :unnarrowed t)
	;; article review template
	("a" "article" plain (function org-roam--capture-get-point)
	 "%?"
	 :file-name "%<%Y%m%d%H%M%S>-${slug}"
	 :head "#+title: ${title}\n#+roam_tags: \"article review\"\n\n~author:~\n~date:~\n~venue:~\n~link:~\n\n"
	 :unnarrowed t)
	;; paper review template
	("p" "paper" plain (function org-roam--capture-get-point)
	 "%?"
	 :file-name "%<%Y%m%d%H%M%S>-${slug}"
	 :head "#+title: ${title}\n#+roam_tags: \"paper review\"\n\n~subtitle:~\n~authors:~\n~date:~\n~venue:~\n~link:~\n\n"
	 :unnarrowed t)
	;; book review template
	("b" "book" plain (function org-roam--capture-get-point)
	 "%?"
	 :file-name "%<%Y%m%d%H%M%S>-${slug}"
	 :head "#+title: ${title}\n#+roam_tags: \"book review\"\n\n~subtitle:~\n~author:~\n~year:~\n\n"
	 :unnarrowed t)
	;; monthly journal template
      	("m" "journal-monthly" plain (function org-roam--capture-get-point)
         "%?"
         :file-name "monthly/%<%Y-%m>"
         :head "#+title: %<%Y-%m>\n#+roam_tags:\n\n"
	 :unnarrowed t)))
(setq org-roam-dailies-capture-templates
      '(("j" "journal-default" entry
         #'org-roam-capture--get-point
         "\n\n* [%<%H:%M>]\n%?\n"
         :file-name "daily/%<%Y-%m-%d>"
         :head "#+title: %<%Y-%m-%d>\n#+roam_tags:\n\n~where:~\n~calendar:~\n~currently reading:~\n\n"
	 :empty-lines 1)))

(setq org-startup-with-inline-images t)

(define-key org-roam-mode-map (kbd "C-c n l") #'org-roam)
(define-key org-roam-mode-map (kbd "C-c n f") #'org-roam-find-file)
(define-key org-roam-mode-map (kbd "C-c n b") #'org-roam-switch-to-buffer)
(define-key org-roam-mode-map (kbd "C-c n g") #'org-roam-graph-show)
(define-key org-roam-mode-map (kbd "C-c n t") #'org-roam-dailies-find-today)
(define-key org-roam-mode-map (kbd "C-c n y") #'org-roam-dailies-find-yesterday)
(define-key org-roam-mode-map (kbd "C-c n j") #'org-roam-dailies-capture-today)

(define-key org-mode-map (kbd "C-c n i") #'org-roam-insert)
(define-key org-mode-map (kbd "C-x e") #'outline-show-all)
(define-key org-mode-map (kbd "C-x c") #'org-shifttab)

(org-roam-mode +1)
