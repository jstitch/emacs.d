;; OrigamiMode
(use-package autopair
  :ensure t
  :config
  (autopair-global-mode))

(use-package paredit
  :commands paredit-mode
  :defer t
  :ensure t)

(use-package origami
  :ensure  t
  :config
  (global-origami-mode)
  (define-key origami-mode-map (kbd "C-c C-f") #'origami-toggle-all-nodes)
  (define-key origami-mode-map (kbd "C-c C-h") #'origami-toggle-node)
  (define-key origami-mode-map (kbd "C-c C-g") #'origami-open-node-recursively)
  (define-key origami-mode-map (kbd "s-<mouse-3>") #'origami-toggle-node))

;; Load CEDET
;; (load-file "/usr/share/emacs/site-lisp/cedet/common/cedet.el")

(use-package monky
  :commands monky-status
  :defer t
  :ensure t)

(use-package magit
  :bind ("\C-xg" . magit-status)
  :ensure t)

;; (use-package ghub)

;; (use-package glab)

;; (use-package magithub)

;; (setq gitlab-host "http://watson:81"
;;           gitlab-username "jstitch"
;;           gitlab-password "")


;; (use-package yasnippet
;;   :config
;;   (yas-global-mode 1)
;; )


;;;
;;--------------------------------------------------------------------
;; ;; Lines enabling gnuplot-mode

;; ;; move the files gnuplot.el to someplace in your lisp load-path or
;; ;; use a line like
;; ;;  (setq load-path (append (list "/path/to/gnuplot") load-path))

;; ;; these lines enable the use of gnuplot mode
;;   (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
;;   (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; ;; this line automatically causes all files with the .gp extension to
;; ;; be loaded into gnuplot mode
;;   (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))

;; ;; This line binds the function-9 key so that it opens a buffer into
;; ;; gnuplot mode
;;   (global-set-key [(f9)] 'gnuplot-make-buffer)

;; ;; end of line for gnuplot-mode
;;--------------------------------------------------------------------


;; ESS
(use-package ess-site
  :load-path "/usr/share/emacs/site-lisp/ess"
  :commands R)


;; simple-httpd
;; (use-package simple-httpd
;;   :config
;;   (setq httpd-root "~/public_html")
;;   (setq httpd-port 8090)
;;   (setq httpd-servlets t)
;; )
;; (httpd-start)

(use-package imp
  :load-path "~/.emacs.d/site-lisp/imp")

;; ;; VimishFold
;; (use-package vimish-fold
;;   :defer t
;;   :bind (:map vimish-fold-folded-keymap
;;          ("C-g" . nil)
;;          ("C-h" . #'vimish-fold-unfold)
;;          :map vimish-fold-unfolded-keymap
;;          ("C-g" . nil)
;;          ("C-h" . #'vimish-fold-refold)
;;          ("s-<mouse-3>" . vimish-fold-refold))
;;   :config
;;   (vimish-fold-global-mode 1)
;;   (global-set-key (kbd "s-v f") #'vimish-fold)
;;   (global-set-key (kbd "s-v v") #'vimish-fold-delete)
;; )

;; Multi-Term
(use-package multi-term
  :commands multi-term
  :config
  (setq multi-term-program "/bin/bash")
  (custom-set-variables
   '(term-default-bg-color "#000000")        ;; background color (black)
   '(term-default-fg-color "#dddd00"))       ;; foreground color (yellow)
  (setq term-unbind-key-list '("C-x" "C-c" "C-h" "C-y" "<ESC>")) ;; C-z
  ;; (setq term-bind-key-alist (delete "C-r" term-bind-key-alist))
)

;; Eshell
(use-package eshell
  :commands eshell
;;  :config
;; (add-to-list 'eshell-visual-commands "mutt")
;; (add-to-list 'eshell-visual-commands "links")
;; (add-to-list 'eshell-visual-commands "htop")
;; (add-to-list 'eshell-visual-commands "nano")
;; (add-to-list 'eshell-visual-commands "nethack")
)

;; (setq eshell-prompt-function
;; (lambda ()
;; (concat
;; (propertize "┌─[" 'face `(:foreground "green"))
;; (propertize (user-login-name) 'face `(:foreground "yellow"))
;; (propertize "@" 'face `(:foreground "green"))
;; (propertize (system-name) 'face `(:foreground "blue"))
;; (propertize "]─[" 'face `(:foreground "green"))
;; (propertize (format-time-string "%H:%M" (current-time)) 'face `(:foreground "yellow"))
;; (propertize "]─[" 'face `(:foreground "green"))
;; (propertize (concat (eshell/pwd)) 'face `(:foreground "white"))

;; ;; (propertize "]─[" 'face `(:foreground "green"))
;; ;; (propertize (concat "G:" (eshell-git-prompt--git-string "symbolic-ref" "HEAD" "--short")))

;; (propertize "]\n" 'face `(:foreground "green"))
;; (propertize "└─>" 'face `(:foreground "green"))
;; (propertize (if (= (user-uid) 0) " # " " λ ") 'face `(:foreground "green"))
;; )))

(use-package eshell-prompt-extras
  :defer t
  :ensure t  )

(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-multiline-with-status "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-multiline-with-status))

(with-eval-after-load "esh-opt"
  (use-package virtualenvwrapper
    ;; :defer t
    :config
    (venv-initialize-eshell)
    (autoload 'epe-theme-multiline-with-status "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil
          eshell-prompt-function 'epe-theme-multiline-with-status)))

(use-package eshell-git-prompt
  :defer t
  :ensure t
  :config
  (eshell-git-prompt-use-theme 'powerline))

(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode)
  :defer t
  :ensure t)


(use-package gnuplot
  :defer t
  :ensure t)

;; Arduino Fun!!!
(add-to-list 'load-path "~/.emacs.d/site-lisp/arduino-mode")
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

;; Wesnoth Mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/wesnoth-mode")
(autoload 'wesnoth-mode "wesnoth-mode" "Major mode for editing WML." t)


;; Moz-controller mode
(use-package moz-controller
  :defer t)


;; Pandoc
(use-package pandoc
  :commands pandoc-open-eww
  :defer t
  :ensure t)


;; rainbow mode
(use-package rainbow-mode
  :commands rainbow-mode
  :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))



(use-package auto-complete
  :ensure t
  :config
  (global-auto-complete-mode t)
  (setq
   ac-auto-start 2
   ac-override-local-map nil
   ac-use-menu-map t
   ac-candidate-limit 20))


(use-package wakatime-mode
  :ensure t
  :config
  (global-wakatime-mode))


;; flycheck
(use-package flycheck
  :defer t
  :ensure t
  :config
  (global-flycheck-mode))

;; all-the-icons
(use-package all-the-icons
  :defer t
  :ensure t)
