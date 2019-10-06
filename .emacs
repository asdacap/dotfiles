;(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
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
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(display-line-numbers-type (quote relative))
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (lsp-java doom-modeline auctex latex-preview-pane ivy-hydra hydra dap-mode evil-collection evil-surround gotest go-projectile ivy-yasnippet yasnippet company-lsp lsp-mode go-mode ghci-completion company-ghc company-flx flx company magit ivy evil)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(visible-bell t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)
(ido-mode 1)
(global-display-line-numbers-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

;; The buffer list always open switch buffer instead
(define-key global-map "\C-x\C-b" 'ivy-switch-buffer)

;; Winner undo
(when (fboundp 'winner-mode)
      (winner-mode 1))
(define-key global-map "\M-[" 'winner-undo)
(define-key global-map "\M-]" 'winner-redo)

(setq use-package-always-ensure t)

(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-re-builders-alist
      '((swiper . regexp-quote)
        (t      . ivy--regex-fuzzy)))
  :bind
  (("\C-s" . swiper)
   ("S-C-s" . swiper-all)))

(use-package which-key
  :hook
  (after-init . which-key-mode))

(use-package counsel
  :after (ivy)
  :config
  (counsel-mode 1)
  :bind
  (("\M-i" . counsel-imenu)
   ("M-s c" . counsel-rg)
   ("M-o f" . counsel-fzf)
   ("M-o r" . counsel-recentf)))

(use-package flycheck
  :hook
  (after-init . global-flycheck-mode))

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
  :hook
  (after-init . global-company-mode))

(use-package company-flx
  :after (company)
  :config
  (company-flx-mode +1))

(use-package ghc
  :hook haskell
  :commands (ghc-init ghc-init))

(use-package company-ghc
  :after (company ghc)
  (add-to-list 'company-backends 'company-ghc))

(use-package evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :bind
  (:map evil-normal-state-map
	("\M-." . nil)
	("\C-n" . nil)
	("\C-p" . nil))
  (:map evil-motion-state-map
	("\C-f" . 'evil-scroll-up)
	("\C-b" . 'evil-scroll-down)
	("\C-d" . nil)
	("\C-u" . nil))
  :config
  (evil-mode 1))
;;(evil-default-state (quote emacs))
;;(evil-set-initial-state 'prog-mode 'normal)

(use-package magit)

(use-package evil-magit
  :after (evil magit))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package lsp-mode
  :hook go-mode
  :config
  (setq lsp-prefer-flymake :none))

(use-package lsp-ui
  :after lsp-mode
  :hook lsp-mode)

(use-package lsp-java
  :after lsp-mode)

;;(use-package company-lsp
;;  :after (company lsp-mode)
;;  :config ((push 'company-lsp company-backends)))

(use-package dap-mode
  :after lsp-mode
  :config
  (require 'dap-go)
  (dap-ui-mode 1)
  ;; enables mouse hover support
  (dap-tooltip-mode 1)
  ;; use tooltips for mouse hover
  ;; if it is not enabled `dap-mode' will use the minibuffer.
  (tooltip-mode 1)

  (setq dap-inhibit-io nil)
  (setq dap-print-io t)

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
				     :envFile nil)))

(use-package yasnippet)

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package tex
  :ensure auctex)

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))
