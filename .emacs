(require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; I you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(evil-undo-system 'undo-redo)
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(org-babel-load-languages '((shell . t) (emacs-lisp . t)))
 '(org-file-apps
   '((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . default)
     (directory . emacs)))
 '(package-selected-packages
   '(plantuml-mode helm helm-git flx flycheck-xcode yaml-mode gcmh wisitoken-grammar-mode editorconfig auto-compile ob-async lsp-java dap-mode javadoc-lookup which-key company-lsp lsp-mode exec-path-from-shell counsel evil-magit magit ace-window vterm flycheck-rust flycheck rust-mode evil-collection ace-jump-mode avy markdown-mode evil-easymotion use-package ivy evil))
 '(select-enable-clipboard nil)
 '(vc-follow-symlinks t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(use-package gcmh
  :ensure t
  :init
  :config
  (gcmh-mode 1))

(use-package auto-compile
  :ensure t
  :init
  :config
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))

;;
;;; Optimization copied from DOOM

;; A second, case-insensitive pass over `auto-mode-alist' is time wasted, and
;; indicates misconfiguration (or that the user needs to stop relying on case
;; insensitivity).
(setq auto-mode-case-fold nil)

;; Disable bidirectional text rendering for a modest performance boost. I've set
;; this to `nil' in the past, but the `bidi-display-reordering's docs say that
;; is an undefined state and suggest this to be just as good:
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)

;; Disabling the BPA makes redisplay faster, but might produce incorrect display
;; reordering of bidirectional text with embedded parentheses and other bracket
;; characters whose 'paired-bracket' Unicode property is non-nil.
(setq bidi-inhibit-bpa t)  ; Emacs 27 only

;; Reduce rendering/line scan work for Emacs by not rendering cursors or regions
;; in non-focused windows.
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; More performant rapid scrolling over unfontified regions. May cause brief
;; spells of inaccurate syntax highlighting right after scrolling, which should
;; quickly self-correct.
(setq fast-but-imprecise-scrolling t)

;; Don't ping things that look like domain names.
(setq ffap-machine-p-known 'reject)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we halve startup times, particularly when we use
;; fonts that are larger than the system default (which would resize the frame).
(setq frame-inhibit-implied-resize t)

;; Adopt a sneaky garbage collection strategy of waiting until idle time to
;; collect; staving off the collector while the user is working.
(setq gcmh-idle-delay 5
      gcmh-high-cons-threshold (* 16 1024 1024))  ; 16mb

;; Emacs "updates" its ui more often than it needs to, so we slow it down
;; slightly from 0.5s:
(setq idle-update-delay 1.0)

;; Font compacting can be terribly expensive, especially for rendering icon
;; fonts on Windows. Whether disabling it has a notable affect on Linux and Mac
;; hasn't been determined, but we inhibit it there anyway. This increases memory
;; usage, however!
(setq inhibit-compacting-font-caches t)


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
  :bind ("C-x C-f" . counsel-fzf)
  :bind ("C-x f" . counsel-find-file)
  :config
  (ivy-mode 1)
 (setq ivy-re-builders-alist
      '((t . ivy--regex-fuzzy)))
  )

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "SPC") 'universal-argument)
  (define-key evil-normal-state-map (kbd "s") nil)
  (define-key evil-normal-state-map (kbd "s s") 'avy-goto-char-timer)
  (define-key evil-normal-state-map (kbd "s k") 'avy-goto-line)
  (define-key evil-normal-state-map (kbd "s j") 'avy-goto-line)
  (define-key evil-normal-state-map (kbd "[ q") 'next-error)
  (define-key evil-normal-state-map (kbd "] q") 'previous-error)
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

(use-package editorconfig
  :ensure t
  :init
  :config
  (editorconfig-mode 1))

(global-set-key "\M- " 'hippie-expand)

(defun ivy-sort-files-function (_name candidates)
  "Sort CANDIDATES files alphabetically ignoring trailing slashes.
Meant for use in `ivy-sort-matches-functions-alist' so 
directories will have a trailing /, ignore it so foo.txt is after foo/."
  ;; Perhaps add a check for if directories should sort first
  (cl-sort (copy-sequence candidates)
           (lambda (x y)
             (string< (if (string-suffix-p "/" x) (substring x 0 -1) x)
                      (if (string-suffix-p "/" y) (substring y 0 -1) y)))))

(setenv "EDITOR" "find-file")
(substitute-key-definition 'kill-buffer 'kill-buffer-and-its-windows global-map)
