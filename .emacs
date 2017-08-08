;;; Commentary:
;; Davis's emacs configuration file
;;;

;;;;;;;;
;; Set up for MELPA installation of packages
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)
;; set load path
(setq load-path
      (append '("/homes/davis/.emacs.d" "/homes/davis/.emacs.d/polymode/"  "/homes/davis/.emacs.d/polymode/modes")
              load-path))

;; disable lock files
(setq create-lockfiles nil) 

;;;;;;;
;; Fix meta key to work with X Windows
(setq x-alt-keysym 'meta)
(setq x-super-keysym 'meta)

;;;;;;;
;; Convenient switching between windows/frames
(global-set-key (kbd "M-\\") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;;;;;;;
;; show system-name and full path of buffer in emacs window
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
        '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;;;;;;;
;; autocomplete
(require 'auto-complete)
(global-auto-complete-mode t)

;;;;;;;;
;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
;; for python
(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(require 'flycheck-pyflakes)
(add-hook 'python-mode-hook 'flycheck-mode)

;;;;;;;;
;; flyspell lazy
(require 'flyspell-lazy)
(flyspell-lazy-mode 1)
(flyspell-mode 1)      ; or (flyspell-prog-mode)

;; Set up ESS
(add-to-list 'load-path "/homes/davis/software/ESS")
(load "ess-site")

;;;;;;;;
;; Set up nice line numbering
(unless window-system
  (add-hook 'nlinum-before-numbering-hook
	    (lambda ()
	      (setq-local nlinum-format-fmt
			  (let ((w (length (number-to-string
					    (count-lines (point-min) (point-max))))))
			    (concat "%" (number-to-string w) "d"))))))

(defun linum-format-func (line)
  (concat
   (propertize (format nlinum-format-fmt line) 'face 'nlinum)
   (propertize " " 'face 'mode-line)))

(unless window-system
  (setq linum-format 'nlinum-format-func))

(setq nlinum-format "%d ")
;; (setq linum-format "%4d \u2502 ")

;;;;;;;;
;; Column marker
(require 'column-marker)
;; Highlight column 80 in foo mode:
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-3 80)))
(add-hook 'r-mode-hook (lambda () (interactive) (column-marker-3 80)))
(add-hook 'ess-mode-hook (lambda () (interactive) (column-marker-3 80)))
;; Use ‘C-c m’ interactively to highlight with ‘column-marker-3-face’:
(global-set-key [?\C-c ?m] 'column-marker-3)

;;;;;;;;
;; Highlight current line
;; Load this file (it will load `hl-line.el')
(require 'hl-line+)
;; To turn on `global-hl-line-mode' only when Emacs is idle, by
;; default, add this line also to your init file:
(toggle-hl-line-when-idle 1) ; Highlight only when idle

;;;;;;;;
;; Use sexy solarized theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
;; (load-theme 'solarized-light t)
;(load-theme 'solarized-dark t)

;;;;;;;;
;; Load package for color themes
(add-to-list 'load-path "~/.emacs.d/snakemake-mode-20160612.2126/")

;; Markdown Mode
;; obtain from http://jblevins.org/projects/markdown-mode/
(autoload 'markdown-mode "markdown-mode-2.2"
  "Major mode for editing Markdown files" t)
;; There is no official Markdown file extension, nor is there even a de facto standard, so you can easily add, change, or remove any of the file extensions above as needed.
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;; Git-flavoured markdown
(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
   
;; Set up polymode for ESS and Markdown
;; obtain from https://github.com/vitoshka/polymode
(setq load-path
      (append '("~/.emacs.d/polymode/"  "~/.emacs.d/polymode/modes")
              load-path))
(require 'poly-R)
(require 'poly-markdown)
;; ;; MARKDOWN
;;  (add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode)) 
;; ;; ORG
;; (add-to-list 'auto-mode-alist '("\\.org" . poly-org-mode))
;; ;; R related modes
;; (add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
;; (add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
;; (add-to-list 'auto-mode-alist '("\\.Rmd\\'" . poly-markdown+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))
;; (add-to-list 'auto-mode-alist '("\\.rapport" . poly-rapport-mode))
;; (add-to-list 'auto-mode-alist '("\\.Rhtml" . poly-html+r-mode))
;; (add-to-list 'auto-mode-alist '("\\.Rbrew" . poly-brew+r-mode))
;; (add-to-list 'auto-mode-alist '("\\.Rcpp" . poly-r+c++-mode))
;; (add-to-list 'auto-mode-alist '("\\.cppR" . poly-c++r-mode))

;; (provide 'polymode-configuration)


;; Use auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)
;; To use auto-complete with python-mode, just prepend the following lines:
(ac-flyspell-workaround)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)


;; Load python-mode
(setq py-install-directory "~/.emacs.d/python-mode")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)
;; To enable code completion
(setq py-load-pymacs-p t)


;;;;;;;;
;; Rope and ropemacs
;;  (setq pymacs-load-path '("/Users/davismcc/Software/python/rope-0.9.4"
;;			  "/Users/davismcc/Software/python/ropemacs-0.7"))
;; Function for lazy loading of ropemacs
;; (defun load-pymode ()
;;   "Load python programming mode from init_python.el"
;;     (interactive)
;; 					;(require 'pymacs)
;; 					;(pymacs-load "ropemacs" "rope-")
;;     ;; Load the python initialisation script in ~/.emacs.d/init_python.el
;;     (load-library "init_python") 
;;     ;; Automatically save project python buffers before refactorings
;;     (setq ropemacs-confirm-saving 'nil)
;;     )
;; (global-set-key "\C-xpl" 'load-ropemacs)
;; And execute ``load-ropemacs`` (or use ``C-x p l``) whenever you want to use ropemacs.

;;;;;;;;;
;; Add things for AUCTex
;;(add-to-list 'load-path "~/.emacs.d/auctex-11.87/")
;; (add-to-list 'load-path "~/.emacs.d/auctex-11.87/preview/preview-latex.el")
;;(setenv "PATH" (concat "/usr/texbin:/usr/local/bin:" (getenv "PATH")))
;;(setq exec-path (append '("/usr/texbin" "/usr/local/bin") exec-path))
;;(load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t) ; Not currently working
;; (setq-default TeX-master nil)
;; (setq TeX-parse-self t)
;; (setq TeX-auto-save t)


;;;;;;;;;;
;; Add el-get stuff
;; (add-to-list 'load-path "~/.emacs.d/el-get")

;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))

;; (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; (el-get 'sync)

;;;;;;;;;
;; Emacs IPython Notebook
;; (require 'ein)

;;;;;;;;;
;; Emacs Tiny Tools
;; (add-to-list 'load-path
;; 	     "~/.emacs.d/emacs-tiny-tools/lisp/tiny")
;; (add-to-list 'load-path
;; 	     "~/.emacs.d/emacs-tiny-tools/lisp/other")
;; Initialise code folding
;; (load "folding" 'nomessage 'noerror)
;; (folding-mode-add-find-file-hook)
;; Add some code folding syntax
;; (folding-add-to-marks-list 'r-mode "#{{{" "#}}}" nil t)
;; (folding-add-to-marks-list 'ess-mode "#{{{" "#}}}" nil t)
;; (folding-add-to-marks-list 'python-mode "#{{{" "#}}}" nil t)
;; (folding-add-to-marks-list 'latex-mode "%{{{" "%}}}" nil t)

;;;;;;;;;;
;; font-locking
;; (cond ((null window-system))
;;       ((fboundp 'global-font-lock-mode)
;;        (setq font-lock-maximum-decoration t)
;;        (global-font-lock-mode t)
;;        (if (load "lazy-lock" t)
;; 	   (add-hook 'font-lock-mode-hook 'turn-on-lazy-lock))))

;; (if (eq window-system 'x)
;;     (require 'font-latex))

;; Highlight selected area
;; (if (fboundp 'transient-mark-mode)
;;     (transient-mark-mode 1))
;; and highlight matching parentheses
;; (require 'paren)
;; (show-paren-mode t)

;; Go to the matching parenthesis when you press
;; % if on parenthesis otherwise insert %
(defun goto-matching-paren-or-insert (arg)
(interactive "p")
(cond ((looking-at "[([{]") (forward-sexp 1) (backward-char))
      ((looking-at "[])}]") (forward-char) (backward-sexp 1))
       (t (self-insert-command (or arg 1)))))
(global-set-key "%" 'goto-matching-paren-or-insert)

;;visual bell instead of annoying beep
(setq visible-bell t)

;; Prevent Emacs from extending file when
;; pressing down arrow at end of buffer.
;(setq next-line-add-newlines nil)
;; Silently ensure newline at end of file
;; (setq require-final-newline t)
;; or make Emacs ask about missing newline
(setq require-final-newline 'ask)

;; next line makes C-x C-j do a 'goto-line'
(global-set-key "\C-x\C-j" 'goto-line)

;; change save interval from 300 to 1000
;; keystrokes so it isn't so annoying
(setq auto-save-interval 500)

;; Define a search for duplicate words and bind it to F5 key
;; Handy for for spotting errors like this this!
(defun search-duplicates ()
  "Search for two duplicate words in buffer."
  (interactive)
  (search-forward-regexp "\\(\\b\\w+\\b\\)[ \t\n]+\\b\\1\\b"))
(global-set-key [f5] 'search-duplicates)

;; Define a count of the number of words in a highlighted region and bind to F6
;; Handy for forms with word limits and titles with character limits
(defun word-count (start end)
  (interactive "r")
  (let ((words 0) (lines 0) (chars 0))
    (save-excursion
      (goto-char start)
      (while (< (point) end) (forward-word 1) (setq words (1+ words))))
    (setq lines (count-lines start end) chars (- end start))
    (message "Region has  %d lines;   %d words;   %d characters."
             lines words chars)))
(global-set-key [f6] 'word-count)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-solarized-light)))
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default)))
 '(inferior-R-program-name "/nfs/software/stegle/system/linuxbrew/bin/R"))

;;; .emacs ends here...
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; snake-mode
(add-to-list 'auto-mode-alist '("Snakefile" . snake-mode))

(defun snake-tab ()
  (interactive)
  (insert "    ")) ; four spaces

(define-minor-mode snake-mode
  "Snakemake."
  :lighter " snake-make"
     (python-mode)
     (setq indent-line-function 'snake-tab)
)

; end snake-mode
