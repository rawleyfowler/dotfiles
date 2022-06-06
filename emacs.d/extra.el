;;; package --- extra configs
;;; Commentary:
;;; This file contains all of the extra configurations that don't necessarily
;;; fit the other files.
;;; NOTE: This file needs to be executed last.
;;; Code:
;; Linting/Formatting
(require 'flycheck)

(use-package tide
  :ensure t)
(add-hook 'before-save-hook 'tide-format-before-save)

(require 'company)
(setq company-tooltip-align-annotations t)

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
  :hook
  ('smartparens-enabled-hook #'evil-smartparens-mode))

;; Others
(use-package which-key
  :config
  (which-key-mode))

(use-package helm
  :config
  (helm-mode))

(use-package ivy
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  :config
  (ivy-mode 1))

(use-package counsel)

(use-package swiper)

(use-package which-key)

(use-package affe
  :config
  (consult-customize affe-grep
		     :preview-key (kbd "M-.")))

(provide 'extra)
;;; extra.el ends here
