;;; lsp.el --- LSP and autocomplete
;;; Commentary:
;;; LSP and autocomplete configurations
;;; Code:
(use-package eglot)

(use-package yasnippet
  :config
  (yas-global-mode))
(use-package yasnippet-snippets)

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode))

(when (eq system-type 'darwin)
  (use-package exec-path-from-shell ; Needed for MacOS with flycheck
    :init
    (exec-path-from-shell-initialize)))

(use-package company
  :init
  (global-company-mode))

(use-package helm-lsp)

;;; lsp.el ends here
