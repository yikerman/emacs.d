;; -*- lexical-binding: t; -*-


(setq visible-bell t
      inhibit-startup-message t)

(load-theme 'tango-dark)
(tool-bar-mode -1)
(set-fringe-mode 8)
(set-face-attribute 'default nil :font "IBM Plex Mono" :height 128)

; tab:autocomplete if indent is correct
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

(require 'package)
(setq package-archives '(("melpa-stable" . "https://melpa.org/packages/")
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
(require 'use-package)
(setq use-package-always-ensure t)
