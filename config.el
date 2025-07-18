;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


(setq doom-font (font-spec :family "Iosevka" :size 15 :weight 'regular))

(setq doom-theme 'doom-ayu-dark)


(use-package! smartparens-mode
  :ensure smartparens  ;; install the package
  :hook (prog-mode text-mode markdown-mode typescript-mode) ;; add `smartparens-mode` to these hooks
  :config
  ;; load default config
  (require 'smartparens-config))

(use-package! typescript-mode
  )

(use-package! go-mode
  )


(use-package! nginx-mode)

;; (use-package! apheleia
;;   :init
;;   (apheleia-global-mode +1)

;;   (map! "<f10>" 'apheleia-format-buffer)
;;   :config

;;   (set-formatter!

;;    'typescript-formatter
;;    '("prettier" "--stdin-filepath" filepath)
;;    :modes '(typescript-mode))
;;   (set-formatter!
;;    'clojure-formatter
;;    '("cljfmt" "fix" filepath)
;;    :modes '(clojure-mode)
;;    )
;;   )

;; accept completion from copilot and fallback to company
;; (use-package! copilot
;;   :hook (prog-mode . copilot-mode)
;;   (yaml-mode . copilot-mode)
;;   (markdown-mode . copilot-mode)
;;   (web-mode . copilot-mode)
;;   :bind (:map copilot-completion-map
;;               ("<tab>" . 'copilot-accept-completion)
;;               ("TAB" . 'copilot-accept-completion)
;;               ("C-TAB" . 'copilot-accept-completion-by-word)
;;               ("C-<tab>" . 'copilot-accept-completion-by-word)))


(use-package! python-mode
  )

(use-package! origami
  :config
  (global-origami-mode)
  )

(use-package! tree-sitter
  :config
  (global-tree-sitter-mode)
  )

(use-package! ts-fold
  :config
  (global-ts-fold-mode)
  :hook
  (typescript-mode . ts-fold-mode)
  :bind
  (("C-'" . ts-fold-toggle)
   )
  )
(use-package! yaml-mode
  :hook
  (yaml-mode . (lambda () (apheleia-mode -1)))
  )

(use-package! projectile
  :init
  (setq projectile-indexing-method 'alien)
  (setq projectile-enable-caching nil)
  )

(use-package! move-text
  :init
  (move-text-default-bindings)
  )

(use-package! format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :init
  (map! "<f10>" 'format-all-buffer)
  :config
  (setq-default format-all-formatters
                '(("C"     (astyle "--mode=c"))
                  ("Shell" (shfmt "-i" "4" "-ci"))
                  ("Clojure" (zprint))
                  ("Typescript" (prettier))
                  ("TSX" (prettier))
                  ("JSX" (prettier))
                  ("JSON" (prettier))
                  ("YAML" (prettier))
                  ("Markdown" (prettier))
                  ("CSS" (prettier))
                  ("JavaScript" (prettier))
                  ("Python" (yapf))
                  ("Go" (gofmt))
                  ("Java" (google-java-format))
                  )))

(use-package! json-mode
  :init
  (setq js-indent-level 2)
  )

(use-package! web-mode
  :init
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  )

(use-package! typescript-mode
  :init
  (setq typescript-indent-level 2)
  )

(use-package! flycheck-clj-kondo

  )

(use-package! clojure-mode
  :config
  (require 'flycheck-clj-kondo)
  )

;; (use-package! lsp-treemacs
;;   :init
;;   ;; (lsp-treemacs-sync-mode 1)
;;   )
;; (use-package! emmet-mode
;;   :hook
;;   (web-mode . emmet-mode)
;;   (html-mode . emmet-mode)
;;   (css-mode . emmet-mode)
;;   (typescript-mode . emmet-mode)
;;   (emmet-mode . emmet-preview-mode)
;;   )

(use-package! yaml-mode
  )

;; (use-package! lsp-bridge
;;   :config
;;   (global-lsp-bridge-mode))

;; (setq insert-default-directory nil)
