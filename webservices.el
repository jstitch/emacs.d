;; W3M mode
;;  (use-package w3m-load)
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(global-set-key "\C-xm" ' browse-url-at-point)
(setq w3m-use-cookies t)
;;  (use-package mime-w3m)

;;; Emacs/W3 Configuration
(setq load-path (cons "/usr/share/emacs/site-lisp" load-path))
(condition-case () (use-package w3-auto "w3-auto") (error nil))

;;
;; ;; emacs-google
;;
;; (use-package icalendar)
;; (use-package google-calendar
;;   :config
;;   (setq google-calendar-user           "jstitch")
;;   (setq google-calendar-directory      "~/tmp")
;;   (setq google-calendar-url            "https://www.google.com/calendar/ical/XXX/privateXXX/basic.ics") ;;; URL TO YOUR GOOGLE CALENDAR
;;   (setq google-calendar-auto-update    t )  ;;; DEFINE IF THE CALENDAR IS DOWNLOADED AFTER EVERY MODIFICATION
;; )

;; Add Urban Dictionary to webjump
(global-set-key (kbd "C-x w") 'webjump)
(eval-after-load "webjump"
'(add-to-list 'webjump-sites
              '("Urban Dictionary" .
                [simple-query
                 "www.urbandictionary.com"
                 "http://www.urbandictionary.com/define.php?term="
                 ""])))

;; default browse-url's
(defun duckduckgo (what)
  "Use ddg to search for WHAT."
  (interactive "sSearch: ")
  (browse-url-firefox (concat "https://duckduckgo.com/?t=lm&q="
                              (url-unhex-string what))))

(defun googlesearch (what)
  "Use gs to search for WHAT."
  (interactive "sSearch: ")
  (browse-url (concat "https://google.com/search?q="
                              (url-unhex-string what))))

;; youtube viewer
(defun w3m-yt-view ()
  "View a YouTube link with youtube-dl and mplayer."
  (interactive)
  (let ((url (or (w3m-anchor) (w3m-image))))
    (string-match "[^v]*v.\\([^&]*\\)" url)
    (let* ((vid (match-string 1 url))
           (out (format "%s/%s.mp4" w3m-default-save-directory vid)))
      (call-process "youtube-dl" nil nil nil "-U" "-q" "-c" "-o" out url)
      (start-process "mplayer" nil "mplayer" "-quiet" out))))

(defun be-social ()
  "Connect to IM networks using bitlbee."
  (interactive)
  (erc :server "127.0.0.1" :port 6667 :nick "jstitch"))

;; ERC switch buffers
(defun rgr/ido-erc-buffer()
  (interactive)
  (switch-to-buffer
   (ido-completing-read "Channel:"
                        (save-excursion
                          (delq
                           nil
                           (mapcar (lambda (buf)
                                     (when (buffer-live-p buf)
                                       (with-current-buffer buf
                                         (and (eq major-mode 'erc-mode)
                                              (buffer-name buf)))))
                                   (buffer-list)))))))
(setq erc-hide-list '("JOIN" "PART" "QUIT"))
(global-set-key (kbd "C-c E") 'rgr/ido-erc-buffer)

;; OAuth mode
;; (use-package oauth
;;   :defer t
;; )

;; rtorrent mentor
(use-package mentor
  :commands mentor
  :config
  (setq mentor-rtorrent-url "scgi://127.0.0.1:5000")
)

;; twittering-mode
(use-package twittering-mode
  :commands twittering-mode
  :config
  (setq twittering-use-master-password t)
)

;; youtube
(defun play-youtube-video (url)
  (interactive "sURL: ")
  (shell-command
   (concat "youtube-dl  -o - " url " | mplayer -")))

;; Webkit
;; (load-user-file "webkit.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Elfeed feed reader                                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default elfeed-search-filter "+unread ")
(use-package elfeed
  :commands elfeed
  :ensure t
  :bind (:map elfeed-search-mode-map
              ("A" . bjm/elfeed-show-all)
              ("S" . bjm/elfeed-show-starred)
              ("*" . bjm/elfeed-star)
              ("8" . bjm/elfeed-unstar)
              ("t" . elfeed-show-tag)
              ("T" . elfeed-show-untag)
              ))

;;shortcut functions
(defun bjm/elfeed-show-all ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-all"))

;;functions to support syncing .elfeed between machines
;;makes sure elfeed reads index from disk before launching
(defun bjm/elfeed-load-db-and-open ()
  "Wrapper to load the elfeed db from disk before opening"
  (interactive)
  (elfeed-db-load)
  (elfeed)
  (elfeed-search-update--force))
;;write to disk when quiting
(defun bjm/elfeed-save-db-and-bury ()
  "Wrapper to save the elfeed db to disk before burying buffer"
  (interactive)
  (elfeed-db-save)
  (quit-window))

;; add a star
(defun bjm/elfeed-star ()
  "Apply starred to all selected entries."
  (interactive )
  (let* ((entries (elfeed-search-selected))
         (tag (intern "starred")))

    (cl-loop for entry in entries do (elfeed-tag entry tag))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

;; remove a start
(defun bjm/elfeed-unstar ()
  "Remove starred tag from all selected entries."
  (interactive )
  (let* ((entries (elfeed-search-selected))
         (tag (intern "starred")))

    (cl-loop for entry in entries do (elfeed-untag entry tag))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

;; elfeed goodies!
(use-package elfeed-goodies
  :ensure t
  :config
  (elfeed-goodies/setup))

;; use an org file to organise feeds
(use-package elfeed-org
  :ensure t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "/home/jstitch/org/elfeed.org"))
  )

;; elfeed star
;;shortcut to jump to starred bookmark
(defun bjm/elfeed-show-starred ()
  (interactive)
  (bookmark-jump "elfeed-starred"))

;; face for starred articles
(defface elfeed-search-starred-title-face
  '((t :foreground "#f77"))
  "Marks a starred Elfeed entry.")

(push '(starred elfeed-search-starred-title-face) elfeed-search-face-alist)
