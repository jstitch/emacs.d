;; Load CEDET
;; (load-file "/usr/share/emacs/site-lisp/cedet/common/cedet.el")

(use-package magit
  :bind ("\C-xg" . magit-status)
  )

;; (use-package ghub)

;; (use-package magithub
;;   :after magit
;;   :config (magithub-feature-autoinject t))

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
(setq load-path (cons "/usr/share/emacs/site-lisp/ess" load-path))
(use-package ess-site)


;; web-mode
(add-to-list 'load-path "/usr/share/emacs/site-lisp/web-mode")
(use-package web-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\.html\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.phtml\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.tpl\.php\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.jsp\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.as[cp]x\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.erb\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.mustache\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.djhtml\'" . web-mode))
)


;; simple-httpd
;; (use-package simple-httpd
;;   :config
;;   (setq httpd-root "~/public_html")
;;   (setq httpd-port 8090)
;;   (setq httpd-servlets t)
;; )
;; (httpd-start)


(add-to-list 'load-path "~/.emacs.d/site-lisp/imp")
(use-package imp
  :defer t
)

;; ;; VimishFold
;; (use-package vimish-fold
;;   :defer t
;;   :bind (("s-v f" . #vimish-fold)
;;          ("s-v v" . #vimish-fold-delete)
;;          :map vimish-fold-folded-keymap
;;          ("C-g" . nil)
;;          ("C-h" . #vimish-fold-unfold)
;;          :map vimish-fold-unfolded-keymap
;;          ("C-g" . nil)
;;          ("C-h" . #vimish-fold-refold)
;;          ("s-<mouse-3>" . vimish-fold-refold))
;;   :config
;;   (vimish-fold-global-mode 1)
;; )

;; OrigamiMode
(use-package origami
  :config
  (global-origami-mode)
  (define-key origami-mode-map (kbd "C-c C-f") #'origami-toggle-all-nodes)
  (define-key origami-mode-map (kbd "C-c C-h") #'origami-toggle-node)
  (define-key origami-mode-map (kbd "C-c C-g") #'origami-open-node-recursively)
  (define-key origami-mode-map (kbd "s-<mouse-3>") #'origami-toggle-node)
)


;; Eshell
(use-package eshell
  :commands eshell
)

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


(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))
(with-eval-after-load "esh-opt"
  (use-package virtualenvwrapper
    :defer t
    :config
    (venv-initialize-eshell)
    (autoload 'epe-theme-lambda "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil
          eshell-prompt-function 'epe-theme-lambda))
  )

(eshell-git-prompt-use-theme 'powerline)

;; (add-to-list 'eshell-visual-commands "mutt")
;; (add-to-list 'eshell-visual-commands "links")
;; (add-to-list 'eshell-visual-commands "htop")
;; (add-to-list 'eshell-visual-commands "nano")
;; (add-to-list 'eshell-visual-commands "nethack")
