;;; GNU/EMACS --- Rawley Fowler's init.el.
;; I was a long time Vim user. But emacs stole my heart.

;;; Code:
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode)) ;; Line numbers
(defalias 'yes-or-no-p 'y-or-n-p)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

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

(defun save-and-kill-buffer () ;; Saves and kills a buffer, vim style
  (interactive)
  (save-buffer)
  (kill-buffer))
(defun kill-buffer ()
  (interactive)
  (kill-buffer))

(evil-ex-define-cmd "wq" 'save-and-kill-buffer)
(evil-ex-define-cmd "q" 'kill-buffer)

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

(use-package hydra)

;; Treemacs
(use-package lsp-treemacs)
(use-package treemacs
  :ensure t
  :defer t
  :config
  (progn
    (setq treemacs-display-in-side-window t
          treemacs-follow-after-init t
          treemacs-expand-after-init t
          treemacs-indentation 2
          treemacs-hide-dot-git-directory t
          treemacs-indentation-string " "
          treemacs-max-git-entries 5000
          treemacs-width 40
          treemacs-width-increment 1
          treemacs-width-is-initially-locked t))
  :bind
  (:map global-map
        ("C-x w s" . treemacs-select-window)
        ("C-x w 1" . treemacs-delete-other-windows)
        ("C-x w w"   . treemacs)))

(require 'treemacs)
(treemacs-follow-mode t)
(treemacs-filewatch-mode t)
(treemacs-fringe-indicator-mode 'always)
(treemacs-git-mode 'simple)
(define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action)
(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)
(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

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

;; Which key
(use-package which-key)

;; LSP/Complete packages
(use-package yasnippet
  :config
  (yas-global-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package company)
(add-hook 'after-init-hook 'global-company-mode)

(use-package lsp-ui)
(require 'lsp-ui)
(lsp-ui-sideline-enable t)

(use-package lsp-java)
(add-hook 'java-mode-hook #'lsp)

(use-package dap-mode
  :after lsp-mode
  :config
  (dap-auto-configure-mode))
(use-package dap-java
  :ensure nil)

(use-package helm-lsp)
(use-package helm
  :config
  (helm-mode))

;; Language modes
; Java stuff
(use-package meghanada)
(add-hook 'java-mode-hook
          (lambda ()
            (meghanada-mode t)
            (setq c-basic-offset 2)
            (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
(setq meghanada-java-path "java")
(setq meghanada-maven-path "mvn")

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

(use-package dart-mode)
(use-package json-mode)
(use-package vimrc-mode)
(use-package yaml-mode)

(use-package flycheck
  :config
  (global-flycheck-mode))
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;;;; Bindings

;; Splits
(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;; Split and open terminal
(defun split-and-open-terminal ()
  (interactive)
  (split-window-below)
  (other-window 1)
  (shell))
(global-set-key (kbd "C-x t") 'split-and-open-terminal)

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
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(yaml-mode vimrc-mode json-mode clojure-mode typescript-mode use-package restart-emacs lsp-mode evil-collection)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
