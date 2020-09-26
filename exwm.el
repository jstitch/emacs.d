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

;; Switch buffers with arrows
(exwm-input-set-key (kbd "S-<left>") 'windmove-left)
(push (elt (kbd "S-<left>") 0) exwm-input-prefix-keys)
(exwm-input-set-key (kbd "S-<right>") 'windmove-right)
(push (elt (kbd "S-<right>") 0) exwm-input-prefix-keys)
(exwm-input-set-key (kbd "S-<down>") 'windmove-down)
(push (elt (kbd "S-<down>") 0) exwm-input-prefix-keys)
(exwm-input-set-key (kbd "S-<up>") 'windmove-up)
(push (elt (kbd "S-<up>") 0) exwm-input-prefix-keys)

;; Run external command with helm
(exwm-input-set-key (kbd "s-<") 'helm-run-external-command)
(push (elt (kbd "s-<") 0) exwm-input-prefix-keys)

;; Buffers con titulo de la ventana y no solo de la aplicacion
(defun exwm-rename-buffer ()
  (interactive)
  (exwm-workspace-rename-buffer
   (concat exwm-class-name ":"
	   (if (<= (length exwm-title) 50) exwm-title
	     (concat (substring exwm-title 0 49) "...")))))
(add-hook 'exwm-update-class-hook 'exwm-rename-buffer)
(add-hook 'exwm-update-title-hook 'exwm-rename-buffer)

;; Launch firefox
(exwm-input-set-key (kbd "s-f") (lambda ()
				  (interactive)
				  (let
				      ((comando "firefox"))
				    (start-process-shell-command comando nil comando))))

(push (elt (kbd "s-f") 0) exwm-input-prefix-keys)

;; Lock screen (screensaver)
(defun screensaver ()
  "Activate screensaver."
  (interactive)
  (shell-command "xscreensaver-command -activate"))
(global-set-key (kbd "C-M-S-l") 'screensaver)

;; Wallpaper
(use-package wallpaper
  :ensure t
  :hook ((exwm-randr-screen-change . wallpaper-set-wallpaper)
         (after-init . wallpaper-cycle-mode))
  :custom ((wallpaper-cycle-single t)
           (wallpaper-scaling 'scale)
           (wallpaper-cycle-interval 45)
           (wallpaper-cycle-directory "~/Imagenes/wallpapers")))
(require 'cl-lib)

(wallpaper-set-wallpaper)
(global-set-key (kbd "C-s-w") 'wallpaper-set-wallpaper)

(display-time-mode)
(display-battery-mode)

(eshell)
(kill-buffer "*About GNU Emacs*")

(provide 'exwm)
;;; exwm ends here
