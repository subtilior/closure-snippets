;;; -*- lexical-binding: t -*-
(defun get-current-provide-string ()
  "Returns the name of the first provided package in the current buffer, or nil if not found."
  (save-excursion
    (beginning-of-buffer)
    (when (re-search-forward "goog\.\\(module\\|provide\\) *( *[\"']\\([A-Za-z0-9.]+\\)[\"'] *)" nil t)
      (let ((keyword (match-string-no-properties 1))
            (package-name (match-string-no-properties 2)))
        ;; For goog.module, if the module name is namespaced using periods, the
        ;; assumption is that the module exports the symbol whose name matches
        ;; the substring after the last period.
        (if (string= keyword "module")
            (substring package-name (string-match "\\([A-Za-z0-9]+\\)$" package-name))
          package-name)))))

(provide 'closure-snippets-support)
