;; Emacs window config
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(windmove-default-keybindings 'shift)
(show-paren-mode t)

(use-package exec-path-from-shell
  :defer t
  :ensure t
)

(use-package server
  :config
  (or (server-running-p)
      (server-start))
)

;; bind-key
(use-package bind-key
  :defer t
)

;; fold-dwim
(use-package fold-dwim
;  :defer t
  :ensure t
)

(use-package fuzzy
;  :defer t
  :ensure t
)

;; Minimap
(use-package minimap
  :defer t
  :ensure t
  ;; toggle minimap
  :bind ("s-m" . minimap-toggle)
  )

;; Treemacs
(use-package treemacs
  :commands treemacs
  :ensure t
  ;; toggle treemacs
  :bind ("s-t" . treemacs-toggle)
)

;; smex
(use-package smex
  :defer t
  :ensure t
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ;; This is your old M-x.
         ("C-c C-c M-x" . execute-extended-command))
  :config
  (smex-initialize)
)

;; Tramp (remote load files)
(use-package tramp
  :defer t
  :ensure t
  :config
  (setq tramp-default-method "ssh")
  (setq tramp-default-user "jstitch")
  (set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))
)

;; Crux
(use-package crux
  :ensure t
)

;; Dired
(setq dired-dwim-target t)

;; Dired-rainbow
(use-package dired-rainbow
  :defer t
  :ensure t
  )

;; Dired-details
(use-package dired-details
  :commands dired-details-toggle
  :ensure t
)

(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes
                 '("\\.zip\\'" ".zip" "unzip")))

;; golden-ratio
(use-package golden-ratio
  :commands golden-ratio
  :ensure t
)

;; smart-operator mode
(use-package smart-operator
  :defer t ;; defering while not knowing how to use this mode
  :ensure t
)

;; tablist
(use-package tablist
  :defer t
  :ensure t
)

;; easyPG
(use-package epa-file
  :config
  (epa-file-enable)
)

;; Helm
(use-package helm)
(setq helm-locate-command "locate %s -e -A --regex %s")

;; interactively do things mode
(use-package ido-completing-read+
  :ensure t
  :config
  (ido-mode t)
  (ido-everywhere t)
  (ido-ubiquitous-mode t)
)

(use-package idomenu
  :ensure t
)

;; (load "~/.emacs.d/site-lisp/fireplace.el")


(load-user-file "emacs-derivatives.el")
(load-user-file "personal.el")
(load-user-file "dev.el")
(load-user-file "sysadmin.el")
(load-user-file "programming.el")
(load-user-file "python.el")
(load-user-file "tweaks.el")
(load-user-file "webservices.el")
(load-user-file "office.el")
(load-user-file "media.el")
(load-user-file "misc.el")
(load-user-file "unused.el")


(message "Hello, world!")
(about-emacs)
