;;; package --- Rawley's FreeBSD .emacs
;;; Commentary:
;;; This is my .emacs for FreeBSD.
;;; Available with my other dotfiles at: https://github.com/rawleyfowler/dotfiles
;;; Code:
(add-to-list 'default-frame-alist '(font . "terminus-12"))

(unless (file-exists-p "~/.auto-save")
  (make-directory "~/.auto-save"))
(defvar autosave-dir (concat "~/.auto-save" "/")) ; Auto save path
(make-directory autosave-dir t)
(setq auto-save-file-name-transforms
      `(("\\(?:[^/]*/\\)*\\(.*\\)" ,(concat autosave-dir "\\1") t)))

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
(use-package org)
(use-package modus-themes)
(load-theme 'modus-operandi t)

(require 'ido)
(ido-mode 1)

(setq indent-tabs-mode nil)

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
(require 'dumb-jump)
(setq dumb-jump-force-searcher 'ag)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
  :interpreter ("scala" . scala-mode))

;;;; OCaml/Reason
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
(use-package ocamlformat)
(require 'ocamlformat)
(use-package tuareg)
(add-hook 'tuareg-mode-hook (lambda ()
  (define-key tuareg-mode-map (kbd "C-M-<tab>") #'ocamlformat)
  (add-hook 'before-save-hook #'ocamlformat-before-save)))
(use-package utop
  :ensure t)
(use-package rescript-mode)
(use-package reason-mode)
(use-package dune)
(setq utop-commands "opam config exec -- utop -emacs")

;;;; Perl
(fset 'perl-mode 'cperl-mode)
(add-hook 'cperl-mode-hook 'flycheck-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(dune reason-mode rescript-mode utop tuareg ocamlformat sbt-mode scala-mode smex haml-mode flycheck yasnippet-snippets yasnippet dumb-jump docker dockerfile-mode yaml-mode modus-themes use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide '.emacs)
;;; .emacs ends here
