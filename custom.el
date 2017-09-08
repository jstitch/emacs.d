;; Customs
;; window numbering
(use-package window-numbering)
(window-numbering-mode)

;; line numbers
(global-linum-mode)
(use-package linum-off)

;; column marker
(use-package column-marker
  :bind ([?\C-c ?m] . column-marker-1)
  :config
  (add-hook 'text-mode-hook (lambda () (interactive) (column-marker-2 80)))
)

;; undo tree
(use-package undo-tree
  :commands undo-tree-mode
)

;; recent files
(use-package recentf
  :defer t
  :bind ("s-r" . recentf-open-files)
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 25)
)

;; create parent subdirectories before saving
(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))

;; define function to display ansi colours for a buffer
;; http://stackoverflow.com/questions/23378271/how-do-i-display-ansi-color-codes-in-emacs-for-any-mode
(use-package ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; ace-jump
(global-set-key (kbd "C-c u") 'ace-jump-mode)

;; ;; persistent-scratch
;; (use-package persistent-scratch
;;   :config
;;   (persistent-scratch-setup-default))

;; interactively do things mode
(ido-mode t)

(use-package info-look)

(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes
                 '("\\.zip\\'" ".zip" "unzip")))

(put 'emms-browser-delete-files 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; auto-fill mode turn
(global-set-key (kbd "C-c q") 'auto-fill-mode)

;; Colors
(set-background-color "Black")
(set-foreground-color "White")
(set-cursor-color "Wheat")

;; (add-hook 'post-command-hook 'change-my-background-color)
;; (add-hook 'change-major-mode-hook 'change-my-background-color)
;; (add-hook 'window-configuration-change-hook 'change-my-background-color)
;; (defun change-my-background-color ()
;;   (cond
;;    ((eq major-mode 'term-mode)
;;     (set-frame-parameter (selected-frame) 'alpha '(100 100)))
;;    (t
;;     (set-frame-parameter (selected-frame) 'alpha '(85 75)))
;;    ))

;; Font
(add-to-list 'default-frame-alist '(font . "Hack-12"))
;;(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-12"))
;;(set-face-attribute 'default nil :font "Courier New-12")

;; Transparency
;;;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
(set-frame-parameter (selected-frame) 'alpha '(85 75))
(add-to-list 'default-frame-alist '(alpha 85 75))

;; Close current window, fast
(global-set-key (kbd "s-0") 'delete-window)
;; One window, fast
(global-set-key (kbd "s-1") 'delete-other-windows)
;; Two windows (horiz split), fast
(global-set-key (kbd "s-2") 'split-window-below)
;; Two windows (vert split), fast
(global-set-key (kbd "s-3") 'split-window-right)
;; Shrink/enlarge windows, fast
(global-set-key (kbd "s-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "s-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "s-C-<down>") 'shrink-window)
(global-set-key (kbd "s-C-<up>") 'enlarge-window)

;; no truncate lines
(set-default 'truncate-lines t)

;; tabs config
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; empty lines at bottom indicator
;; extra whitespace in red
(add-hook 'prog-mode-hook
          (lambda ()
            (setq show-trailing-whitespace t)
            (setq indicate-empty-lines t)))

;; current line
(add-hook 'prog-mode-hook 'hl-line-mode)

;; Copy to clipboard
(load-file "~/.emacs.d/site-lisp/xclip.el")

;; indent with C-tab
(global-set-key (kbd "s-<tab>") 'indent-region)

;; comment region with C-c C-c
(global-set-key (kbd "s-c") 'comment-region)
;; uncomment region with C-c C-u
(global-set-key (kbd "s-u") 'uncomment-region)

;; find file in repo
(global-set-key (kbd "C-x f") 'find-file-in-repository)

;; today's date
;; from http://emacswiki.org/emacs/InsertingTodaysDate
(defun insert-todays-date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%d-%m-%Y")
            (format-time-string "%Y-%m-%d"))))

;; Crux
(use-package crux
  :defer t
)
;; (use-package crux
;;              :bind (("C-a" . crux-move-beginning-of-line)))
