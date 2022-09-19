;;; package --- Rawley OpenBSD init.el
;;; Commentary:
;;; This is my Emacs init.el for OpenBSD. OpenBSD has always been
;;; one of my favorite opeating systems, but I have never had hardware
;;; that can take advantage of it. Thankfully, I found a compatible
;;; WiFi card for my Librebooted x200, now I can use OpenBSD \o/
;;; Code:
(add-to-list 'default-frame-alist '(font . "Spleen-10"))

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
(load-theme 'modus-vivendi t)

(require 'ido)
(ido-mode 1)

(setq indent-tabs-mode nil)
(setq c-basic-offset 4)
(setq js-indent-level 2)

;; Packages
(require 'use-package)
(use-package smex
  :config
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex))
(use-package tuareg)
(use-package utop
  :ensure t)
(use-package haml-mode)
(use-package rescript-mode)
(use-package reason-mode)

(setq utop-commands "opam config exec -- utop -emacs")
;; end .emacs
