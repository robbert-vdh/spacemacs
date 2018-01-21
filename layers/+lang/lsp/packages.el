;;; packages.el --- lsp layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Robbert van der Helm <mail@robbertvanderhelm.nl>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq lsp-packages
  '(company-lsp
    lsp-mode
    ;; lsp-ui
    (helm-xref :requires helm)
    (ivy-xref :requires ivy)
    (lsp-rust :requires rust-mode)
    (racer :excluded t)
    ))

(defun lsp/init-company-lsp ()
  (use-package company-lsp
    :defer t
    :init
    (progn
      (setq company-lsp-async t)
      (spacemacs|add-company-backends
        :backends company-lsp
        :modes lsp-mode))))

(defun lsp/init-lsp-mode ()
  (use-package lsp-mode
    :defer t
    :init
    (progn
      (setq lsp-highlight-symbol-at-point nil)
      (spacemacs/set-leader-keys-for-minor-mode 'lsp-mode
        "gh" 'lsp-symbol-highlight
        "ra" 'lsp-apply-commands
        "rr" 'lsp-rename))))

;; (defun lsp/init-lsp-ui ()
;;   (use-package lsp-ui
;;     :defer t
;;     :commands (lsp-ui-mode)
;;     :init (add-hook 'lsp-mode-hook 'lsp-ui-mode)))

(defun lsp/init-helm-xref ()
  (use-package helm-xref
    :defer t
    :config
    ;; This is required to make xref-find-references not give a prompt.
    ;; xref-find-references asks the identifier (which has no text property) and then passes it to lsp-mode, which requires the text property at point to locate the references.
    ;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=29619
    (setq xref-prompt-for-identifier
          '(not xref-find-definitions xref-find-definitions-other-window xref-find-definitions-other-frame xref-find-references spacemacs/jump-to-definition))

    ;; Use helm-xref to display xref.el results.
    (setq xref-show-xrefs-function 'helm-xref-show-xrefs)))

(defun lsp/init-ivy-xref ()
  (use-package ivy-xref
    :defer t
    :config
    (setq xref-prompt-for-identifier
          '(not xref-find-definitions xref-find-definitions-other-window xref-find-definitions-other-frame xref-find-references spacemacs/jump-to-definition))

    ;; Use ivy-xref to display xref.el results.
    (setq xref-show-xrefs-function 'ivy-xref-show-xrefs)))

(defun lsp/init-lsp-rust ()
  (use-package lsp-rust
    :defer t
    :commands (lsp-rust-enable)
    :config (setq lsp-rust-rls-command '("rls"))
    :init (add-hook 'rust-mode-local-vars-hook 'lsp-rust-enable)))
