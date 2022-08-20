(tool-bar-mode 0)
(scroll-bar-mode -1)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-frame-font "Ubuntu Mono-16" nil t)
(transient-mark-mode)
(show-paren-mode 1)
(setq inhibit-startup-screen t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(defalias 'yes-or-no-p 'y-or-n-p)

(require 'package)
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (setq use-package-always-ensure t
	use-package-expand-minimally t))

(require 'ido)
(ido-mode 1)

;; Packages
(require 'use-package)
(use-package gruber-darker-theme)
(use-package smex
  :config
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex))
(use-package tuareg)
(use-package utop
  :ensure t)
(use-package haml-mode)

(setq utop-commands "opam config exec -- utop -emacs")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("3d2e532b010eeb2f5e09c79f0b3a277bfc268ca91a59cdda7ffd056b868a03bc" default))
 '(package-selected-packages
   '(utop haml-mode tuareg caml-mode ocaml-mode smex gruber-darker-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
