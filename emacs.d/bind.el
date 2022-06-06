;;; bind.el --- My bindings.
;;; Commentary:
;;; Various Emacs bindings.
;;; Code:
(defun split-and-follow-vert ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-vert)

(defun split-and-follow-hor ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-hor)
;;; bind.el ends here
