;; -*- no-byte-compile: t; -*-
;;; editor/parinfer/packages.el

(when (and (not (featurep! +rust)) (featurep! :editor evil))
  ;; Parinfer uses `evil-define-key' without loading evil, so if evil is
  ;; installed *after* parinfer, parinfer will throw up void-function errors.
  ;; because evil-define-key (a macro) wasn't expanded at compile-time. So we
  ;; make sure evil is installed before parinfer...
  (package! evil)
  ;; ...and that it can see `evil-define-key' if evil was installed in a
  ;; separate session:
  (autoload 'evil-define-key "evil-core" nil nil 'macro))

(if (featurep! +rust)
    (package! parinfer-rust-mode :pin "67eed38129c28f087c0b5dffe8a790978d41a8c1")
  (package! parinfer :pin "8659c99a9475ee34af683fdf8f272728c6bebb3a"))
