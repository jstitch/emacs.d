;; EMMS
(use-package emms
  :ensure t
)

(use-package emms-setup
  :commands (emms emms-setup emms-volume)
  :config
  (emms-all)
  (emms-default-players)
  (setq emms-source-file-default-directory "~/Musica/")
)
(use-package emms-volume
  :defer t
  :bind (("C-c +" . emms-volume-mode-plus)
         ("C-c -" . emms-volume-mode-minus))
)
;; (use-package emms-player-mpd
;;   :config
;;   (setq emms-player-mpd-server-name "localhost")
;;   (setq emms-player-mpd-server-port "6600")
;;   (add-to-list 'emms-info-functions 'emms-info-mpd)
;;   (add-to-list 'emms-player-list 'emms-player-mpd)
;;   (setq emms-volume-change-function 'emms-volume-mpd-change)
;; )


(use-package spotify
  :defer t
  :ensure t
)

(use-package helm-spotify
  :commands helm-spotify
)
