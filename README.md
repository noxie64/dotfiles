# dotfiles
## Quick Intro
Those are not my first dotfiles, to checkout my original ones, go [here](https://github.com/noxie64/dotfiles_24_25).
I would however **NOT** recommend you doing so since those are heavily outdated and not impressiv at all.

## Structure
Im using [Dotbot](https://github.com/anishathalye/dotbot) for easy linking of my files.
I've also somewhat established a decent folder-structure:

- 📂 `config`:
    - 📂 `<program-name>`: folder specific to one application
        - `...`
        - 📂 `conf`: variants of my config, setup through `env`-vars
            - 🎨 `<config-variant>`
- 📁 `desktop`: a collection of useful desktop files
- 📁 `wallpaper`: well, wallpaper(s)
- 💾 `install`: script taken from [Dotbot](https://github.com/anishathalye/dotbot)
- 📄 `install.conf.yaml`: src-to-dst mappings for my conf-files

## Installing
If you were to feel the urge of trying my configs, do it like this:  
```
git clone https://github.com/noxie64/dotfiles.git
cd dotfiles
chmod +x install
./install
```
