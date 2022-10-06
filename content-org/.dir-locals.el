((org-mode . ((eval . (org-hugo-auto-export-mode))
              (eval . (let ((base-path (file-name-directory
                                        (directory-file-name
                                         (let ((d (dir-locals-find-file "./")))
                                           (if (stringp d) d (car d)))))))
                        (setq-local org-hugo-base-dir base-path)))
              )))
