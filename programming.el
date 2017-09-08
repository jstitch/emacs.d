(use-package autopair
  :defer t
)

(use-package auto-complete
  :config
  (global-auto-complete-mode t)
  (setq
   ac-auto-start 2
   ac-override-local-map nil
   ac-use-menu-map t
   ac-candidate-limit 20)
)


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
  (setup-php-drupal)
)


;; YAML mode
(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
)


;; Jinja2 mode
(use-package jinja2-mode)


;; Go lang mode
;; (use-package go-mode-load
;;   :defer t
;; )


;; python-mode
(use-package python-mode
  :defer t
  :config
  (autoload 'python-mode "python-mode.el" "Python mode." t)
)


;; sql
(eval-after-load "sql"
  '(load-library "sql-indent"))


;; sql completion
(use-package sql-completion
  :defer t
  :config
  (setq sql-interactive-mode-hook
        (lambda ()
          (define-key sql-interactive-mode-map "\t" 'completion-at-point)
          (sql-mysql-completion-init)))
)

;; Moz-controller mode
(use-package moz-controller
  :defer t
)


;; Apache mode
(autoload 'apache-mode "apache-mode.el" "Apache conf mode." t)
(setq auto-mode-alist (cons '("/httpd.conf$" . apache-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("^/etc/httpd/conf/.*\.conf" . apache-mode) auto-mode-alist))


;; haskell mode
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)


;; Clojure
(use-package clojure-mode
  :defer t
  :config
  ;; Enable paredit for Clojure
  (add-hook 'clojure-mode-hook 'enable-paredit-mode)
  ;; This is useful for working with camel-case tokens, like names of
  ;; Java classes (e.g. JavaClassName)
  (add-hook 'clojure-mode-hook 'subword-mode)
)


;; Cider
(use-package cider-mode
  :defer t
)


;; Babel Org-Mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t) (sh . t)))
