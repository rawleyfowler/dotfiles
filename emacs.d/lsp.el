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

(use-package company
  :hook
  (global-company-mode))

(use-package helm-lsp)

;;; lsp.el ends here
