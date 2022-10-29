;;; package --- Rawley's Linux .emacs
;;; Commentary:
;;; This is my Emacs init.el for Linx.  This is used on a Artix Linux machine
;;; and a Debian Linux machine.
;;; Code:
(add-to-list 'default-frame-alist '(font . "monospace-14"))

(setq package-enable-at-startup nil)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(setq shell-file-name "bash")
(setq shell-command-switch "-ic")
(setq-default tab-width 4)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode 1)
(recentf-mode 1)

(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package)
  (package-refresh-contents))

(eval-and-compile
  (setq use-package-always-ensure t
	use-package-expand-minimally t))

(require 'use-package)
(use-package modus-themes)
(load-theme 'modus-operandi t)

(require 'ido)
(ido-mode 1)

(setq indent-tabs-mode nil)
(setq c-basic-offset 4)
(setq js-indent-level 2)

;; Packages
(require 'use-package)
(use-package yaml-mode)
(use-package dockerfile-mode)
(use-package docker
  :ensure t
  :bind ("C-c d" . docker))
(use-package dumb-jump)
(use-package yasnippet
  :config
  (yas-global-mode 1))
(use-package yasnippet-snippets)
  
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(use-package haml-mode)
(use-package smex
  :config
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex))

;; Editing
(require 'flycheck)
(setq flycheck-check-syntax-automatically '(mode-enabled save))
(setq flycheck-display-errors-delay 0.1)

(require 'dumb-jump)
(setq dumb-jump-force-searcher 'ag)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
  :interpreter ("scala" . scala-mode))

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false")))

;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  ;; Optional - enable lsp-mode automatically in scala files
  ;; You could also swap out lsp for lsp-deffered in order to defer loading
  :hook  (scala-mode . lsp)
         (lsp-mode . lsp-lens-mode)
  :config
  ;; Uncomment following section if you would like to tune lsp-mode performance according to
  ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
  ;; (setq gc-cons-threshold 100000000) ;; 100mb
  ;; (setq read-process-output-max (* 1024 1024)) ;; 1mb
  ;; (setq lsp-idle-delay 0.500)
  ;; (setq lsp-log-io nil)
  ;; (setq lsp-completion-provider :capf)
  (setq lsp-prefer-flymake nil))

;; Add metals backend for lsp-mode
(use-package lsp-metals)

;; Enable nice rendering of documentation on hover
;;   Warning: on some systems this package can reduce your emacs responsiveness significally.
;;   (See: https://emacs-lsp.github.io/lsp-mode/page/performance/)
;;   In that case you have to not only disable this but also remove from the packages since
;;   lsp-mode can activate it automatically.
(use-package lsp-ui)

;; Use company-capf as a completion provider.
;;
;; To Company-lsp users:
;;   Company-lsp is no longer maintained and has been removed from MELPA.
;;   Please migrate to company-capf.
(use-package company
  :hook (scala-mode . company-mode)
  :config
  (setq lsp-completion-provider :capf))

;; Posframe is a pop-up tool that must be manually installed for dap-mode
(use-package posframe)

;; Use the Debug Adapter Protocol for running tests and debugging
(use-package dap-mode
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode))

;;;; OCaml/Reason
(use-package tuareg)
(use-package utop
  :ensure t)
(use-package rescript-mode)
(use-package reason-mode)
(use-package dune)
(setq utop-commands "opam config exec -- utop -emacs")

;;;; Perl
(fset 'perl-mode 'cperl-mode)
(add-hook 'cperl-mode-hook 'flycheck-mode)

;; end .emacs
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(custom-safe-themes
   '("92d350334df87fe61a682518ff214c773625c6d5ace8060d128adc550bc60c9b" "ecc077ef834d36aa9839ec7997aad035f4586df7271dd492ec75a3b71f0559b3" default))
 '(package-selected-packages
   '(company lsp-ui lsp-metals lsp-mode sbt-mode yaml-mode docker yasnippet-snippets perl-docnow perlnow dune dune-mode borland-blue-theme reason-mode rescript-mode haml-mode utop tuareg smex modus-themes use-package))
 '(whitespace-style '(space-mark tab-mark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide '.emacs)
;;; .emacs ends here
