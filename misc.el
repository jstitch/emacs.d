;; nethack
(add-to-list 'load-path "~/.emacs.d/site-lisp/nethack_el-0.9.5")
(autoload 'nethack "nethack" "Play Nethack." t)
(setq nethack-program "/usr/local/src/nethack-3.4.3/src/nethack")
;; (add-hook 'nethack-map
;;           (lambda ()
;;             (set-variable show-trailing-whitespace nil)
;;             (global-nl-line-mode)))

;; XKCD
(use-package emacs-xkcd
 :commands (xkcd-get xkcd-get-latest)
  :ensure t
)

;; 2048
(use-package 2048-game
  :commands 2048-game
  :ensure t
)

;; emstar
(use-package emstar
  :commands emstar
  :ensure t
  )

;; minesweeper
(use-package minesweeper
  :commands minesweeper
  :ensure t
)

;; roguel-ike
(use-package roguel-ike
  :commands roguel-ike
  :ensure t
)

(use-package xbm-life
  :commands xbm-life
  :ensure t
)

;; Chess ICS
(use-package chess
  :commands (chess chess-ics)
  :ensure t
)
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
