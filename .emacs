(package-initialize)
(add-to-list 'load-path "/home/amirul/.emacs.d/load")
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (ghci-completion company-ghc company-flx flx company magit ivy evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'evil)
(evil-mode 1)

(ivy-mode 1)
(counsel-mode 1)

(setq ivy-re-builders-alist
      '((swiper . regexp-quote)
        (t      . ivy--regex-fuzzy)))

(add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'after-init-hook 'global-company-mode)

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-ghc)
  (company-flx-mode +1))

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

(require 'better-defaults)

(when (fboundp 'winner-mode)
      (winner-mode 1))
