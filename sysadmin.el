;; Aurel
(use-package aurel
  :defer t
  :ensure t
  :load-path "/usr/share/emacs/site-lisp/aurel"
  :config
  ;; autoloads for the interactive functions
  (autoload 'aurel-package-info "aurel" nil t)
  (autoload 'aurel-package-search "aurel" nil t)
  (autoload 'aurel-maintainer-search "aurel" nil t)
  ;; directory where the packages will be downloaded
  (setq aurel-download-directory "~/abs")
)

;; helm-systemd
(use-package helm-systemd
  :commands helm-systemd
)


;; top from emacs
(use-package top
  :commands top
)


(use-package logview
  :commands logview-mode
  :ensure t
  :defer t
)
