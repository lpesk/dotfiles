(defvar my-packages (list
                              'auctex
                              'company
                              'css-mode
                              'csv-mode
                              'exec-path-from-shell
                              'expand-region
                              'flycheck
                              'flx-ido
                              ;; 'hl-line+
                              'idle-highlight-mode
                              'jedi
                              'latex-pretty-symbols
                              'magit
                              'markdown-mode
			      'org-roam
                              'pandoc-mode
                              'polymode
                              'pos-tip
                              'powerline
                              'python-mode
                              ;; 'ipython
			      'rust-mode
                              'smartparens 
                              'solarized-theme
                              'tango-2-theme
                              'textmate
                              'visual-regexp
                              'yaml-mode
                              'yasnippet
                              'zenburn-theme
                              )
  "libraries that should be installed by default")

(defun packages-elpa-install ()
  "install all packages in my-packages that aren't installed yet"
  (interactive)
  (dolist (package my-packages)
    (unless (or (member package package-activated-list)
                (functionp package))
      (message "installing %s" (symbol-name package))
      (package-install package))))

;;(defun esk-online? ()
;;  "see if we're online"
;;  (if (and (functionp 'network-interface-list)
;;           (network-interface-list))
;;      (some (lambda (iface) (unless (equal "lo" (car iface))
;;                         (member 'up (first (last (network-interface-info
;;                                                   (car iface)))))))
;;            (network-interface-list))
;;    t))

;; (when (esk-online?)
;;(unless package-archive-contents (package-refresh-contents))
(packages-elpa-install)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(message "elpa packages loaded")
