
;; Package manager - melpa 
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))       
             (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(require 'multiple-cursors)

;; multicursor stuff (ctrl d do sublime)
(global-set-key (kbd "C-d") 'mc/mark-next-like-this)
(global-set-key (kbd "C-x C-d") 'mc/skip-to-next-like-this)

;; Tira o "ter q escrever yes" pra sair sem salvar
(defun my-save-buffers-kill-emacs (&optional arg)
  "Offer to save each buffer(once only), then kill this Emacs process.
With prefix ARG, silently save all file-visiting buffers, then kill."
  (interactive "P")
  (save-some-buffers arg t)
  (and (or (not (fboundp 'process-list))
       ;; process-list is not defined on MSDOS.
       (let ((processes (process-list))
         active)
         (while processes
           (and (memq (process-status (car processes)) '(run stop open listen))
            (process-query-on-exit-flag (car processes))
            (setq active t))
           (setq processes (cdr processes)))
         (or (not active)
         (progn (list-processes t)
            (yes-or-no-p "Active processes exist; kill them and exit anyway? ")))))
       ;; Query the user for other things, perhaps.
       (run-hook-with-args-until-failure 'kill-emacs-query-functions)
       (or (null confirm-kill-emacs)
       (funcall confirm-kill-emacs "Really exit Emacs? "))
       (kill-emacs)))
(global-set-key (kbd "C-x C-c") 'my-save-buffers-kill-emacs)


;; (xterm-mouse-mode 1)

;; Tira o beep beep, i'm a sheep 
(setq visible-bell 0)

;; move linhas pra cima e pra baixo
(global-set-key (kbd "M-+") 'drag-stuff-down)
(global-set-key (kbd "M-=") 'drag-stuff-down)
(global-set-key (kbd "M--") 'drag-stuff-up)


