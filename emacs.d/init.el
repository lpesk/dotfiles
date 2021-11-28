;; how long is this thing taking to start up?
(add-to-list 'after-init-hook
          (lambda ()
            (message (concat "emacs (" (number-to-string (emacs-pid)) ") started in " (emacs-init-time)))))

;; load the default package manager
(require 'package)

;; make some package repos known to the package manager
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(setq package-enable-at-startup nil)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; initialize packages, not needed in emacs 27+
(when (< emacs-major-version 27)
  (package-initialize))

;; skip the splash screen
(setq inhibit-splash-screen t)
(setq initial-scratch-message 'nil)

;; set text-mode as the default mode
(setq initial-major-mode 'text-mode)

;; remove scrollbars, menu bars, and toolbars
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; allow y/n responses to yes/no questions
(defalias 'yes-or-no-p 'y-or-n-p)

;; specify that sentences end with a single space
(setq sentence-end-double-space nil)

;; put autosaved files in a backups directory rather than in local directories
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; define a function to load all .el files in a specified directory and its children
(defun load-directory (directory)
  (dolist (element (directory-files-and-attributes directory nil nil nil))
    (let* ((path (car element))
	   (fullpath (concat directory "/" path))
	   (isdir (car (cdr element)))
	   (ignore-dir (or (string= path ".") (string= path ".."))))
      (cond
       ((and (eq isdir t) (not ignore-dir))
	(load-directory fullpath))
       ((and (eq isdir nil) (string= (substring path -3) ".el"))
	(load (file-name-sans-extension fullpath)))))))

;; load all config files
(load-directory "~/.emacs.d/config")

;; set light theme in gui mode and dark theme in terminal mode
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa")
(setq custom-safe-themes t)
(if (display-graphic-p)
    (load-theme 'solarized-light t)
  (load-theme 'zenburn t))

;; set font and line spacing
(set-frame-font "Inconsolata")
(setq-default line-spacing 2)

;; ido mode
(when (> emacs-major-version 21)
  (require 'flx-ido) 
  (ido-mode t)
  (ido-everywhere 1)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point nil
        ido-use-faces nil
        ido-max-prospects 10))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-ellipsis " »")
 '(org-highlight-latex-and-related (quote (native latex script entities)))
 '(org-startup-with-inline-images t)
 '(org-startup-with-latex-preview t)
 '(package-selected-packages
   (quote
    (dash-functional f ht spinner lv lsp-mode company-lean lean-mode request anki-editor package-filter org-roam cargo flycheck-rust flymake-rust racer rust-playground rust-mode scheme-here scheme-complete zenburn-theme yasnippet-snippets yaml-mode windresize visual-regexp textmate tango-2-theme solarized-theme smartparens powerline pos-tip polymode pandoc-mode muse markdown-mode magit latex-pretty-symbols latex-extra json-mode jedi idle-highlight-mode flycheck flx-ido expand-region exec-path-from-shell csv-mode company-statistics company-math color-theme-sanityinc-solarized browse-kill-ring))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-ellipsis ((t (:inherit inconsolata :foreground "#f09f0a" :height 1.0))))
 '(org-level-1 ((t (:inherit inconsolata :foreground "dark blue" :height 1.2))))
 '(org-level-2 ((t (:inherit inconsolata :foreground "#859900" :height 1.1))))
 '(org-level-3 ((t (:inherit inconsolata :foreground "#268bd2" :height 1.0))))
 '(org-level-4 ((t (:inherit inconsolata :foreground "#b58900" :height 1.0))))
 '(outline-3 ((t (:inherit inconsolata :height 1.0))))
 '(outline-4 ((t (:inherit inconsolata :height 1.0)))))
