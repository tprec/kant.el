;;; kant.el --- Insert dummy text at point
;;; Version:
;;; Package-Requires: ((emacs "24.3"))
;;; Commentary:
;;; URL: https://github.com/tprec/kant.el
;;; Code:

(require 'cl-lib)
(require 'load-relative)

(load-relative "./dict/kant-sentence-dict-EN.el")
(load-relative "./dict/kant-heading-dict-EN.el")

(defun kant-seed-paragraph () 
  (+ 5 (random 20)))

(defun kant-seed-heading () 
  (+ 1 (random 2)))

(defun kant-seed-chapter () 
  (+ 3 (random 10)))

(defun kant-dict-function (a b) 
  (let ((a (nth (random (length b)) b))) 
    (insert (nth (random (length a)) a))))

(defun kant-insert-heading () 
  (interactive) 
  (kant-dict-function "heading" kant-heading))

(defun kant-insert-sentence () 
  (interactive) 
  (kant-dict-function "sentence" kant-sentence))

(defun kant-heading-level (NUM) 
  (interactive "p") 
  (cl-loop repeat NUM do (insert "*")))

(defun kant-insert-heading-at-level () 
  (interactive) 
  (kant-heading-level (kant-seed-heading)) 
  (insert " ") 
  (kant-insert-heading) 
  (newline 2))

(defun kant-paragraph (NUM) 
  (interactive "p") 
  (cl-loop repeat NUM do (kant-insert-sentence) 
           (insert " ")) 
  (newline 2))

(defun kant-insert-paragraph () 
  (interactive) 
  (kant-paragraph (kant-seed-paragraph)))

(defun kant-chapter (NUM) 
  (interactive "p") 
  (kant-insert-heading-level) 
  (cl-loop repeat NUM do (kant-insert-paragraph)))

(defun kant-insert-chapter () 
  (interactive) 
  (kant-chapter (kant-seed-chapter)))

(provide 'kant)

;;; kant.el ends here
