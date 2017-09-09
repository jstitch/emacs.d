(use-package virtualenv
  :defer t
  :ensure t
)
(use-package virtualenvwrapper
  :defer t
  :ensure t
)

(add-hook 'Info-mode-hook		; After Info-mode has started
          (lambda ()
            (setq Info-additional-directory-list Info-default-directory-list)
            ))
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(setq py-electric-colon-active t)
(add-hook 'python-mode-hook 'autopair-mode)
;;  (add-hook 'python-mode-hook 'enable-paredit-mode)
;;  (add-hook 'python-mode-hook 'yas-minor-mode)
;; (setq py-shell-name "/home/jstitch/.virtualenvs/podemos/bin/ipython")
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
(setq py-split-windows-on-execute-p nil)

(setenv "PYTHONPATH" (concat
                      (getenv "PYTHONPATH") ":"
                      "/opt/podemosprogresar/lib/python"))


;; ;; jedi
;; (use-package jedi
;;   :config
;;   ;; change python interpreter
;;   (setq jedi:server-command
;;         '("~/src/python/podemosprogresar/python/bin/python" "~/.emacs.d/site-lisp/jedi/jediepcserver.py"))
;;   (jedi:install-server)
;;   (add-hook 'python-mode-hook
;;             (lambda ()
;;               (jedi:setup)
;;               (jedi:ac-setup)
;;               (local-set-key "\C-cd" 'jedi:show-doc)
;;               (local-set-key (kbd "M-SPC") 'jedi:complete)
;;               (local-set-key (kbd "M-.") 'jedi:goto-definition)))
;; )

;; (use-package flymake)
;; flymake for python
;; (defun flymake-python-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "epylint2" (list local-file))
;;     ;; (setenv "PYTHONPATH" (concat
;;     ;;                       (getenv "PYTHONPATH") ":"
;;     ;;                       "/opt/podemosprogresar/lib/python"))
;; ))
;; (defun flymake-activate ()
;;   "Activates flymake when real buffer and you have write access"
;;   (if (and
;;        (buffer-file-name)
;;        (file-writable-p buffer-file-name))
;;       (progn
;;         (flymake-mode t)
;;         ;; this is necessary since there is no flymake-mode-hook...
;;         (local-set-key (kbd "C-c n") 'flymake-goto-prev-error)
;;         (local-set-key (kbd "C-c p") 'flymake-goto-prev-error))))
;; (defun ca-flymake-show-help ()
;;   (when (get-char-property (point) 'flymake-overlay)
;;     (let ((help (get-char-property (point) 'help-echo)))
;;       (if help (message "%s" help)))))
;; (add-hook 'post-command-hook 'ca-flymake-show-help)
;; (add-to-list 'flymake-allowed-file-name-masks
;;              '("\\.py\\'" flymake-python-init))
;; (add-hook 'python-mode-hook 'flymake-activate)
(add-hook 'python-mode-hook 'auto-complete-mode)


;; ein
(use-package ein
  :defer t
  :config
  (setq ein:use-auto-complete-superpack 't)
  (setq ein:console-args "--profile default")
)


;; (elpy-enable)
;; (setq elpy-rpc-backend "native")


;; activate the virtualenv where Pymacs is located
;; (virtualenv-workon "podemos/")


;; ;; ipython
;; (use-package ipython
;;   :config
;;   (setq
;;    python-shell-interpreter "ipython"
;;    python-shell-interpreter-args ""
;;    python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;    python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;    python-shell-completion-setup-code
;;    "from IPython.core.completerlib import module_completion"
;;    python-shell-completion-module-string-code
;;    "';'.join(module_completion('''%s'''))\n"
;;    python-shell-completion-string-code
;;    "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
;; )

(use-package nose
  :defer t
)
