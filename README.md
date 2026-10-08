<div align="center">

# Pop!_OS · COSMIC · Monochrome

<img width="3802" height="2115" alt="githubmono" src="https://github.com/user-attachments/assets/ca22c3a3-0848-43f7-a675-6f079dcc553e" />

Pop!_OS 24.04 on COSMIC in grays only: desktop, terminal, shell, Firefox.

![Pop!_OS](https://img.shields.io/badge/Pop!_OS-24.04_LTS-aaaaaa?style=for-the-badge&logo=popos&logoColor=white)
![COSMIC](https://img.shields.io/badge/COSMIC-1.0.0-bdbdbd?style=for-the-badge)
![Monochrome](https://img.shields.io/badge/Theme-Monochrome_Dark-828282?style=for-the-badge)
![Firefox](https://img.shields.io/badge/Firefox-Monochrome_Dark-cccccc?style=for-the-badge&logo=firefox-browser&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-636363?style=for-the-badge)

</div>

---

## Palette

Sourced from the monochrome dark slots in
[claude-desktop-extra](https://github.com/patrickjaja/claude-desktop-extra/blob/master/themes/palettes/monochrome.svg).

| Role | Color | Hex |
|------|-------|-----|
| Background | ![#111111](https://placehold.co/12x12/111111/111111.png) Void | `#111111` |
| Elevated | ![#1c1c1c](https://placehold.co/12x12/1c1c1c/1c1c1c.png) Surface | `#1c1c1c` |
| Text | ![#828282](https://placehold.co/12x12/828282/828282.png) Mute | `#828282` |
| Primary | ![#aaaaaa](https://placehold.co/12x12/aaaaaa/aaaaaa.png) Accent | `#aaaaaa` |
| Secondary | ![#a7a7a7](https://placehold.co/12x12/a7a7a7/a7a7a7.png) Control | `#a7a7a7` |
| Border | ![#bdbdbd](https://placehold.co/12x12/bdbdbd/bdbdbd.png) Edge | `#bdbdbd` |
| Success | ![#cccccc](https://placehold.co/12x12/cccccc/cccccc.png) High | `#cccccc` |
| Error | ![#dddddd](https://placehold.co/12x12/dddddd/dddddd.png) Higher | `#dddddd` |

There is no hue. Status colours are lighter grays, not green / red.

---

## Repo Structure

```
.
├── btop
│   └── Monochrome.theme         # btop colour theme
├── cosmic
│   ├── Monochrome-Dark.ron      # COSMIC Appearance import
│   ├── config/                  # baseline settings: fonts, icons, terminal look
│   └── install.sh
├── cosmic-term
│   └── Monochrome-Dark-term.ron # COSMIC Terminal colour scheme
├── fastfetch
│   ├── config.jsonc             # gray fastfetch config
│   ├── cosmic.txt               # COSMIC logo
│   └── install.sh
├── firefox
│   ├── chrome
│   │   ├── userChrome.css       # rounded chrome, solid menu hover
│   │   └── userContent.css      # new tab accent
│   ├── install.sh
│   └── README.md
├── lsd
│   ├── config.yaml              # theme: custom
│   ├── colors.yaml              # permission / size / date / git columns
│   └── install.sh
├── scripts
│   └── update_system.sh         # nala + flatpak, monochrome ANSI
├── zsh
│   ├── monochrome.zsh           # LS_COLORS, highlighting colours, aliases, starship
│   └── install.sh
├── LICENSE
└── README.md
```

---

## COSMIC Desktop

Settings → Desktop → Appearance → **Dark** → **Import** → `cosmic/Monochrome-Dark.ron`

Accent tiles will all be gray. That is the theme. Use the `+` control if you want a custom swatch.

Frosted glass is not stored as a look you will notice in the file (`is_frosted: false`). Set it on the Appearance → Style → Frosted glass page after import; those sliders survive a theme switch.

Export from Appearance if you tweak backgrounds / tints so you do not lose them.

### Baseline settings

`cosmic/config/` holds the settings that make up the look and rarely change
(panel, dock, applets and shortcuts are left out on purpose):

| Where | Setting |
|-------|---------|
| Fonts | Interface `Maple Normal UI`, monospace `Maple Mono Normal NFM` |
| Icons | Tela black (dark) |
| Windows | Minimize / maximize buttons hidden, theme applied to GNOME apps |
| Terminal | Maple Mono 15 (weights 500 / bold 800 / dim 300), 77% opacity, no header bar, Monochrome Dark |

Install the [Maple fonts](https://github.com/subframe7536/maple-font) and the
Tela icons (see Icons below) and import the terminal scheme first, then:

```bash
./cosmic/install.sh
```

It backs up each file it replaces to `*.bak` and COSMIC applies it live.

---

## COSMIC Terminal

The desktop `.ron` does not colour ANSI text.

1. COSMIC Terminal → **View → Color schemes…** (not Settings → Appearance)
2. Dark tab → **Import** → `cosmic-term/Monochrome-Dark-term.ron`
3. View → Settings → Appearance → Color scheme (dark) → **Monochrome Dark**

If a profile is set as default, set the scheme on that profile too or the dropdown will look like it did nothing.

---

## Firefox

Built-in Dark theme plus the stylesheets in `firefox/chrome/`.

```bash
./firefox/install.sh
```

Fully quit Firefox afterward. Details and CSS rules: [`firefox/README.md`](firefox/README.md).

---

## Scripts

### `update_system.sh`

nala + flatpak updater. Headers, success, and the figlet ramp are gray.

```bash
chmod +x scripts/update_system.sh
./scripts/update_system.sh
```

---

## Terminal extras

Need a [Nerd Font](https://www.nerdfonts.com/) in the terminal for the icons
(Maple Mono NFM in the baseline above).

### zsh

`zsh/monochrome.zsh` is the rice part of the shell only: `LS_COLORS` (also
used by lsd for file names and by the completion menu), gray colours for
zsh-autosuggestions and zsh-syntax-highlighting, lsd / bat / nvim aliases and
the starship prompt. With no hue, bold / italic / underline tell file types
and errors apart. Your own `~/.zshrc` stays private and sources it.

Needs zsh + [oh-my-zsh](https://ohmyz.sh/). `install.sh` clones the two
plugins if missing and appends one `source` line to `~/.zshrc` (backup in
`~/.zshrc.bak`):

```bash
./zsh/install.sh
exec zsh
```

In `~/.zshrc` keep `ZSH_THEME=""` and
`plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting)`.

### lsd

File names are coloured by `LS_COLORS` from `zsh/monochrome.zsh`;
`lsd/colors.yaml` colours the other columns with the 256-colour grays nearest
the palette (253 `#dddddd`, 252 `#cccccc`, 250 `#bdbdbd`, 248 `#aaaaaa`,
244 `#828282`, 241 `#636363`). lsd 1.0.0 does not accept `#hex` there.

```bash
./lsd/install.sh
lsd -l
```

### fastfetch

COSMIC logo and Hardware / Software / Age boxes in grays. `install.sh` backs
up any existing `~/.config/fastfetch/config.jsonc` to `config.jsonc.bak`.

```bash
./fastfetch/install.sh
fastfetch
```

### btop

`btop/Monochrome.theme`: near-black background, gray boxes, meters ramp from
dim gray to near-white.

```bash
mkdir -p ~/.config/btop/themes
cp btop/Monochrome.theme ~/.config/btop/themes/
# btop → Esc → Options → Color theme → Monochrome
```

---

## Icons and wallpaper

Icons: [Tela](https://github.com/vinceliuice/Tela-icon-theme), black variant:

```bash
git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme && ./install.sh black
# Settings → Desktop → Appearance → Icons → Tela-black-dark
```

Wallpapers: https://github.com/atraxsrc/cool-wallpapers (the gray astronauts in
[`cosmic/`](https://github.com/atraxsrc/cool-wallpapers/tree/main/cosmic) suit this rice)

---

## Setup

```bash
git clone https://github.com/atraxsrc/Pop_OS-Cosmic-Monochrome.git
cd Pop_OS-Cosmic-Monochrome

# desktop
# Settings → Appearance → Dark → Import cosmic/Monochrome-Dark.ron

# terminal
# View → Color schemes → Import cosmic-term/Monochrome-Dark-term.ron

# firefox
./firefox/install.sh

# shell + terminal tools (see Terminal extras above)
./zsh/install.sh
./lsd/install.sh
./fastfetch/install.sh
mkdir -p ~/.config/btop/themes && cp btop/Monochrome.theme ~/.config/btop/themes/

# icons (see Icons above) + Maple fonts (https://github.com/subframe7536/maple-font), then
# fonts, icons, terminal look from cosmic/config/
./cosmic/install.sh
```

---

## Stack

| Tool | What it does |
|------|-------------|
| [Pop!_OS 24.04](https://pop.system76.com/) | Base OS by System76 |
| [COSMIC DE](https://system76.com/cosmic) | Desktop environment |
| [oh-my-zsh](https://ohmyz.sh/) | zsh framework + plugins |
| [lsd](https://github.com/lsd-rs/lsd) | `ls` with icons and colours |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | System info |
| [btop](https://github.com/aristocratos/btop) | Resource monitor |
| [Tela](https://github.com/vinceliuice/Tela-icon-theme) | Icon pack (black) |

## License

MIT
