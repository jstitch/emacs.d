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


(use-package web-mode
  :defer t
  :ensure t)
;; Typescript
(use-package typescript
  :defer t
  :ensure t)
(use-package tide
  :defer t
  :ensure t
  :config
  (progn
    (company-mode +1)
    ;; aligns annotation to the right hand side
    (setq company-tooltip-align-annotations t)
    (add-hook 'typescript-mode-hook #'setup-tide-mode)
    (add-hook 'before-save-hook 'tide-format-before-save)
    (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (json-mode js2-mode company web-mode tide flycheck))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (setq tide-format-options '(:identSize 2 :tabSize 2 :insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))
  (local-set-key (kbd "C-c d") 'tide-documentation-at-point)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)
  (setq company-minimum-prefix-length 1))
;; use web-mode + tide-mode for javascript instead
(use-package js2-mode
  :defer t
  :ensure t
  :config
  (progn
    (add-hook 'js2-mode-hook #'setup-tide-mode)
    ;; configure javascript-tide checker to run after your default javascript checker
    (setq js2-basic-offset 2)
    (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
    (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
    (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))))
;; (add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(use-package json-mode
  :ensure t
  :config
  (progn
    (flycheck-add-mode 'json-jsonlint 'json-mode)
    (add-hook 'json-mode-hook 'flycheck-mode)
    (setq js-indent-level 2)
    (add-to-list 'auto-mode-alist '("\\.json" . json-mode))))

(use-package web-mode
  :ensure t
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.js"     . web-mode))
    (add-to-list 'auto-mode-alist '("\\.html"   . web-mode))
    ;; this magic incantation fixes highlighting of jsx syntax in .js files
    (setq web-mode-content-types-alist
          '(("jsx" . "\\.js[x]?\\'")))
    (add-hook 'web-mode-hook
              (lambda ()
                (setq web-mode-code-indent-offset 2)
                (when (string-equal "tsx" (file-name-extension buffer-file-name))
                  (setup-tide-mode))
                (when (string-equal "jsx" (file-name-extension buffer-file-name))
                  (setup-tide-mode))
                (when (string-equal "js" (file-name-extension buffer-file-name))
                  (progn
                    (setup-tide-mode)
                    (with-eval-after-load 'flycheck
                      (flycheck-add-mode 'typescript-tslint 'web-mode)
                      (flycheck-add-mode 'javascript-tide 'web-mode))))))
    ))
    ;; enable typescript-tslint checker

(use-package xcscope
  :defer t
  :ensure t)

(cscope-setup)
