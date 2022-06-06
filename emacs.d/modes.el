;;; modes.el --- Various modes
;;; Commentary:
;;; This file contains various Emacs modes that I use.
;;; Code:
(require 'lsp-mode)
;; Language modes + configurations
(use-package typescript-mode
  :mode
  ("\\.tsx?\\'" . typescript-mode)
  :hook
  (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package clojure-mode
  :mode
  ("\\.cljs?\\'" . clojure-mode)
  :hook
  (clojure-mode . lsp-deferred))

(use-package go-mode
  :mode
  ("\\.go\\'" . go-mode)
  :hook
  (go-mode . lsp-deferred))

(use-package markdown-mode
  :mode
  ("\\.md\\'" . markdown-mode)
  :hook
  (markdown-mode . auto-fill-mode))

;; Java/Meghanada
(use-package meghanada)
(add-hook 'java-mode-hook
	  (lambda ()
	    (meghanada-mode t)
	    (setq c-basic-offset 2)
	    (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
(setq meghanada-java-path "java")
(setq meghanada-maven-path "mvn")

;; No config modes
(use-package json-mode)
(use-package yaml-mode)

;; Built-in mode configs
; Ruby
(add-to-list 'auto-mode-alist
	     '("\\.\\(?:cap\\|gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
	     '("\\(?:Brewfile\\|Capfile\\|Gemfile\\|[rR]akefile\\)\\'" . ruby-mode))
;;; modes.el ends here
