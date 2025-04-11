;; -*- lexical-binding: t; -*-

;;; Put autogenerated custom vars to seperate (untracked) file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)


;;; Basics

(setq visible-bell t
      inhibit-startup-message t)
(auto-save-visited-mode 1)

(windmove-default-keybindings)

(tool-bar-mode -1)
(scroll-bar-mode -1)
;;(set-fringe-mode 8)
(set-face-attribute 'default nil :font "Iosevka IBM Flavor" :height 128) ; See iosevka-build.toml

(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; ESC quit prompts
(global-auto-revert-mode 1) ; Reload file automatically
(setq-default indent-tabs-mode nil) ; Use spaces for indentation

;; Try autocomplete with tab if indent is correct
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

;; Enable line numbers, disable in some modes
(column-number-mode)
(global-display-line-numbers-mode t)
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Org mode bindings
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; When I say enlarge, I mean larger
(global-set-key (kbd "C-c C-]") (lambda () (interactive) (enlarge-window-horizontally  30)))
(global-set-key (kbd "C-c C-[") (lambda () (interactive) (enlarge-window-horizontally -30)))
(global-set-key (kbd "C-c ]") (lambda () (interactive) (enlarge-window  5)))
(global-set-key (kbd "C-c [") (lambda () (interactive) (enlarge-window -5)))

(defun split-and-launch-term ()
  (interactive)
  (split-window-below)
  (enlarge-window 10)
  (windmove-down)
  (term (getenv "SHELL")))
(global-set-key (kbd "C-c t") #'split-and-launch-term)


;;; 3rd Party Packages

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")))
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(use-package all-the-icons
  :if (display-graphic-p))

(use-package command-log-mode)

(use-package dimmer
  :init
  (dimmer-configure-which-key)
  (dimmer-configure-magit)
  (dimmer-configure-org)
  (dimmer-mode t))

(use-package counsel ; Brings in counsel, ivy and swiper
  :bind
  (("C-s" . swiper-isearch)
   ("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("M-y" . counsel-yank-pop)
   ("<f1> f" . counsel-describe-function)
   ("<f1> v" . counsel-describe-variable)
   ("<f1> l" . counsel-find-library)
   ("<f2> i" . counsel-info-lookup-symbol)
   ("<f2> u" . counsel-unicode-char)
   ("<f2> j" . counsel-set-variable)
   ("C-x b" . ivy-switch-buffer)
   ("C-c v" . ivy-push-view)
   ("C-c V" . ivy-pop-view)
   ("C-x M-b" . counsel-switch-buffer))
  :init (ivy-mode 1)
  :config
  (setq enable-recursive-minibuffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 16)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; TODO: Use built-in which-key in emacs 30+
(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-idle-delay 1))

(use-package helpful
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)
   ("C-h x" . helpful-command)
   ("C-c C-d" . helpful-at-point)
   ("C-h F" . helpful-function))
  :config
  (when (package-installed-p 'counsel)
    (setq counsel-describe-function-function #'helpful-callable
          counsel-describe-variable-function #'helpful-variable)))

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-one")
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package projectile
  :bind-keymap ("C-c p" . projectile-command-map)
  :config (projectile-mode 1)
  :custom ((projectile-completion-system 'ivy))
  :init
  (let ((d "~/Developer"))
    (when (file-directory-p d)
     (setq projectile-project-search-path (list d))))
  (setq projectile-switch-project-action #'projectile-dired))

(defun setup-org-mode ()
  (org-indent-mode 1)
  (visual-line-mode 1))
(use-package org
  :hook (org-mode . setup-org-mode)
  :config
  (setq org-ellipsis " ▼"
        org-hide-emphasis-markers t))
(use-package org-appear
  :hook (org-mode . org-appear-mode))
(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 0.99)
                (org-level-6 . 0.98)
                (org-level-7 . 0.97)))
  (set-face-attribute (car face) nil :font "Iosevka IBM Slab Flavor" :weight 'bold :height (cdr face)))

(use-package magit)

(use-package treemacs
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-display-in-side-window          t
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-indentation                     1
          treemacs-indentation-string              "·")

    ;; The default width and height of
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    (treemacs-resize-icons 20)
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))
(use-package treemacs-projectile
  :after (treemacs projectile))
(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once))
(use-package treemacs-magit
  :after (treemacs magit))
(treemacs-start-on-boot)

(use-package sly)

(use-package racket-mode)

(use-package geiser-chez)

