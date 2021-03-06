(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives 
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default 0)

(setq c-default-style "linux"
      c-basic-offset 4)

(setq-default tab-width 4)

(global-set-key (kbd "C-x C-b") 'ibuffer)
    (autoload 'ibuffer "ibuffer" "List buffers." t)

(dolist (key '("\C-b" "\C-f" "\C-n" "\C-p" "\C-q"))
  (global-unset-key key))

(global-set-key (kbd "C-p") 'undo)

(defun custom-c++-mode-hook ()
  (c-set-offset 'substatement-open 0)
  (setq truncate-lines 0))

(defun execute-c++-program ()
  (interactive)
  (defvar foo)
  (setq foo (concat "clang++ -std=c++14 " (buffer-name) " && ./a.out; rm a.out" ))
  (shell-command foo))


(add-hook 'c++-mode-hook 'custom-c++-mode-hook)

(electric-pair-mode 1)
(electric-indent-mode 1)
(column-number-mode 1)
(smart-tabs-insinuate 'c 'javascript 'c++ )


(global-set-key (kbd "C-x C-a") 'magit-status)

(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'gofmt-before-save)
            (setq tab-width 4)
            (setq indent-tabs-mode 1)
    	    (electric-pair-mode 1)))
 
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(org ox-gfm multiple-cursors ac-clang smart-tabs-mode bison-mode undo-tree rainbow-mode rainbow-delimiters rjsx-mode magit go-autocomplete exec-path-from-shell go-mode auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(ac-config-default)

(require 'multiple-cursors)

(global-set-key (kbd "ESC <down>") 'mc/mark-next-like-this)
(global-set-key (kbd "ESC <up>") 'mc/mark-previous-like-this)

;; Go IDE www
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(setenv "GOPATH" "/Users/hare1039/Documents/gopath")

(defun go-mode-hook-x0 ()                               
      (add-hook 'before-save-hook 'gofmt-before-save)
      ; Godef jump key binding                                                      
      (local-set-key (kbd "M-o") 'godef-jump)
      (local-set-key (kbd "M-p") 'pop-tag-mark)
      (auto-complete-mode 1))
(add-hook 'go-mode-hook 'go-mode-hook-x0)

(with-eval-after-load 'go-mode
  (require 'go-autocomplete))

;; go IDE finish

(eval-after-load "org"
  '(require 'ox-gfm nil t))


;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(require 'golden-ratio)
(golden-ratio-mode 1)

(eval-after-load "gud"
  '(progn
	(local-unset-key (kbd "C-x C-a"))
	(local-set-key (kbd "C-c C-a") 'magit-status)))

(setq dired-listing-switches "-alh")
