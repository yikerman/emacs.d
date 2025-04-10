;; -*- lexical-binding: t; -*-

;;; Put autogenerated custom vars to seperate (untracked) file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; ...and ignores it completely
;;(load custom-file)


;;; Basics

(setq visible-bell t
      inhibit-startup-message t)

(load-theme 'tango-dark)
(tool-bar-mode -1)
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

(use-package command-log-mode)
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
   ("C-c V" . ivy-pop-view))
  :init (ivy-mode 1)
  :config
  (setq enable-recursive-minibuffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 16)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; TODO: Use built-in which-key in emacs 30+
(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-idle-delay 1))

(use-package sly)

(use-package magit)


