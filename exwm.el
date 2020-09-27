(load-user-file "editor_custom.el")

(require 'exwm)
(require 'exwm-config)

(fringe-mode 1)

;; EXWM systemtray
(require 'exwm-systemtray)
(exwm-systemtray-enable)
;; 10 workspaces
(setq exwm-workspace-number 10)
(setq exwm-workspace-show-all-buffers t)
(setq exwm-layout-show-all-buffers t)

;; undefine C-z, it's a mess when accidentally typing C-z and EXWM
;; tries to stupidly suspend itself here. Dah!
(global-unset-key (kbd "C-z"))

;; Close current window, fast
(global-set-key (kbd "C-s-0") 'delete-window)
;; One window, fast
(global-set-key (kbd "C-s-1") 'delete-other-windows)
;; Two windows (horiz split), fast
(global-set-key (kbd "C-s-2") 'split-window-below)
;; Two windows (vert split), fast
(global-set-key (kbd "C-s-3") 'split-window-right)

;; Volume buttosn
(exwm-input-set-key (kbd "<XF86AudioRaiseVolume>")
                    (lambda ()
                      (interactive)
                      (start-process "" nil "amixer" "-D" "pulse" "sset" "Master" "5%+")))
(exwm-input-set-key (kbd "<XF86AudioLowerVolume>")
                    (lambda ()
                      (interactive)
                      (start-process "" nil "amixer" "-D" "pulse" "sset" "Master" "5%-")))
(exwm-input-set-key (kbd "<XF86AudioMute>")
                    (lambda ()
                      (interactive)
                      (start-process "" nil "amixer" "-D" "pulse" "set" "Master" "toggle")))

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
(exwm-input-set-key (kbd "M-s-f") (lambda ()
                                    (interactive)
                                    (let
                                        ((comando "firefox"))
                                      (start-process-shell-command comando nil comando))))
(push (elt (kbd "M-s-f") 0) exwm-input-prefix-keys)
;; Launch chromium
(exwm-input-set-key (kbd "M-s-c") (lambda ()
                                    (interactive)
                                    (let
                                        ((comando "chromium"))
                                      (start-process-shell-command comando nil comando))))
(push (elt (kbd "M-s-c") 0) exwm-input-prefix-keys)
;; Launch terminator
(exwm-input-set-key (kbd "M-s-t") (lambda ()
                                    (interactive)
                                    (let
                                        ((comando "terminator"))
                                      (start-process-shell-command comando nil comando))))
(push (elt (kbd "M-s-t") 0) exwm-input-prefix-keys)

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

;; Global keys
(setq exwm-input-global-keys
      `(
        ;; Bind "s-r" to exit char-mode and fullscreen mode.
        ([?\s-r] . exwm-reset)
        ;; Bind "s-w" to switch workspace interactively.
        ([?\s-w] . exwm-workspace-switch)
        ;; Bind "s-0" to "s-9" to switch to a workspace by its index.
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-create ,i))))
                  (number-sequence 0 9))
        ;; Bind "s-&" to launch applications ('s-&' also works if the output
        ;; buffer does not bother you).
        ([?\s-d] . (lambda (command)
                     (interactive (list (read-shell-command "run async shell command $> ")))
                     (start-process-shell-command command nil command)))
        ))
(global-set-key (kbd "s-<SPC>") (lambda (command)
                                  (interactive (list (read-shell-command "run asnyc shell command $> ")))
                                  (start-process-shell-command command nil command)))
(setq exwm-input-simulation-keys
      '(
        ;; movement
        ([?\C-b] . [left])
        ([?\M-b] . [C-left])
        ([?\C-f] . [right])
        ([?\M-f] . [C-right])
        ([?\C-p] . [up])
        ([?\C-n] . [down])
        ([?\C-a] . [home])
        ([?\C-e] . [end])
        ([?\M-v] . [prior])
        ([?\C-v] . [next])
        ([?\C-d] . [delete])
        ([?\C-k] . [S-end delete])
        ;; cut/paste.
        ;; ([?\C-w] . [?\C-x])
        ([?\M-w] . [?\C-c])
        ([?\C-y] . [?\C-v])
        ;; search
        ([?\C-s] . [?\C-f])))

;; Multimonitor
(require 'exwm-randr)
(setq exwm-randr-workspace-output-plist '(0 "DP-1" 1 "eDP-1" 2 "HDMI-2"))
(add-hook 'exwm-randr-screen-change-hook
          (lambda ()
            (start-process-shell-command
             "xrandr" nil "xrandr --output eDP-1 --primary --mode 1366x768 --pos 1366x0 --rotate normal --output DP-1 --mode 1366x768 --pos 0x0 --rotate normal --output HDMI-1 --off --output HDMI-2 --mode 1360x768 --pos 2732x0 --rotate normal")))
(defun una_pantalla ()
  "Una pantalla."
  (interactive)
  (shell-command "source ~/.screenlayout/normal.sh"))
(defun tres_pantallas ()
  "Tres pantallas."
  (interactive)
  (shell-command "source ~/.screenlayout/trabajo_3_pantallas_exwm.sh"))
(global-set-key (kbd "C-M-s-n") 'una_pantalla)
(global-set-key (kbd "C-M-s-w") 'tres_pantallas)

;; Enable EXWM
(exwm-enable)
(exwm-randr-enable)

;; tweaks
;; time
(display-time-mode)
;; battery
(display-battery-mode)
;; eshel
(eshell)
(kill-buffer "*About GNU Emacs*")
;;; exwm ends here
