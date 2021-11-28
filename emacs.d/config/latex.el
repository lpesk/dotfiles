(require 'latex-pretty-symbols)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'pandoc-mode-hook 'turn-on-reftex)  ; with Pandoc mode
(autoload 'reftex-mode     "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex  "reftex" "RefTeX Minor Mode" t)
(autoload 'reftex-citation "reftex-cite" "Make citation" t)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

  ;; Synctex with Skim
  (add-hook 'TeX-mode-hook
  (lambda ()
  (add-to-list 'TeX-output-view-style
  '("^pdf$" "."
   "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b")))
   )
  
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
   
  ;; Make emacs aware of multi-file projects
  ;; (setq-default TeX-master nil)
  
  ;; Auto-raise Emacs on activation (from Skim, usually)
  (defun raise-emacs-on-aqua()
  (shell-command "osascript -e 'tell application \"Emacs\" to activate' &"))
  (add-hook 'server-switch-hook 'raise-emacs-on-aqua)

;; Make RefTeX faster
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)
(setq reftex-plug-into-AUCTeX t)

;; Make RefTeX work with Org-Mode
;; use 'C-c (' instead of 'C-c [' because the latter is already
;; defined in orgmode to the add-to-agenda command.
(defun org-mode-reftex-setup ()
  (load-library "reftex") 
  (and (buffer-file-name)
  (file-exists-p (buffer-file-name))
  (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c (") 'reftex-citation))

(add-hook 'org-mode-hook 'org-mode-reftex-setup)

;; RefTeX formats for biblatex (not natbib), and for pandoc
(setq reftex-cite-format
      '(
        (?\C-m . "\\cite[]{%l}")
        (?t . "\\textcite{%l}")
        (?a . "\\autocite[]{%l}")
        (?p . "\\parencite{%l}")
        (?f . "\\footcite[][]{%l}")
        (?F . "\\fullcite[]{%l}")
        (?P . "[@%l]")
        (?T . "@%l [p. ]")
        (?x . "[]{%l}")
        (?X . "{%l}")
        ))

(setq font-latex-match-reference-keywords
      '(("cite" "[{")
        ("cites" "[{}]")
        ("footcite" "[{")
        ("footcites" "[{")
        ("parencite" "[{")
        ("textcite" "[{")
        ("fullcite" "[{") 
        ("citetitle" "[{") 
        ("citetitles" "[{") 
        ("headlessfullcite" "[{")))

(setq reftex-cite-prompt-optional-args nil)
(setq reftex-cite-cleanup-optional-args t)

(autoload 'ebib "ebib" "Ebib, a BibTeX database manager." t)
(setq ebib-preload-bib-files 
      '("/Users/kjhealy/Documents/bibs/socbib.bib"))
(add-hook 'LaTeX-mode-hook #'(lambda ()
			       (local-set-key "\C-cb" 'ebib-insert-bibtex-key)))

(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.

(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)

;; use bibtex key template by default in bib files
(setq bibtex-dialect "BibTeX")

;; compile with latexmk by default
  (eval-after-load "tex"
    '(add-to-list 'TeX-command-list '("latexmk" "latexmk -synctex=1 -shell-escape -pdf %s" TeX-run-TeX nil t :help "Process file with latexmk"))
    )
  (eval-after-load "tex"
    '(add-to-list 'TeX-command-list '("xelatexmk" "latexmk -synctex=1 -shell-escape -xelatex %s" TeX-run-TeX nil t :help "Process file with xelatexmk"))
    )

(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

(setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))

;; default bibliography
(setq reftex-default-bibliography
      (quote
       ("user.bib" "local.bib")))

(require 'ob-latex)
;; (org-babel-add-interpreter "latex")
;; (add-to-list 'org-babel-tangle-langs '("latex" "tex"))

(add-to-list 'org-babel-noweb-error-langs "latex")

(message "latex config loaded")
