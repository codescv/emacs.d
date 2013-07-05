;; load dired
(require 'dired)
(require-package 'dired-single)
(require 'dired-single)	  
(load "dired-x")

;; dired Settings

(add-hook 'dired-mode-hook
	  (lambda ()
	    (setq dired-omit-files "^#\\|^\\..*") ; omit all hidden file which starts with `.'
	    (dired-omit-mode 1)
	    (define-key dired-mode-map (kbd "a") 'dired-single-buffer)
	    (define-key dired-mode-map (kbd "<mouse-1>") 'dired-single-buffer-mouse)
	    (define-key dired-mode-map (kbd "/")
	      (lambda ()
		(interactive)
		(dired-single-buffer "..")))
	    (setq dired-single-use-magic-buffer t)
	    (setq dired-single-magic-buffer-name "*dired*")))

;;(global-set-key (kbd "C-x C-j") 'dired-jump)
(setq dired-guess-shell-alist-user
      '( ("\\.p[bgpn]m$" "feh * &")
	 ("\\.gif$" "feh * &")
	 ("\\.tif$" "feh * &")
	 ("\\.png$" "feh * &")
	 ("\\.jpe?g$" "feh * &")
	 ("\\.djvu" "djview * &")
	 ("\\.mp3$\\|\\.wma$\\|\\.avi$\\|\\.mp4$\\|\\.ogg$" "mplayer * &")
	 ("\\.pdf$" "wine \'/mnt/c/Program Files/PDF Viewer/PDFXCview.exe\' * &")
;;	 ("\\.pdf$" "xpdf -aa yes -papercolor grey -z 200 * &")
	 ("\\.flv$" "mplayer * &")
	 ("\\.rm$\\|\\.rmvb$" "mplayer * &")
	 ("\\.rar$" "unrar x * &")
	 ("\\.torrent$" "bitstormlite * &")
	 ("\\.doc$" "openoffice * &")
	 ("\\.ppt$" "openoffice * &")
	 ("\\.chm$" "chmsee * &")))
(setq dired-omit-extensions 
      '(".svn/" "CVS/" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".fasl" ".ufsl" ".fsl" ".dxl" ".pfsl" ".dfsl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo" ".idx" ".lof" ".lot" ".glo" ".blg" ".bbl" ".cp" ".cps" ".fn" ".fns" ".ky" ".kys" ".pg" ".pgs" ".tp" ".tps" ".vr" ".vrs"))

;; a way to discard the output of a program. by pluskid
(defadvice dired-run-shell-command (around kid-dired-run-shell-command (command))
  "run a shell command COMMAND .
If the COMMAND matches with the constant es-dired-discard-output-regexp then run it in background and *discard* the output, otherwise simply let the original `dired-run-shell-command' run it."
  (if (string-match "&[[:blank:]]*$" command)
      (let ((proc (start-process-shell-command "*kid-shell*" nil
					       (substring command 0 (match-beginning 0)))))
	(set-process-sentinel proc 'shell-command-sentinel))
    ad-do-it))   ;;ad-do-it is a keyword standing for the original function.
(ad-activate 'dired-run-shell-command)

(defun es-dired-magic()
  "If the buffer already exists, jump to it, elsewise create a new one with the starting
directory ~."
  (interactive)
  (if (buffer-live-p (get-buffer "*dired*"))
      (dired-single-magic-buffer)
    (dired-single-magic-buffer "~")))




(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

(defun es-dired-ediff()
  "mark the files to be compared, then run this command to compare them."
  (interactive)
  (setq b)
  (dired-map-over-marks (setq b (cons b (dired-get-filename))) nil)
  (let* ((first-file (cdr b))
	 (second-file (cdr (car b)))
	 (third-file (cdr (car (car b))))
	 (compare-type (file-directory-p first-file)))
    (if (not compare-type)
	(if third-file
	    (ediff3 first-file second-file third-file nil)
	  (if second-file
	      (ediff first-file second-file nil)
	    (if first-file
		(call-interactively 'dired-diff)
	      (error "No marked file(s)"))))
      (if third-file
	  (ediff-directories3 first-file second-file third-file nil)
	(if second-file
	    (ediff-directories first-file second-file nil)
	  (if first-file
	      (call-interactively 'dired-diff)
	    (error "No marked file(s)")))))))



(define-key dired-mode-map (kbd "=") 'es-dired-ediff)

(defun es-dired-unpack-chm ()
  "Unpack the chm file to the temp directory, named after the original file."
  (interactive)
  (let* ((file (dired-get-filename))
	 (target-dir (progn
		       (string-match ".*\\/\\(.*\\)\\.chm$" file)
		       (substring file (match-beginning 1) (match-end 1)))))
    (shell-command (concat "archmage " 
    			   file 
    			   " ~/temp/"
    			   target-dir))))

(define-key dired-mode-map (kbd "c") 'es-dired-unpack-chm)
(define-key dired-mode-map (kbd "<return>") 'dired-do-shell-command)
(define-key dired-mode-map (kbd "E") 'emms-add-dired)
(global-set-key (kbd "C-x d") 'es-dired-magic)
;; Open a dired session with a superuser propriety
(global-set-key (kbd "C-x C-d") 
		(lambda ()
		  (interactive)
		  (dired-single-magic-buffer "/su::/etc")))
