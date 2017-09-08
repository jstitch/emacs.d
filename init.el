;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; File name: ` ~/.emacs.d/init.el '
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-initialize)

(setq custom-file "~/.gnu-emacs-custom")
(load "~/.gnu-emacs-custom" t t)

(setq load-path (cons "~/.emacs.d/site-lisp" load-path))
(setq load-path (cons "/usr/share/emacs/site-lisp/emacs-goodies-el" load-path))
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/emacs-goodies-el")

(require 'use-package)

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(load-user-file "package-management.el")
(load-user-file "custom.el")

;; open config (this file) easily
(global-set-key (kbd "C-c e") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
