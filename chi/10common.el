;; customized plugins path
(add-to-list 'load-path (concat user-emacs-directory "chi/plugins"))

;; encoding
(set-language-environment "UTF-8")
;; no startup screen
(setq inhibit-startup-message t)

;; menu
(menu-bar-mode 1)
;; column number
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

;; fonts
(if window-system
    (progn
      ;no toolbar
      (tool-bar-mode -1)
      ;fonts
      (set-default-font "Liberation Mono 14")
      (set-fontset-font
       "fontset-default" 'chinese-gb2312
       "WenQuanYi Zen Hei Sharp"
       nil 'prepend)
      (set-fontset-font (frame-parameter nil 'font)
			'han '("WenQuanYi Zen Hei Sharp" . "unicode-bmp"))))

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

;; ido.el
(require 'ido)
(ido-mode t)
(setq-default ido-auto-merge-delay-time 100000)

;; find file recursively
(require 'find-recursive)
(add-to-list 'find-recursive-exclude-files ".*pyc$")

;; emmet
(require-package 'emmet-mode)
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;indent 2 spaces.

;; ibus-el
(when (require 'ibus nil 'noerror)
  (progn 
    (add-hook 'after-init-hook 'ibus-mode-on)
    ;; Use S-SPC for Set Mark command
    (ibus-define-common-key ?\S-\s nil)
    ;; Use C-/ for Undo command
    (ibus-define-common-key ?\C-/ nil)
    ;; ignore some annoying bindings
    (ibus-define-common-key (kbd "<f5>") nil)
    (ibus-define-common-key (kbd "<f6>") nil)
    (ibus-define-common-key (kbd "<f7>") nil)
    (ibus-define-common-key (kbd "<f8>") nil)
    (ibus-define-common-key (kbd "<f9>") nil)
    (ibus-define-common-key (kbd "<f10>") nil)
    (ibus-define-common-key (kbd "<f11>") nil)
    (ibus-define-common-key (kbd "<f12>") nil)
    ;; Change cursor color depending on IBus status
    (setq ibus-cursor-color '("blue" "red" "limegreen"))
    (global-set-key (kbd "C-SPC") 'ibus-toggle)))

;; jslint

(setq flymake-jslint-command (concat (getenv "HOME") "/.nodejs/lib/node_modules/jslint/bin/jslint.js"))

;; pyflake
(setq flymake-python-pyflakes-executable (concat (getenv "HOME") "/dk-pyenv/bin/pyflakes"))

(custom-set-faces '(flymake-errline
                    ((((class color))
                      (:background "Red" :foreground "Black"))))
                  '(flymake-warnline
                    ((((class color))
                      (:background "Yellow" :foreground "Black"))))
                  '(js2-external-variable
                    ((((class color))
                      (:foreground "Red" :underline t)))))

;; misc bindings
(global-set-key (kbd "<f4>") 'kill-buffer)
(global-set-key (kbd "<f5>") 'flymake-display-err-menu-for-current-line)
(global-set-key (kbd "<f6>") 'flymake-goto-next-error)
(global-set-key (kbd "<f11>") 'magit-status)
(global-set-key (kbd "<f12>") 'magit-log)

(global-set-key (kbd "C-S-v") 'scroll-other-window)
(global-set-key (kbd "M-V") 'scroll-other-window-down)
(global-set-key (kbd "C-x nb") 'rename-buffer)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "S-SPC") 'set-mark-command)
(global-set-key (kbd "C-S-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-S-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-%") 'query-replace-regexp)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-M-h") 'backward-kill-sentence)
(global-set-key (kbd "C-x C-u") 'undo)
(global-set-key (kbd "C-x C-k") 'kill-buffer)
