(require 'rust-mode)
(require 'lsp-mode)

(setq lsp-rust-server 'rust-analyzer)
(setq lsp-rust-analyzer-cargo-watch-command "clippy")
(setq lsp-eldoc-render-all t)
(setq lsp-idle-delay 0.6)
(setq lsp-rust-analyzer-server-display-inline-hints t)

(setq rust-format-on-save t)

