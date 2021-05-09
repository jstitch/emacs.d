;; web-mode
(use-package web-mode
  :load-path "/usr/share/emacs/site-lisp/web-mode"
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\.html\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.phtml\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.tpl\.php\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.jsp\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.as[cp]x\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.erb\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.mustache\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\.djhtml\'" . web-mode)))

;; PHP mode
(autoload 'php-mode "php-mode" "PHP editing mode" t)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php5\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php4\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php3\\'" . php-mode))
(add-hook 'php-mode-hook
          (lambda ()
            (setq tab-width 4)
            (setq php-indent 4)))
;;(autoload 'php-mode "php-mode.el" "Php mode." t)
;;(setq auto-mode-alist (append '(("/*.\.php[345]?$" . php-mode)) auto-mode-alist))


;; Drupal mode
(use-package drupal-mode
  :defer t
  :config
  (setup-php-drupal))


;; YAML mode
(use-package yaml-mode
  :mode "\\.yaml\\'"
  :interpreter "yaml"
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))


;; Jinja2 mode
(use-package jinja2-mode
  :commands jinja2-mode
  :ensure t)


;; javarun mode
(use-package javarun
  :interpreter "java"
  :ensure t)


;; json-reformat
(use-package json-reformat
  :defer t
  :commands json-reformat-region
  :ensure t)


;; Go lang mode
;; (use-package go-mode-load
;;   :defer t
;; )


;; python-mode
(use-package python-mode
  :mode "\\.py\\'"
  :interpreter "python"
  :ensure t
  :config
  (autoload 'python-mode "python-mode.el" "Python mode." t))

;; typescript-mode
(use-package typescript-mode
  :mode "\\.ts\\'"
  :interpreter "typescript"
  :ensure t  )

;; hy-mode
(use-package hy-mode
  :mode "\\.hy\\'"
  :interpreter "python"
  :ensure t)


;; sql completion
(use-package sql-completion
  :defer t
  :config
  (setq sql-interactive-mode-hook
        (lambda ()
          (define-key sql-interactive-mode-map "\t" 'completion-at-point)
          (sql-mysql-completion-init))))


;; Apache mode
(autoload 'apache-mode "apache-mode.el" "Apache conf mode." t)
(setq auto-mode-alist (cons '("/httpd.conf$" . apache-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("^/etc/httpd/conf/.*\.conf" . apache-mode) auto-mode-alist))


;; haskell mode
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)


;; Clojure
(use-package clojure-mode
  :mode "\\.clj\\'"
  :ensure t
  :config
  ;; Enable paredit for Clojure
  (add-hook 'clojure-mode-hook 'enable-paredit-mode)
  ;; This is useful for working with camel-case tokens, like names of
  ;; Java classes (e.g. JavaClassName)
  (add-hook 'clojure-mode-hook 'subword-mode))


;; racket mode
(use-package racket-mode
  :mode "\\.rkt\\'"
  :interpreter "racket"
  :ensure t)


;; Cider
(use-package cider
  :commands cider-mode
  :ensure t
  :defer t)


;; Coffee-mode
(use-package coffee-mode
  :commands coffee-mode
  :ensure t)


;; Docker
(use-package docker
  :defer t
  :ensure t)

(use-package dockerfile-mode
  :commands docker-mode
  :ensure t)


;; Dokuwiki mode
(use-package dokuwiki-mode
  :defer t
  :ensure t)


;; restclient mode
(use-package restclient
  :ensure t
  :commands restclient-mode)


;; sql
(use-package sql-indent
  :defer t
  :ensure t)
(eval-after-load "sql"
  '(load-library "sql-indent"))


;; tagedit
(use-package tagedit
  :ensure t
  :config
  (tagedit-add-paredit-like-keybindings)
  (add-hook 'html-mode-hook (lambda () (tagedit-mode 1))))


;; AngularJS
(use-package angular-mode
  :defer t
  :ensure t)


;; Rust
(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm
  (setq-local buffer-save-without-query t))

(use-package lsp-mode
  :ensure
  :commands lsp
  ;; :config
  ;; (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t))

(setq lsp-rust-analyzer-server-display-inlay-hints t)

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))

;; (use-package flycheck-rust
;;   :defer t
;;   :ensure t)
;; (add-hook 'rust-mode-hook 'cargo-minor-mode)


  :defer t
  :ensure t)

(use-package cargo
  :defer t
  :ensure t)

(add-hook 'rust-mode-hook 'cargo-minor-mode)

(use-package xcscope
  :defer t
  :ensure t)

(cscope-setup)
