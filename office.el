;; Org mode
(use-package org
  :ensure t
  :interpreter "org"
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
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)
(use-package org-tree-slide
  :ensure t
)
(use-package org-trello
  :defer t
  :ensure t
)
;; Babel Org-Mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t) (sh . t)))

;; set sizes here to stop spacemacs theme resizing these
(set-face-attribute 'org-level-1 nil :height 1.0)
(set-face-attribute 'org-level-2 nil :height 1.0)
(set-face-attribute 'org-level-3 nil :height 1.0)
(set-face-attribute 'org-scheduled-today nil :height 1.0)
(set-face-attribute 'org-agenda-date-today nil :height 1.1)
(set-face-attribute 'org-table nil :foreground "#008787")


;; SCRUM
;; (load-user-file "scrum.el")
(use-package uml-mode
  :ensure t
  :defer t
)
(use-package org-scrum
  :ensure t
  :defer t
)
(load-user-file "org-scrum.el")

;; Calfw Calendar
(use-package calfw
  :ensure t
  :defer t
)
(use-package calfw-org
  :ensure t
)

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
(use-package mu4e
  :load-path "/usr/local/share/emacs/site-lisp/mu4e"
  :commands mu4e
  :config
  (setq
   mu4e-maildir       "~/Mail"   ;; top-level Maildir
   mu4e-sent-folder   "/sent"       ;; folder for sent messages
   mu4e-drafts-folder "/drafts"     ;; unfinished messages
   mu4e-trash-folder  "/trash"      ;; trashed messages
   mu4e-refile-folder "/archive"    ;; saved messages)
  );; (setq mu4e-html2text-command "w3m -T text/html")(
  (setq mu4e-html2text-command "html2text -utf8 -nobs -width 72")
  ;; enable inline images
  (setq mu4e-view-show-images t)
  ;; kill message buffer after sending it
  (setq message-kill-buffer-on-exit t)
  ;; Don't ask to quit
  (setq mu4e-confirm-quit nil)
  ;; use imagemagick, if available
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))
)
(use-package org-mu4e
  :config (setq org-mu4e-link-query-in-headers-mode nil)
  )
(defun jnc-mu4e-allow-index-when-open ()
  (interactive)
  (mu4e~proc-kill)
  (message "mu4e")
)
;; (run-with-timer 0 60 'jnc-mu4e-allow-index-when-open)
(defun my-mu4e-choose-signature ()
  "Insert one of a number of sigs"
  (interactive)
  (let ((message-signature
          (mu4e-read-option "Signature:"

            '(("simpleformal" .
              (concat
               "<#part type=text/html><html><body>\n"
               "<p><img src='http://podemos.mx/images/logo.png' /></p>\n"
               "<p><strong>Javier Novoa Cataño</strong><br />\n"
               "C.T.I. Podemos Progresar<br />\n"
               "http://invernalia.homelinux.net<br />\n"
               " .<br />\n"
               "..:</p>\n"
               "<p>D: Blvd. Manuel Ávila Camacho #2258, 2do piso, ciudad Satélite, Naucalpan de Juárez, Estado de México, C.P. 53100</p>\n"
               "<p>T: 16682585        M: jstitch@gmail.com</p>\n"
               "<p>W: http://podemos.mx</p>\n"
               "<p>El contenido de este mensaje y sus anexos son de carácter estrictamente confidencial y única y exclusivamente para el uso de la(s) persona(s) o entidad(es) a quien(es) está dirigido. Si la persona que recibe este correo electrónico no es su destinatario, se le notifica que cualquier modificación, divulgación, utilización o copia del mismo está prohibida y será denunciada y en su caso sancionada en términos de los ordenamientos legales aplicables. Si usted ha recibido este mensaje por error, borrarlo de inmediato de su sistema y en su caso destruirlo. Revisa nuestro aviso de privacidad http://podemos.mx/aviso-privacidad.html</p>\n"
               "</body></html><#/part>\n"))

              ("informal" .
                (concat
                 "J.N.C.\n"
                 "Eru kaluva tielyanna\n"
                 "http://invernalia.homelinux.net/jstitch\n"
                 " .\n"
                 "..:\n"))

               ("formal" .
                (concat
                 "<#part type=text/html><html>\n"
"    <link rel=\"stylesheet\" href=\"http://fonts.googleapis.com/css?family=Raleway:100,200,400,500,600,700,800,900\" />
    <style type=\"text/css\">
         /* Client-Specific styles */
         #outlook a 		{ padding:0; } /* Force Outlook to provide a \"view in browser\" menu link. */
         body 				{ width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0; border:0; }

         /* Prevent Webkit and Windows Mobile platforms from changing default font sizes, while not breaking desktop design. */
         .ExternalClass 	{ width:100%; } /* Force Hotmail to display emails at full width */
         .ExternalClass,
		 .ExternalClass p,
		 .ExternalClass span,
		 .ExternalClass font,
		 .ExternalClass td,
		 .ExternalClass div { line-height:100%; } /* Force Hotmail to display normal line spacing.*/
         img 				{ outline:none; text-decoration:none;border:none; -ms-interpolation-mode:bicubic; }
         a img 				{ border:none; text-decoration:none;border:none; -ms-interpolation-mode:bicubic; }
         p 					{ margin:0px 0px !important; }
         table 				{ border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }
         table td 			{ border-collapse:collapse; }

         /* iPad Styles */
         @media only screen and (max-width: 640px) {
             a[href^=\"tel\"], a[href^=\"sms\"] {
				 text-decoration:none;
				 color:#000000;
				 pointer-events:none;
				 cursor:default;
             }
             .mobile_link a[href^=\"tel\"], .mobile_link a[href^=\"sms\"] {
				 text-decoration:default;
				 color:#000000 !important;
				 pointer-events:auto;
				 cursor:default;
             }
         }

         /* iPhone Styles */
         @media only screen and (max-width: 480px) {
             a[href^=\"tel\"], a[href^=\"sms\"] {
				 text-decoration:none;
				 color:#000000;
				 pointer-events:none;
				 cursor:default;
             }
             .mobile_link a[href^=\"tel\"], .mobile_link a[href^=\"sms\"] {
				 text-decoration:default;
				 color:#000000 !important;
				 pointer-events:auto;
				 cursor:default;
             }
         }

		 /* Responsive styles */
	    @media only screen and (max-width: 480px) {
	    	td[class=wrapper] {
	    		padding-top:0 !important;
	    		padding-left:0 !important;
	    		padding-right:0 !important;
	    	}

			table[class=mobile-view], td[class=mobile-view], img[class=mobile-view] {
	    		width:320px !important;
	    		height:auto !important;
	    	}

	    	td[class=clump] {
	    		display:block !important;
	    		padding-left:0 !important;
	    		padding-right:0 !important;
				width:100% !important;
	    	}

	    	td[class=aligncenter] {
	    		width:300px !important;
	    		height:auto !important;
	    		text-align:center !important;
	    	}
	    }
    </style>
</head>

<body>
<table width=\"540\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"mobile-view\" style=\"border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;\">
	<tbody>
		<tr>
            <td width=\"90\" valign=\"top\" align=\"left\" style=\"padding:0 10px 20px 0;\" class=\"clump\">
            	<table width=\"90\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;\">
                	<tr>
                        <td valign=\"middle\" align=\"center\" style=\"width:90px; height:90px; -moz-border-radius:50%; -khtml-border-radius:0%; -webkit-border-radius:50%; -o-border-radius:0%; -ms-border-radius:0%; -border-radius:0%;\">
                            <!-- Add the Mark of your Company Logo -->
                            <img src=\"http://podemos.mx/images/logo.png?crc=3974936346\" alt=\"LogoPodemos\" alt=\"Logo\" width=\"150\" border=\"0\" style=\"display:block; border:0; outline:none;\" />
                        </td>
                	</tr>
                </table>
            </td>
            <td valign=\"top\" align=\"left\" class=\"clump\" style=\"padding:0 0 0 10px;\">
				<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;\">
					<tbody>
                        <tr>
                            <td style=\"padding:0 0 0 10px;\">
                                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;\">
                                    <tr>
                                        <!-- Edit your Name or Title -->
                                        <td style=\"font-family:'Raleway', sans-serif, Arial; font-size:18px; line-height:24px; font-weight:900; text-transform:uppercase; color:#2f3542;\">Javier Novoa Cataño</td>
                                    </tr>
                                    <tr>
                                        <!-- Edit your job title or subtitle -->
                                        <td style=\"font-family:'Raleway', sans-serif, Arial; font-size:12px; line-height:20px; font-weight:400; color:#a3a7b2;\">C.T.I. Podemos Progresar</td>
                                    </tr>
                                    <tr>
                                        <td style=\"font-family:'Raleway', sans-serif, Arial; font-size:10px; line-height:20px; font-weight:400; color:#a3a7b2;\"><a href=\"http://invernalia.homelinux.net/jstitch\" >http://invernalia.homelinux.net/jstitch</a></td>
                                    </tr>
                                    <tr>
                                        <td style=\"font-family:'Courier New', Courier, monospace; font-size:8px; line-height:10px; font-weight:400; color:black;\">&nbsp;.<br />..:</td>
                                    </tr>
                                    <tr>
                                        <!-- Divider -->                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style=\"padding:10px 0 0 10px;\">
                                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;\">
                                    <tbody>
                                        <tr>
                                            <td width=\"33%\" class=\"clump\">
                                                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;\">
                                                    <tbody>
                                                        <tr>
                                                            <td width=\"25\" height=\"30\" valign=\"top\"><img src=\"http://podemos.mx/Firma/icons/icon_green_address.png\" alt=\"Address\" border=\"0\" width=\"22\" style=\"display:block; border:0; outline:none;\" /></td>
                                                            <!-- Edit your Address -->
                                                            <td width=\"\" height=\"30\" valign=\"top\" align=\"left\" style=\"font-family:'Raleway', sans-serif, Arial; font-size:12px; line-height:24px; font-weight:400; color:#2f3542;\"> Blvd. Manuel Ávila Camacho #2258, Piso 2, Ciudad Satélite, Naucalpan de Juárez, Estado de México, C.P. 53100</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style=\"padding:0 0 0 10px;\">
                                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;\">
                                    <tbody>
                                        <tr>
                                            <td width=\"30%\" class=\"clump\">
                                                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;\">
                                                    <tbody>
                                                      <tr>
                                                            <td width=\"26\" height=\"30\" valign=\"top\"><img src=\"http://podemos.mx/Firma/icons/icon_green_phone.png\" alt=\"Phone\" border=\"0\" width=\"20\" style=\"padding:3px 0 0 0; display:block; border:0; outline:none;\" /></td>
                                                            <!-- Edit your Phone number -->
                                                            <td width=\"\" height=\"30\" valign=\"top\" align=\"left\" style=\"font-family:'Raleway', sans-serif, Arial; font-size:12px; line-height:24px; font-weight:400; color:#2f3542;\"> 16682585 </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td width=\"33%\" class=\"clump\">
                                                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;\">
                                                    <tbody>
                                                        <tr>
                                                            <td width=\"26\" height=\"30\" valign=\"top\"><img src=\"http://podemos.mx/Firma/icons/icon_green_email.png\" alt=\"Email\" border=\"0\" width=\"20\" style=\"padding:3px 0 0 0; display:block; border:0; outline:none;\" /></td>
                                                            <!-- Edit your Email address -->
                                                            <td width=\"\" height=\"30\" valign=\"top\" align=\"left\" style=\"font-family:'Raleway', sans-serif, Arial; font-size:12px; line-height:24px; font-weight:400; color:#2f3542;\"><a href=\"mailto:jstitch@gmail.com\" style=\"text-decoration:none; color:#2f3542;\">jstitch@gmail.com</a></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style=\"padding:0 0 0 10px;\">
                                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;\">
                                    <tbody>
                                        <tr>
                                            <td width=\"33%\" class=\"clump\">
                                                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;\">
                                                    <tbody>
                                                        <tr>
                                                            <td width=\"25\" height=\"30\" valign=\"top\"><img src=\"http://podemos.mx/Firma/icons/icon_green_website.png\" alt=\"Web\" border=\"0\" width=\"22\" style=\"display:block; border:0; outline:none;\" /></td>
                                                            <!-- Edit your website URL -->
                                                            <td width=\"\" height=\"30\" valign=\"top\" align=\"left\" style=\"font-family:'Raleway', sans-serif, Arial; font-size:12px; line-height:24px; font-weight:400; color:#2f3542;\"><a href=\"http://podemos.mx\" style=\"text-decoration:none; color:#2f3542;\">podemos.mx</a></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
						<tr>
							<!-- Edit your social network URLs -->
                            <td style=\"padding:10px 0 10px 0;\">
								<a href=\"https://www.facebook.com/podemosMx/?ref=br_rs\"><img src=\"http://podemos.mx/Firma/icons/social_icon_green2_facebook.png\" alt=\"Facebook\" width=\"35\" border=\"0\" style=\"display:inline-block; border:0; outline:none;\" /></a>
								<a href=\"https://twitter.com/podemosmx?lang=es\"><img src=\"http://podemos.mx/Firma/icons/social_icon_green2_twitter.png\" alt=\"Twitter\" width=\"35\" border=\"0\" style=\"display:inline-block; border:0; outline:none;\" /></a>
								<a href=\"https://www.linkedin.com/company/podemos-progresar/\"><img src=\"http://podemos.mx/Firma/icons/social_icon_green2_linkedin.png\" alt=\"LinkedIN\" width=\"35\" border=\"0\" style=\"display:inline-block; border:0; outline:none;\" /></a>
								<a href=\"https://www.instagram.com/podemosmx/\"><img src=\"http://podemos.mx/Firma/icons/social_icon_green2_instagram.png\" alt=\"Instagram\" width=\"35\" border=\"0\" style=\"display:inline-block; border:0; outline:none;\" /></a>
								<a href=\"https://medium.com/the-making-of-a-gazelle-ceo/\"><img src=\"http://podemos.mx/Firma/icons/plant.png\" alt=\"Cultura Podemos\" width=\"35\" border=\"0\" style=\"display:inline-block; border:0; outline:none;\" /></a>
								<a href=\"#\"><img src=\"http://podemos.mx/Firma/icons/icon_green_mobile.png\" alt=\"Celular\" width=\"35\" border=\"0\" style=\"display:inline-block; border:0; outline:none;\" /></a>
							</td>
						</tr>
                        <tr>
							<!-- Edit your social network URLs -->
                            <td style=\"font-family:'Raleway', sans-serif, Arial; font-size:10px; line-height:18px; font-weight:400; color:#acb1bc; padding:10px 0 0 10px;\">
                            El contenido de este mensaje y sus anexos son de carácter estrictamente confidencial y única y exclusivamente para el uso de la(s) persona(s) o entidad(es) a quien(es) está dirigido. Si la persona que recibe este correo electrónico no es su destinatario, se le notifica que cualquier modificación, divulgación, utilización o copia del mismo está prohibida y será denunciada y en su caso sancionada en términos de los ordenamientos legales aplicables. Si usted ha recibido este mensaje por error, borrarlo de inmediato de su sistema y en su caso destruirlo. Revisa nuestro aviso de privacidad: http://podemos.mx/aviso-privacidad.html
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</tbody>
</table>
</body>
\n"
                 "</html><#/part>\n"
                 ))

              ))))
    (message-insert-signature)))

(add-hook 'mu4e-compose-mode-hook
          (lambda () (local-set-key (kbd "C-c C-w") #'my-mu4e-choose-signature)))

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
(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
)

;; nov-el
(use-package nov
  :mode ("\\.epub\\'" . nov-mode)
  :ensure t
)


;; demo-it
(use-package demo-it
  :defer t
  :ensure t
)
(use-package expand-region
  :ensure t
)
(use-package fancy-narrow
  :ensure t
)
