(load-user-file "editor_custom.el")

(require 'exwm)
(require 'exwm-systemtray)
(exwm-systemtray-enable)
(require 'exwm-config)
(exwm-config-default)

;; Close current window, fast
(global-set-key (kbd "C-s-0") 'delete-window)
;; One window, fast
(global-set-key (kbd "C-s-1") 'delete-other-windows)
;; Two windows (horiz split), fast
(global-set-key (kbd "C-s-2") 'split-window-below)
;; Two windows (vert split), fast
(global-set-key (kbd "C-s-3") 'split-window-right)
;; Lock screen (screensaver)
(defun screensaver ()
  "Activate screensaver."
  (interactive)
  (shell-command "xscreensaver-command -activate"))
(global-set-key (kbd "C-M-S-l") 'screensaver)

(display-time-mode)
(display-battery-mode)

(eshell)
(kill-buffer "*About GNU Emacs*")

(provide 'exwm)
;;; exwm ends here
