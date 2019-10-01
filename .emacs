(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/load")
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-want-C-u-scroll t)
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(inhibit-startup-screen t)
 '(lsp-prefer-flymake :none)
 '(package-selected-packages
   (quote
    (gotest go-projectile ivy-yasnippet yasnippet company-lsp lsp-mode go-mode ghci-completion company-ghc company-flx flx company magit ivy evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(ido-mode 1)
(ivy-mode 1)
(counsel-mode 1)

(setq ivy-re-builders-alist
      '((swiper . regexp-quote)
        (t      . ivy--regex-fuzzy)))


(add-hook 'after-init-hook #'global-flycheck-mode)
;; (add-hook 'flycheck-mode-hook #'flymake-mode)

(require 'go-projectile)
(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)

;; (add-hook 'after-init-hook 'global-company-mode)

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-ghc)
  (company-flx-mode +1))

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;; (require 'better-defaults)




(when (fboundp 'winner-mode)
      (winner-mode 1))

;;(require 'evil)
;;(evil-mode 1)

(require 'yasnippet)
(require 'lsp-mode)
(add-hook 'go-mode-hook #'lsp)

(require 'company-lsp)
(push 'company-lsp company-backends)

;; (require 'lsp-ui)
;; (add-hook 'lsp-mode-hook 'lsp-ui-mode)

(fset 'yes-or-no-p 'y-or-n-p)

 
