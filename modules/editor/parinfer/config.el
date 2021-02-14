;;; editor/parinfer/config.el -*- lexical-binding: t; -*-

(if (featurep! +rust)
    (use-package! parinfer-rust-mode
      :hook ((emacs-lisp-mode
              clojure-mode
              scheme-mode
              lisp-mode
              racket-mode
              hy-mode) . parinfer-rust-mode)
      :init
      (setq! parinfer-rust-library (concat user-emacs-directory
                                          ".local/etc/parinfer-rust/"
                                          parinfer-rust--lib-name))
      :config
      (map! :map parinfer-rust-mode-map
            :localleader
            :desc "Switch parinfer-rust-mode" "m" #'parinfer-rust-switch-mode
            :desc "Temporarily disable parinfer-rust-mode" "M"
                  #'parinfer-rust-switch-mode))
  (use-package! parinfer
    :hook ((emacs-lisp-mode
            clojure-mode
            scheme-mode
            lisp-mode
            racket-mode
            hy-mode) . parinfer-mode)
    :init
    (setq parinfer-extensions
          '(defaults
            pretty-parens
            smart-tab
            smart-yank))
    (when (featurep! :editor evil +everywhere)
      (push 'evil parinfer-extensions))
    :config
    (map! :map parinfer-mode-map
          "\"" nil  ; smartparens handles this
          :i "<tab>"     #'parinfer-smart-tab:dwim-right-or-complete
          :i "<backtab>" #'parinfer-smart-tab:dwim-left
          :localleader
          :desc "Toggle parinfer-mode" "m" #'parinfer-toggle-mode)))
