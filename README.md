# Auto-Margin

A global minor-mode to automatically center text when using a single
buffer.

![Demo GIF](./media/demo.gif?raw=true "Demo GIF")

## Getting Started

Auto-Margin is currently not available on MELPA but can be installed
directly from source via ~use-package~ (requires Emacs >= 30.0):

```elisp
(use-package auto-margin
  :vc (:url "https://github.com/eldelto/auto-margin"
            :branch "main")
  :ensure t)
```

Otherwise you can clone this repository and load it manually:

```elisp
(use-package auto-margin
  :load-path "<path-to-repository>"
  :commands auto-margin-mode)
```

The minor-mode can be enabled temporarily by calling `M-x
auto-margin-mode`or permanently by adding `(auto-margin-mode 1)` to
your init file.

## Configuration

As this plugin modifies the width of windows your window splitting
behaviour may change and you might need to fiddle with your
`split-width-threshold` setting to restore your desired behaviour.

Customization groups coming soon...
