;;; package --- Rawley Fowler's init.el
;;; Commentary:
;;; This is my Void Linux init.el
;;; Code:

;; Font
(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font-14"))

;; Boilerplate/personalizations
(defconst autosave-dir "~/.auto-save/")
(unless (file-exists-p autosave-dir)
  (make-directory autosave-dir t))
(setq auto-save-file-name-transforms
      `(("\\(?:[^/]*/\\)*\\(.*\\)" ,(concat autosave-dir "\\1") t)))
(setq package-enable-at-startup nil)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(setq shell-file-name "/bin/bash")
(setq shell-command-switch "-ic")
(setq indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(set-cursor-color "orange red")
(global-linum-mode)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode 1)
(recentf-mode 1)

;; My custom funcs
(defun rf/indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(defun rf/goto-dashboard ()
  "Go back to dashboard buffer"
  (interactive)
  (switch-to-buffer "*dashboard*")
  (dashboard-mode)
  (dashboard-refresh-buffer))

(defun rf/kill-inner-word ()
  (interactive)
  (forward-char 1)
  (backward-word)
  (kill-word 1))

;; Packages
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

(defconst packages '(ctrlf
                     doom-modeline
                     all-the-icons
				     better-defaults
				     projectile
				     json-mode
				     clojure-mode
                     dashboard
				     cider
				     gruvbox-theme
				     yaml-mode
				     dockerfile-mode
				     cmake-mode
				     docker
				     smex
				     go-mode
				     raku-mode
				     tuareg
				     lsp-mode
				     company
                     company-box
				     treemacs
				     lsp-treemacs
				     ivy
				     lsp-ivy
				     lsp-ui
				     magit))
(when (not package-archive-contents)
  (package-refresh-contents))
(dolist (package packages)
  (unless (package-installed-p package)
	(package-install package)))

;; Package configuration
(when (display-graphic-p)
  (require 'all-the-icons))

(setq raku-indent-level 4)

(require 'ctrlf)
(ctrlf-mode +1)

(require 'company-box)

(require 'ido)
(ido-mode 1)

(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-items '((recents . 7)
                        (bookmarks . 7)))
(setq dashboard-startup-banner 'logo)
(setq dashboard-banner-logo-title "emacs")
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-center-content t)

(require 'doom-modeline)
(doom-modeline-mode 1)
(setq doom-modeline-height 30)
(setq doom-modeline-hud nil)
(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-time-icon nil)
(setq doom-modeline-env-perl-executable "perl")

(add-to-list 'auto-mode-alist '("\\.raku\\?\\(test\\|mod\\)$" . raku-mode))

(require 'projectile)
(projectile-mode)
(setq projectile-completion-system 'ivy)

(require 'lsp-mode)
(setq lsp-keymap-prefix "C-c l")
(setq raku-indent-level 4)
(setq go-indent-level 4)

(require 'company)
(setq company-idle-delay 0.0)
(setq company-minimum-prefix-length 1)

(require 'smex)
(smex-initialize)

(require 'docker)

;; Hooks
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key (kbd "C-x E") 'eval-buffer)))
(add-hook 'raku-mode-hook #'lsp-deferred)
(add-hook 'perl-mode-hook #'lsp-deferred)
(add-hook 'c++-mode-hook #'lsp-deferred)
(add-hook 'c-mode-hook #'lsp-deferred)
(add-hook 'company-mode-hook 'company-box-mode)

;; Keys
(global-set-key (kbd "<tab>") #'company-indent-or-complete-common)
(global-set-key (kbd "C-c C-d") #'rf/goto-dashboard)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c d") 'docker)
(global-set-key (kbd "C-c p") 'projectile-command-map)
(global-set-key (kbd "C-c n") #'rf/indent-buffer)
(global-set-key (kbd "C-x w") #'rf/kill-inner-word)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruvbox-light-medium))
 '(custom-safe-themes
   '("fa49766f2acb82e0097e7512ae4a1d6f4af4d6f4655a48170d0a00bcb7183970" "19a2c0b92a6aa1580f1be2deb7b8a8e3a4857b6c6ccf522d00547878837267e7" "3e374bb5eb46eb59dbd92578cae54b16de138bc2e8a31a2451bf6fdb0f3fd81b" default))
 '(package-selected-packages
   '(company-box json-mode cmake-mode cider clojure-mode projectile better-defaults magit raku-mode go-mode smex docker dockerfile-mode yaml-mode gruvbox-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(provide 'init.el)
;;; init.el ends here
