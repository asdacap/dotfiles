(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/load")
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dap-inhibit-io nil)
 '(dap-print-io t)
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (ivy-hydra hydra dap-mode evil-collection evil-surround gotest go-projectile ivy-yasnippet yasnippet company-lsp lsp-mode go-mode ghci-completion company-ghc company-flx flx company magit ivy evil)))
 '(visible-bell t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(ido-mode 1)

(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-re-builders-alist
      '((swiper . regexp-quote)
        (t      . ivy--regex-fuzzy))))

(use-package counsel
  :config
  (counsel-mode 1))

(use-package flycheck
  :hook
  (add-init . #'global-flycheck-mode))

(use-package projectile
  :bind
  (:map projectile-mode-map
	 ("s-p" . projectile-command-map)
         ("C-c p" . projectile-command-map))
  :config
  (projectile-mode +1)
  :demand)

(use-package company
  :config
  (add-to-list 'company-backends 'company-ghc)
  :hook
  (after-init . 'global-company-mode))

(use-package company-flx
  :after (company)
  :config
  (company-flx-mode +1))
(use-package ghc
  :hook haskell
  :commands (ghc-init ghc-init))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :bind
  (:map evil-normal-state-map
	("\M-." . nil)
	("\C-n" . nil)
	("\C-p" . nil))
  :config
  (evil-mode 1))
;;(evil-default-state (quote emacs))
;;(evil-set-initial-state 'prog-mode 'normal)

(use-package evil-magit
  :after evil)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package lsp-mode
  :hook go-mode
  :config
  (setq lsp-prefer-flymake :none))

(use-package lsp-ui
  :after lsp-mode
  :hook lsp-mode)

(use-package company
  :hook ((after-init . global-company-mode)))

(use-package company-lsp
  :after (company, lsp-mode)
  :config ((push 'company-lsp company-backends)))

(use-package dap-mode
  :after lsp-mode
  :config
  (dap-mode 1)
  (dap-ui-mode 1)
  ;; enables mouse hover support
  (dap-tooltip-mode 1)
  ;; use tooltips for mouse hover
  ;; if it is not enabled `dap-mode' will use the minibuffer.
  (tooltip-mode 1)
  )


(use-package dap-go
  :after dap-mode
  :config
  (defun dap-go--populate-default-args (conf)
    "Populate CONF with the default arguments."
    (setq conf (pcase (plist-get conf :mode)
		 ("auto" (dap-go--populate-auto-args conf))
		 ("debug" (dap--put-if-absent conf :program (lsp-find-session-folder (lsp-session) (buffer-file-name))))
		 ("test" (dap--put-if-absent conf :program (expand-file-name (lsp-find-session-folder (lsp-session) (buffer-file-name)))))
		 ("exec" (dap--put-if-absent conf :program (read-file-name "Select executable to debug.")))
		 ("remote"
		  (dap--put-if-absent conf :program (lsp-find-session-folder (lsp-session) (buffer-file-name)))
		  (dap--put-if-absent conf :port (string-to-number (read-string "Enter port: " "2345")))
		  (dap--put-if-absent conf :program-to-start
				      (concat dap-go-delve-path
					      " attach --headless --api-version=2 "

					      (number-to-string
					       (dap--completing-read "Select process: "
								     (list-system-processes)
								     (lambda (pid)
								       (-let (((&alist 'user 'comm)
									       (process-attributes pid)))
									 (format "%6d %-30s %s" pid comm user)))
								     nil t))))
		  )))

    (-> conf
	(dap--put-if-absent :dap-server-path dap-go-debug-program)
	(dap--put-if-absent :dlvToolPath dap-go-delve-path)
	(dap--put-if-absent :type "go")
	(dap--put-if-absent :showLog "true")
	(dap--put-if-absent :trace "verbose")
	(dap--put-if-absent :name "Go Debug")))

  (dap-register-debug-provider "go" 'dap-go--populate-default-args)
  (dap-register-debug-template "Go Launch Test Package Configuration"
			       (list :type "go"
				     :request "launch"
				     :name "Launch Test Package"
				     :mode "test"
				     :program nil
				     :buildFlags nil
				     :args nil
				     :env nil
				     :envFile nil))
  )

(use-package yasnippet)

(fset 'yes-or-no-p 'y-or-n-p)

;; The buffer list always open switch buffer instead
(define-key global-map "\C-x\C-b" 'ivy-switch-buffer)

;; Winner undo
(when (fboundp 'winner-mode)
      (winner-mode 1))
(define-key global-map "\M-[" 'winner-undo)
(define-key global-map "\M-]" 'winner-redo)
