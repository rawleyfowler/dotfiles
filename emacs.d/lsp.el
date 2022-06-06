;;; lsp.el --- LSP and autocomplete
;;; Commentary:
;;; LSP and autocomplete configurations
;;; Code:
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c 1")
  :hook
  (lsp-mode . lsp-enable-whick-key-integration)
  :commands (lsp lsp-deferred))

(use-package yasnippet
  :config
  (yas-global-mode))
(use-package yasnippet-snippets)

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode))

(use-package company
  :hook
  (global-company-mode))

(use-package helm-lsp)

;; Java
(use-package lsp-java
  :config
  (add-hook 'java-mode-hook 'lsp))

(use-package dap-mode
  :after
  lsp-mode
  :config
  (dap-auto-configure-mode))
(use-package dap-java
  :ensure nil)

;; Auto complete
(use-package auto-complete
  :init
  (ac-config-default))
;;; lsp.el ends here
