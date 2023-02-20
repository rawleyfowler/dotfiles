;;; package --- Rawley Fowler's init.el
;;; Commentary:
;;; This is my Void Linux init.el
;;; Code:

(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font-14"))

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
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(set-cursor-color "orange red")
(global-linum-mode)

(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(global-set-key (kbd "C-c n") 'indent-buffer)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key (kbd "C-x E") 'eval-buffer)))

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

(defconst packages '(fzf
                     ctrlf
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

(when (display-graphic-p)
  (require 'all-the-icons))

(setq raku-indent-level 4)

(require 'ctrlf)
(ctrlf-mode +1)

(require 'company-box)
(add-hook 'company-mode-hook 'company-box-mode)

(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-items '((recents . 7)
                        (bookmarks . 7)))
(setq dashboard-startup-banner 'logo)
(setq dashboard-banner-logo-title "emacs")
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

(require 'doom-modeline)
(doom-modeline-mode 1)
(setq doom-modeline-height 30)
(setq doom-modeline-hud nil)
(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-time-icon nil)
(setq doom-modeline-env-perl-executable "perl")

(require 'fzf)
(global-set-key (kbd "C-x f") 'fzf)
(setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
      fzf/executable "fzf"
      fzf/git-grep-args "-i --line-number %s"
      ;; command used for `fzf-grep-*` functions
      ;; example usage for ripgrep:
      ;; fzf/grep-command "rg --no-heading -nH"
      fzf/grep-command "grep -nrH"
      ;; If nil, the fzf buffer will appear at the top of the window
      fzf/position-bottom t
      fzf/window-height 15)

(add-to-list 'auto-mode-alist '("\\.raku\\?\\(test\\|mod\\)$" . raku-mode))

(require 'projectile)
(projectile-mode)
(setq projectile-completion-system 'ivy)
(global-set-key (kbd "C-c p") 'projectile-command-map)

(require 'lsp-mode)
(setq lsp-keymap-prefix "C-c l")
(setq raku-indent-level 4)
(setq go-indent-level 4)
(add-hook 'raku-mode-hook #'lsp-deferred)
(add-hook 'perl-mode-hook #'lsp-deferred)
(add-hook 'c++-mode-hook #'lsp-deferred)
(add-hook 'c-mode-hook #'lsp-deferred)

(require 'company)
(setq company-idle-delay 0.0)
(setq company-minimum-prefix-length 1)
(global-set-key (kbd "<tab>") #'company-indent-or-complete-common)
(add-hook 'after-init-hook 'global-company-mode)

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
   '(company-box json-mode cmake-mode cider clojure-mode projectile better-defaults magit raku-mode go-mode smex docker dockerfile-mode yaml-mode gruvbox-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(provide 'init.el)
;;; init.el ends here
