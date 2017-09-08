;; Org mode
(use-package org
  :config
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (setq org-log-done t)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (setq org-todo-keywords '("TODO" "STARTED" "WAITING" "|" "CANCELLED" "POSTPONED" "DONE"))
  (setq org-agenda-include-diary t)
  (setq org-agenda-include-all-todo t)
  ;; Org mode
  (setq org-agenda-files (list "~/org/personal.org"
                               "~/documents/podemos/plan_trabajo/org"))
)

;; SCRUM
(load-user-file "scrum.el")

;; Calfw Calendar
(use-package calfw-org)

;; Gnus usenet newsreader / mail client
(setq gnus-select-method '(nntp "freenews.netfront.net"))
(setq gnus-read-active-file nil)
;;  (add-to-list 'gnus-secondary-select-methods '(nntp "localhost"))
;;  (add-to-list 'gnus-secondary-select-methods '(nntp "news.gnus.org"))
;;  (add-to-list 'gnus-secondary-select-methods '(nnml ""))
;;  (eval-after-load "mail-source" '(add-to-list 'mail-sources '(maildir :path "/home/jstitch/Mail/" :subdirs ("cur" "new"))))
;;  (setq send-mail-function 'smtpmail-send-it)
;;  (setq message-send-mail-function 'smtpmail-send-it)
;;  (setq smtpmail-default-smtp-server "localhost")
;;  (setq smtpmail-auth-credentials '(("localhost" "25" "username" "password")))
;;  (setq smtpmail-starttls-credentials '(("localhost" "25" nil nil)))

;; mutt mail client
;; (server-start)
;; (add-to-list 'auto-mode-alist '("/mutt" . mail-mode))

;; mu4e
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(use-package mu4e
  :commands mu4e
  :config
  (setq
   mu4e-maildir       "~/Mail"   ;; top-level Maildir
   mu4e-sent-folder   "/sent"       ;; folder for sent messages
   mu4e-drafts-folder "/drafts"     ;; unfinished messages
   mu4e-trash-folder  "/trash"      ;; trashed messages
   mu4e-refile-folder "/archive"    ;; saved messages
   mu4e-compose-signature "J.N.C.
Eru kaluva tielyanna
http://invernalia.homelinux.net/jstitch
 .
..:") ;; email signature
  ;; (setq mu4e-html2text-command "w3m -T text/html")(
  (setq mu4e-html2text-command "html2text -utf8 -nobs -width 72")
  ;; enable inline images
  (setq mu4e-view-show-images t)
  ;; use imagemagick, if available
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))
)

;; Remember mode
(use-package remember
  :commands remember
  :config
  (setq org-remember-templates
        '(("Tasks" ?t "* TODO %?\n  %i\n  %a" "~/org/tasks.org")
          ("Appointments" ?a "* Appointment: %?\n%^T\n%i\n  %a" "~/citas.org")))
  (setq remember-annotation-functions '(org-remember-annotation))
  (setq remember-handler-functions '(org-remember-handler))
  (eval-after-load 'remember
    '(add-hook 'remember-mode-hook 'org-remember-apply-template))
  (global-set-key (kbd "C-c r") 'remember)
)

;; Google Calendar agenda
(defun bjm/open-gcal-agenda ()
  "Open my google calendar agenda file. The agenda is displayed in the buffer *gcal*."
  (interactive)
  ;; set name of calendar buffer and location of file containing my agenda
  (let ((tmp-buff-name "*gcal*") (cal-file (expand-file-name "/tmp/gcal")))
    ;; switch to calendar buffer
    (switch-to-buffer tmp-buff-name)
    ;; turn off read only to overwrite if buffer exists
    (read-only-mode -1)
    ;; clear buffer
    (erase-buffer)
    ;; insert agenda file
    (insert-file-contents cal-file)
    ;; turn on colours
    (display-ansi-colors)
    ;; turn on special mode
    (special-mode)
    ;; turn off line wrapping
    (visual-line-mode -1)))

;; PDF-Tools
(pdf-tools-install)

;; EMMS
(use-package emms-setup
  :commands (emms emms-setup emms-volume)
  :config
  (emms-all)
  (emms-default-players)
  (setq emms-source-file-default-directory "~/Musica/")
)
(use-package emms-volume
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
