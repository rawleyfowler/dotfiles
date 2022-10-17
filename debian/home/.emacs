;;; package --- Rawley's Linux .emacs
;;; Commentary:
;;; This is my Emacs init.el for Linx.  This is used on a Artix Linux machine
;;; and a Debian Linux machine.
;;; Code:
(add-to-list 'default-frame-alist '(font . "monospace-14"))

(setq visible-bell nil)
(setq ring-bell-function 'ignore)
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
(use-package dumb-jump)
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

;; Language Specific

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
 '(custom-enabled-themes '(modus-operandi))
 '(custom-safe-themes
   '("92d350334df87fe61a682518ff214c773625c6d5ace8060d128adc550bc60c9b" "ecc077ef834d36aa9839ec7997aad035f4586df7271dd492ec75a3b71f0559b3" default))
 '(package-selected-packages
   '(perl-docnow perlnow dune dune-mode borland-blue-theme reason-mode rescript-mode haml-mode utop tuareg smex modus-themes use-package))
 '(whitespace-style '(space-mark tab-mark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide '.emacs)
;;; .emacs ends here
