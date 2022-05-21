;; Rawley Fowler's init.el.
;; I was a long time Vim user. But emacs stole my heart.
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode)) ;; Line numbers
(defalias 'yes-or-no-p 'y-or-n-p)

;; Backups
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Disabling bars
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; UTF-8 and spacing
(set-language-environment "UTF-8")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(transient-mark-mode)
(show-paren-mode 1)

(setq font-lock-maximum-decoration t)
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq c-basic-offset 4)

;;;; Package management
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(require 'use-package)

;;;; Packages.
;; EVIL!!!
(use-package evil
  :ensure t ;; Install evil if not installed
  :init ;; Tweak the config before loading it
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; Project mangement
(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))

(use-package neotree
  :config
  (global-set-key (kbd "C-c C-w") 'neotree-toggle))

;; Icons
(use-package all-the-icons
  :if (display-graphic-p))

;; Ivy
(use-package ivy)
(use-package counsel)
(use-package swiper)

(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

;; Parens
(use-package paren
  :ensure nil
  :init
  (setq show-paren-delay 0)
  :config
  (show-paren-mode +1))

(use-package smartparens
  :config
  (smartparens-global-mode 1))
(require 'smartparens)
(use-package evil-smartparens
  :hook ('smartparens-enabled-hook #'evil-smartparens-mode))

(use-package which-key)

;; LSP packages
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
  (lsp-completion-enable t))

(use-package lsp-ui)

(use-package auto-complete
  :config
  (ac-config-default))
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

;; Language modes
(use-package typescript-mode
  :mode ("\\.tsx?\\'" . typescript-mode)
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package clojure-mode
  :mode ("\\.cljs?\\'" . clojure-mode)
  :hook (clojure-mode . lsp-deferred)
  :config
  (setq clojure-indent-level 2))

(use-package go-mode
  :mode ("\\.go\\'" . go-mode)
  :hook (go-mode . lsp-deferred))

(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode)
  :hook (markdown-mode . auto-fill-mode))

(use-package json-mode)
(use-package vimrc-mode)
(use-package yaml-mode)

;;;; Bindings
;; Ivy
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f2> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)

(global-set-key (kbd "C-c c") 'counsel-compile)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c L") 'counsel-git-log)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-c m") 'counsel-linux-app)
(global-set-key (kbd "C-c n") 'counsel-fzf)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-c J") 'counsel-file-jump)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(global-set-key (kbd "C-c w") 'counsel-wmctrl)

(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-c b") 'counsel-bookmark)
(global-set-key (kbd "C-c d") 'counsel-descbinds)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c o") 'counsel-outline)
(global-set-key (kbd "C-c t") 'counsel-load-theme)
(global-set-key (kbd "C-c F") 'counsel-org-file)

;;;; Themes
;; I use the default emacs color scheme, with Consolas font.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yaml-mode vimrc-mode json-mode clojure-mode typescript-mode use-package restart-emacs lsp-mode evil-collection)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
