(autoload 'pkgbuild-mode "pkgbuild-mode.el" "PKGBUILD mode." t)
(setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode)) auto-mode-alist))

;; melpa/marmalade
(use-package package
  :defer t
  :config
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/") t)
;;  (add-to-list 'package-archives
;;               '("melpa-stable" . "http://hiddencameras.milkbox.net/packages/"))
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  ;; elpa
  (add-to-list 'load-path "~/.emacs.d/elpa")
  ;; el-get
  (add-to-list 'load-path "~/.emacs.d/el-get/el-get")
  )

(use-package paradox
  :commands paradox-list-packages
  :ensure t
  )


(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)


(when (not package-archive-contents)
  (package-refresh-contents))
