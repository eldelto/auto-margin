(defun auto-margin--buffer? (window)
  (not (string-match-p ".*Minibuf.*" (buffer-name (window-buffer window)))))

(defun auto-margin--non-minibuffer-windows (frame)
  (seq-filter 'auto-margin--buffer? (window-list frame)))

(defun auto-margin--single-window? (frame)
  (= (length (auto-margin--non-minibuffer-windows frame)) 1))

(defun auto-margin--calculate-margin ()
  (/ (- (frame-width) (current-fill-column)) 3))

(defun auto-margin--window (window)
  ;; TODO: Move the single window check up as to not be redundant.
  (if (and (auto-margin--single-window? nil) (auto-margin--buffer? window))
	  (let ((margin (auto-margin--calculate-margin)))
		(set-window-margins window margin margin))
	(set-window-margins window 0)))

(defun auto-margin--reset-margin-frame (frame)
  (dolist (window (window-list frame))
	(set-window-margins window 0)))

(defun auto-margin--frame (frame)
  (dolist (window (window-list frame))
	(auto-margin--window window)))

(defvar auto-margin--mode-enabled nil)

(defun auto-margin--toggle-mode ()
  (setq auto-margin--mode-enabled (not auto-margin--mode-enabled))
  (if auto-margin--mode-enabled
	  (add-hook 'window-buffer-change-functions 'auto-margin--frame)
	(progn
	  (remove-hook 'window-buffer-change-functions 'auto-margin--frame)
	  (auto-margin--reset-margin-frame nil))))

;;;###autoload
(define-minor-mode auto-margin-mode
  "Toggle auto-margin mode.
Automatically adjusts set-widow-margins to center text when only
a single window is displayed."
  :init-value nil
  :lighter " Auto-Margin"
  :global t
  (auto-margin--toggle-mode))

(provide 'auto-margin)

;; TODO: When saving a file via magit the margins get set even though
;; it is not a single window.
