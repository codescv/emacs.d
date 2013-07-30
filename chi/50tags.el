(require-package 'etags-table)
(require 'etags-table)
(setq etags-table-alist
      (list
       '(".*duokan_store/.*\\.py$" "/home/chi/.etags.duokan" "/home/chi/.etags.pystd")
       '(".*redis.*/src/.*\\.c$" "/home/chi/.etags.redis" "/home/chi/.etags.std")
       '("/home/chi/sphinx.*-release/.*" "/home/chi/sphinx-2.0.8-release/TAGS")
       '(".*webreader.*" "/home/chi/.etags.epubkit")
       ))
