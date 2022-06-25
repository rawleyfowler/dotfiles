;;; package --- Rawley Fowler's OpenBSD init.el
;;; Commentary:
;;; This is my Emacs init.el for OpenBSD. OpenBSD has always been
;;; one of my favorite opeating systems, but I have never had hardware
;;; that can take advantage of it. Thankfully, I found a compatible
;;; WiFi card for my Librebooted x200, now I can use OpenBSD \o/
;;; Code:
(setq visible-bell nil)

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
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (setq use-package-always-ensure t
	use-package-expand-minimally t))

(require 'use-package)
(use-package modus-themes
  :init
  (setq modus-themes-bold-constructs t
	modus-themes-italic-constructs nil)
  (setq modus-themes-mode-line '(borderless (padding . 1)))
  (modus-themes-load-themes)
  :config
  (modus-themes-load-vivendi))

(use-package d-mode)
(use-package go-mode)

(defun save-and-kill-this-buffer ()
  (interactive)
  (save-buffer)
  (kill-current-buffer))	   

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(modus-themes use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
