(load-user-file "editor_custom.el")

(require 'exwm)
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

(eshell)
