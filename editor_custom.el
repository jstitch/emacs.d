;; Emacs window config
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(windmove-default-keybindings 'shift)
(show-paren-mode t)

(use-package server
  :config
  (or (server-running-p)
      (server-start))
)

;; ;; Minimap
(use-package minimap
  :defer t
  ;; toggle minimap
  :bind ("s-m" . minimap-toggle)
)

;; smex
(use-package smex
  :defer t
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
  :config
  (setq tramp-default-method "ssh")
  (setq tramp-default-user "jstitch")
  (set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))
)

;; (load "fireplace.el")

(load-user-file "emacs-derivatives.el")
(load-user-file "personal.el")
(load-user-file "dev.el")
(load-user-file "programming.el")
(load-user-file "python.el")
(load-user-file "tweaks.el")
(load-user-file "webservices.el")
(load-user-file "office.el")
(load-user-file "misc.el")

(message "Hello, world!")

(about-emacs)
