;;; packages.el --- ghosttext layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Robbert van der Helm <mail@robbertvanderhelm.nl>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst ghosttext-packages '(atomic-chrome))

(defun ghosttext/init-atomic-chrome ()
  (use-package atomic-chrome
    :defer t
    :if (or (daemonp) ghostscript-run-always)
    :config (setq atomic-chrome-buffer-open-style 'frame
                  atomic-chrome-buffer-frame-width 100)
    :init
    (progn
      (atomic-chrome-start-server)
      (spacemacs/set-leader-keys-for-minor-mode 'atomic-chrome-edit-mode
        dotspacemacs-major-mode-leader-key 'atomic-chrome-close-current-buffer
        "c" 'atomic-chrome-close-current-buffer
        "s" 'atomic-chrome-send-buffer-text))))
