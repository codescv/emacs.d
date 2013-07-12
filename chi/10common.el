;; User Interface Settings
(set-language-environment "UTF-8")
;; no startup screen
(setq inhibit-startup-message t)

;; menu
(menu-bar-mode 1)

;; line number and column number
;(require 'wb-line-number)
;(setq wb-line-number-text-width 3)
(column-number-mode t)

;; title name
(defun es-chomp(string)
  (string-match "\\(.*\\)\n$" string)
  (substring string (match-beginning 1) (match-end 1)))

(setq frame-title-format 
      (concat "emacs@" 
	      (es-chomp (shell-command-to-string "hostname"))
	      " eshock - %b"))
;; let mouse pointer move away when it comes near the cursor
(mouse-avoidance-mode 'jump)

;; parenthesis settings
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)
(setq show-paren-delay 0.5)

;; color theme and fonts
(if window-system
    (progn
      ;no toolbar
      (tool-bar-mode -1)
      ;color theme
      ;(eshock-color-theme)
      ;fonts
      (set-default-font "Dejavu Sans Mono Bold 14")
      (set-fontset-font
       "fontset-default" 'chinese-gb2312
       "Microsoft YaHei"
       nil 'prepend)
      (set-fontset-font (frame-parameter nil 'font)
			'han '("Microsoft YaHei" . "unicode-bmp"))))

;; cursor settings
(blink-cursor-mode -1)

;; transient mark
(transient-mark-mode t)

;; font lock
(global-font-lock-mode t)

(setq woman-use-own-frame nil)
(setq visible-bell t)
(display-time)
(set-language-environment 'utf-8)

;; M-y for yes, M-n for no
;(require 'quick-yes)



(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;(require 'screen-lines)
;(autoload 'screen-lines-mode "screen-lines"
;  "Toggle Screen Lines minor mode for the current buffer." t)
;(autoload 'turn-on-screen-lines-mode "screen-lines"
;  "Turn on Screen Lines minor mode for the current buffer." t)
;(global-set-key (kbd "C-c C-s") 'screen-lines-mode)
;; (autoload 'turn-off-screen-lines-mode "screen-lines"
;;   "Turn off Screen Lines minor mode for the current buffer." t)
;(setq-default screen-lines-mode t)
;(setq next-line-add-newlines t)
;(require 'es-change-volume)

;; ido.el
(require 'ido)
(ido-mode t)
(setq-default ido-auto-merge-delay-time 100000)
;(setq diary-file "~/textfiles/diary") 

;; find file recursively
(add-to-list 'load-path (concat user-emacs-directory "chi/plugins"))
(require 'find-recursive)
(add-to-list 'find-recursive-exclude-files ".*pyc$")
