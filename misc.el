;; nethack
(add-to-list 'load-path "~/.emacs.d/site-lisp/nethack_el-0.9.5")
(autoload 'nethack "nethack" "Play Nethack." t)
(setq nethack-program "/usr/local/src/nethack-3.4.3/src/nethack")
;; (add-hook 'nethack-map
;;           (lambda ()
;;             (set-variable show-trailing-whitespace nil)
;;             (global-nl-line-mode)))

;; Aurel
(add-to-list 'load-path "/usr/share/emacs/site-lisp/aurel")
(use-package aurel
  :config
  ;; autoloads for the interactive functions
  (autoload 'aurel-package-info "aurel" nil t)
  (autoload 'aurel-package-search "aurel" nil t)
  (autoload 'aurel-maintainer-search "aurel" nil t)
  ;; directory where the packages will be downloaded
  (setq aurel-download-directory "~/abs")
)

;; Coffee Mode
;; (use-package coffee
;;   :defer t
;; )

;; Arduino Fun!!!
(add-to-list 'load-path "~/.emacs.d/site-lisp/arduino-mode")
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

;; Wesnoth Mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/wesnoth-mode")
(autoload 'wesnoth-mode "wesnoth-mode" "Major mode for editing WML." t)

;; XKCD
;; (use-package xkcd)

;; Chess ICS
(use-package chess)
(defun playchess ()
  "Play chess on FICS!"
  (interactive)
  (setq username (read-string "Username: "))
  (if (string= username "guest")
      (chess-ics "freechess.org" 5000 username)
    (setq pass (read-passwd "Password: "))
    (chess-ics "freechess.org" 5000 username pass)
    )
  )
(provide 'playchess)
