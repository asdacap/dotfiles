(require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(package-selected-packages
   '(evil-magit magit ace-window vterm flycheck-rust flycheck rust-mode evil-collection ace-jump-mode avy markdown-mode evil-easymotion use-package ivy evil)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(ivy-mode 1)
(counsel-mode 1)

(use-package ivy
  :bind ("C-x C-f" . counsel-file-jump))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "s") nil)
  (define-key evil-normal-state-map (kbd "s s") 'avy-goto-char-timer)
  (define-key evil-normal-state-map (kbd "s k") 'avy-goto-line)
  (define-key evil-normal-state-map (kbd "s j") 'avy-goto-line)
)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package ace-window
  :bind (("M-o" . ace-window)
	 ("C-x o" . ace-window)))

(defun reload-config ()
  (interactive)
  (load-file "~/.emacs"))
