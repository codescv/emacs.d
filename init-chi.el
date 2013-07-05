(mapc #'(lambda (file)
         (load (file-name-sans-extension file)))
      (directory-files (concat user-emacs-directory "chi") t "\\.el$"))

(provide 'init-chi)
