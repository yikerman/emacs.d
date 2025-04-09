;; -*- lexical-binding: t; -*-

(setq visible-bell t
      inhibit-startup-message t)

(load-theme 'tango-dark)
(tool-bar-mode -1)
(set-fringe-mode 8)
(set-face-attribute 'default nil :font "IBM Plex Mono" :height 128)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; ESC quit prompts
(global-auto-revert-mode 1) ; Reload file automatically
(setq-default indent-tabs-mode nil) ; Use spaces for indentation

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
  :config
  (ivy-mode 1)
  (setq enable-recursive-minibuffers t)
  (setq ivy-count-format "(%d/%d) "))
(use-package sly)
(use-package magit)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(magit sly counsel ivy command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
