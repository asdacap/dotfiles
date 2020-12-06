(require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(js-indent-level 2)
 '(org-babel-load-languages (quote ((shell . t) (emacs-lisp . t))))
 '(package-selected-packages
   (quote
    (ob-async lsp-java dap-mode javadoc-lookup which-key company-lsp lsp-mode exec-path-from-shell counsel evil-magit magit ace-window vterm flycheck-rust flycheck rust-mode evil-collection ace-jump-mode avy markdown-mode evil-easymotion use-package ivy evil)))
 '(vc-follow-symlinks t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package counsel
  :ensure t
  :config
  (counsel-mode 1))

(use-package exec-path-from-shell
  :ensure t
  :init
  :config
  (exec-path-from-shell-initialize))

(use-package ivy
  :ensure t
  :bind ("C-x C-f" . counsel-find-file)
  :config
  (ivy-mode 1))

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

(add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))

(setenv "EDITOR" "find-file")

(define-key prog-mode-map (kbd "C-c C-c") 'compile)
(global-auto-revert-mode)

(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
(setq lsp-keymap-prefix "C-c o")

(use-package lsp-mode
    :hook (
            (rust-mode . lsp)
            (lsp-mode . lsp-enable-which-key-integration))
    :commands lsp)

;; optionally
;; (use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
;;(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;;(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode))

(use-package ob-async
  :ensure t
  :init)
