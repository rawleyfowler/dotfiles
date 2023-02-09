;;; package --- Rawley Fowler's init.el
;;; Commentary:
;;; This is my Void Linux init.el
;;; Code:

(add-to-list 'default-frame-alist '(font . "Iosevka NerdFont-14"))

(defvar autosave-dir "~/.auto-save/")
(unless (file-exists-p autosave-dir)
  (make-directory autosave-dir t))
(setq auto-save-file-name-transforms
      `(("\\(?:[^/]*/\\)*\\(.*\\)" ,(concat autosave-dir "\\1") t)))

(setq package-enable-at-startup nil)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(setq shell-file-name "bash")
(setq shell-command-switch "-ic")
(setq-default tab-width 4)

(require 'ido)
(ido-mode 1)

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

(defvar packages '(better-defaults
				   projectile
				   clojure-mode
				   cider
				   gruvbox-theme
				   yaml-mode
				   dockerfile-mode
				   docker
				   smex
				   go-mode
				   raku-mode
				   tuareg
				   magit))
(when (not package-archive-contents)
  (package-refresh-contents))
(dolist (package packages)
  (unless (package-installed-p package)
	(package-install package)))

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

(require 'docker)
(global-set-key (kbd "C-c d") 'docker)

(setq indent-tabs-mode nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruvbox-light-medium))
 '(custom-safe-themes
   '("fa49766f2acb82e0097e7512ae4a1d6f4af4d6f4655a48170d0a00bcb7183970" "19a2c0b92a6aa1580f1be2deb7b8a8e3a4857b6c6ccf522d00547878837267e7" "3e374bb5eb46eb59dbd92578cae54b16de138bc2e8a31a2451bf6fdb0f3fd81b" default))
 '(package-selected-packages
   '(cider clojure-mode projectile better-defaults magit raku-mode go-mode smex docker dockerfile-mode yaml-mode gruvbox-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(provide 'init.el)
;;; init.el ends here
