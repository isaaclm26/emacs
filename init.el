(require 'package)

(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

(package-initialize)


(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))


(set-face-attribute 'default nil :height 130)

;; Arregla C-n
(setq auto-window-vscroll nil)

;; scroll one line at a time (less "jumpy" than defaults)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time


;; Solve smooth scrolling
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

;; For regex
(use-package visual-regexp-steroids
  :ensure t
  :config
  (define-key global-map (kbd "C-c r") 'vr/replace)
  (define-key global-map (kbd "C-c q") 'vr/query-replace)
  ;; if you use multiple-cursors, this is for you:
  (define-key global-map (kbd "C-c m") 'vr/mc-mark)
  ;; to use visual-regexp-steroids's isearch instead of the built-in regexp isearch, also include the following lines:
  ;; (define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
  ;; (define-key esc-map (kbd "C-s") 'vr/isearch-forward) ;; C-M-s
  (define-key global-map (kbd "C-r") 'vr/isearch-backward)
  (define-key global-map (kbd "C-s") 'vr/isearch-forward)
  )

;; Mandatory packages

(require 'use-package)
(require 'all-the-icons)

;; spaceline-all-the-icons
(use-package spaceline)

(use-package spaceline-all-the-icons 
  :after spaceline
  :config
  (spaceline-all-the-icons-theme t)
  (spaceline-all-the-icons--setup-anzu)            ;; Enable anzu searching
  (spaceline-all-the-icons--setup-package-updates) ;; Enable package update indicator
  (spaceline-all-the-icons--setup-git-ahead)       ;; Enable # of commits ahead of upstream in git
  (spaceline-all-the-icons--setup-paradox)         ;; Enable Paradox mode line
  (spaceline-all-the-icons--setup-neotree))        ;; Enable Neotree mode line

;; (Symon monitoriza los recursos del sistema)
(use-package symon
  :ensure t
  :init (symon-mode)
  :config (setq symon-monitors '(symon-sparkline-type bounded
				 ;;symon-linux-memory-monitor
				 symon-linux-cpu-monitor
				 symon-linux-network-rx-monitor
				 symon-linux-network-tx-monitor)))

;; neotree
(use-package neotree)

;; Autocomplete
(require 'smartparens-config)

;; Gnuplot mode
(use-package gnuplot-mode)

;; Tab-size
(setq default-tab-width 4)

(setq-default tab-width 4)

;; With this Emacs starts automatically on fullscreen mode

;;(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)


;; This clears the message that shows at the scratch buffer by default

(setq initial-scratch-message "")


;; This way I can just type 'y' instead of 'yes<RET>' to confirm

(fset 'yes-or-no-p 'y-or-n-p)


;; Something to do with backups files lmao

(setq make-backup-files nil)
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))


;; This hides the much-dreaded bars on the top of Emacs GUI

(tooltip-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)


;; This prevents the cursor from blinking

(blink-cursor-mode nil)


;; Global keybindings

(global-set-key (kbd "C-;") 'comment-or-uncomment-region)


;; Themes
(use-package doom-themes
  :ensure t
  :config (load-theme 'doom-one t)
  (doom-themes-neotree-config)
  (doom-themes-org-config)
  )
(set-face-background 'default "#000000")


(use-package all-the-icons
  :ensure t
  )


(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )


(use-package rainbow-mode
  :ensure t
  :mode "\\.css\\'"
  )


(use-package neotree
  :ensure t
  :init
  (setq neo-theme 'icons)
  :bind ("M-n" . neotree-toggle)
  )


(use-package ido
  :ensure
  :init
  (progn
    (ido-mode 1)
    (use-package ido-vertical-mode
      :ensure t
      :init
      (ido-vertical-mode 1)
      (setq ido-vertical-define-keys 'C-n-and-C-p-only)
      )
    (use-package flx-ido
      :ensure t
      :init (flx-ido-mode 1)
      )
    (use-package ido-completing-read+
      :ensure t
      )
    (use-package smex
      :ensure t
      :init (smex-initialize)
      :bind ("M-x" . smex)
      )
    )
  )


(use-package smartparens
  :ensure t
  :init
  (smartparens-global-mode t)
  (add-hook 'prog-mode-hook #'smartparens-mode)
  )


(use-package yasnippet
  :ensure t
  :init (yas-global-mode 1)
  :config
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)
  )


(use-package auto-complete
  :ensure t
  :config (ac-config-default)
  )


(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  )


(use-package tex
  :ensure auctex
  :config
   (setq TeX-auto-save t)
   (setq TeX-parse-self t)
   (setq-default TeX-master nil)
   (setq TeX-save-query nil)
   (setq TeX-PDF-mode t)
   (add-hook 'LaTeX-mode-hook 'visual-line-mode)
   (add-hook 'LaTeX-mode-hook 'flyspell-mode)
   (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
   (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
   (setq reftex-plug-into-AUCTeX t)
   )


(use-package haskell-mode
  :ensure t
  :mode "\\.hs\\'"
  :config
  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  )

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(use-package elpy
  :ensure t
  :mode "\\.py\\'"
  :config
  (elpy-enable)
  )


(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup))
  )


(use-package multi-term
  :ensure t
  :config (setq multi-term-program "/bin/bash")
  :bind ("C-s-t" . multi-term)
  )


(use-package windmove
  :ensure t
  :bind (("C-c <up>" . windmove-up)
         ("C-c <left>" . windmove-left)
         ("C-c <right>" . windmove-right)
         ("C-c <down>" . windmove-down))
  )


(use-package multiple-cursors
  :ensure t
  :bind ("C-S-c C-S-s" . mc/edit-lines)
  )


(use-package hlinum
  :ensure t
  :init
  (global-linum-mode 1)
  (hlinum-activate)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("10461a3c8ca61c52dfbbdedd974319b7f7fd720b091996481c8fb1dded6c6116" default)))
 '(package-selected-packages
   (quote
	(sage-shell-mode visual-regexp-steroids gnuplot-mode gnuplot elpygen use-package smex smartparens rainbow-mode rainbow-delimiters py-autopep8 pretty-mode powerline-evil neotree multiple-cursors multi-term mode-icons magit ido-vertical-mode ido-completing-read+ hlinum haskell-mode flx-ido elpy doom-themes auto-complete auctex)))
 '(spaceline-all-the-icons-file-name-highlight nil)
 '(spaceline-all-the-icons-hide-long-buffer-path t)
 '(spaceline-all-the-icons-separator-type (quote arrow))
 '(spaceline-all-the-icons-separators-invert-direction t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; @begin(61668279)@ - Do not edit these lines - added automatically!
(if (file-exists-p "/home/isaac/.ciaoroot/master/ciao_emacs/elisp/ciao-site-file.el")
  (load-file "/home/isaac/.ciaoroot/master/ciao_emacs/elisp/ciao-site-file.el"))
; @end(61668279)@ - End of automatically added lines.

(defun fontify-frame (frame)
  (interactive)
  (if window-system
      (progn
        (if (> (x-display-pixel-width) 2000)
            (set-frame-parameter frame 'font "Inconsolata 19") ;; Cinema Display
         (set-frame-parameter frame 'font "Inconsolata 16")))))

;; Fontify current frame
(fontify-frame nil)

;; Fontify any future frames
(push 'fontify-frame after-make-frame-functions)
