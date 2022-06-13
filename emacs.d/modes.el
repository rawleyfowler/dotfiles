;;; modes.el --- Various modes
;;; Commentary:
;;; This file contains various Emacs modes that I use.
;;; Code:
(require 'lsp-mode)
(require 'flycheck)
;; Language modes + configurations
(require 'eglot)
(use-package typescript-mode
  :mode
  ("\\.tsx?\\'" . typescript-mode)
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
(use-package d-mode)

;; eglot mode hooks
(add-to-list 'eglot-server-programs
	     `(c-mode . ("clangd" "--include" "/usr/include/")))
(add-to-list 'eglot-server-programs
	     `(c++-mode . ("clangd" "--include" "/usr/include/")))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'd-mode-hook 'eglot-ensure)
(add-hook 'typescript-mode 'eglot-ensure)
(add-hook 'go-mode 'eglot-ensure)
(add-hook 'clojure-mode 'eglot-ensure)


;; Built-in mode configs
;; Ruby
(add-to-list 'auto-mode-alist
	     '("\\.\\(?:cap\\|gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
	     '("\\(?:Brewfile\\|Capfile\\|Gemfile\\|[rR]akefile\\)\\'" . ruby-mode))
;; C/C++
(add-hook 'c++-mode-hook
	  (lambda () (setq flycheck-clang-include-path
			   (list (expand-file-name "/usr/include/")))))
(add-hook 'c-mode-hook
	  (lambda () (setq flycheck-clang-include-path
			   (list (expand-file-name "/usr/include/")))))
;;; modes.el ends here
