<div align="center">

# Pop!_OS · COSMIC · Monochrome

<img width="3802" height="2115" alt="githubmono" src="https://github.com/user-attachments/assets/ca22c3a3-0848-43f7-a675-6f079dcc553e" />

Sibling rice to [Pop_OS-Cosmic-TokyoNight](https://github.com/atraxsrc/Pop_OS-Cosmic-TokyoNight).
Same machine, same COSMIC desktop, gray accent instead of Tokyo Night blue / Cosmic Night lime.

![Pop!_OS](https://img.shields.io/badge/Pop!_OS-24.04_LTS-aaaaaa?style=for-the-badge&logo=popos&logoColor=white)
![COSMIC](https://img.shields.io/badge/COSMIC-1.0.0-bdbdbd?style=for-the-badge)
![Monochrome](https://img.shields.io/badge/Theme-Monochrome_Dark-828282?style=for-the-badge)
![Firefox](https://img.shields.io/badge/Firefox-Monochrome_Dark-cccccc?style=for-the-badge&logo=firefox-browser&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-636363?style=for-the-badge)

</div>

Keep the Tokyo Night repo. Import this `.ron` and run this Firefox installer when you want the gray look; run the Tokyo Night installer when you want to switch back.

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
├── cosmic
│   └── Monochrome-Dark.ron      # COSMIC Appearance import
├── cosmic-term
│   └── Monochrome-Dark-term.ron # COSMIC Terminal colour scheme
├── firefox
│   ├── chrome
│   │   ├── userChrome.css       # rounded chrome, solid menu hover
│   │   └── userContent.css      # new tab accent
│   ├── install.sh
│   └── README.md
├── scripts
│   └── update_system.sh         # nala + flatpak, monochrome ANSI
├── screenshots
├── LICENSE
└── README.md
```

Dotfiles and fastfetch stay in the Tokyo Night repo. Copy those as-is; they are not palette-specific enough to fork.

---

## COSMIC Desktop

Settings → Desktop → Appearance → **Dark** → **Import** → `cosmic/Monochrome-Dark.ron`

Accent tiles will all be gray. That is the theme. Use the `+` control if you want a custom swatch.

Frosted glass is not stored as a look you will notice in the file (`is_frosted: false`). Set it on the Appearance → Style → Frosted glass page after import; those sliders survive a theme switch.

Export from Appearance if you tweak backgrounds / tints so you do not lose them.

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

Switch back:

```bash
# from the Tokyo Night clone
./firefox/install.sh
```

---

## Scripts

### `update_system.sh`

Same updater as the Tokyo Night repo. Headers, success, and the figlet ramp are gray.

```bash
chmod +x scripts/update_system.sh
./scripts/update_system.sh
```

---

## Icons and wallpaper

Not bundled. Gray / dark packs that work on COSMIC:

- Recolor YAMIS-Cosmic fills from `#ffffff` to `#aaaaaa`
- Tela Circle `grey-dark` / `black-dark`
- kora-pgrey

Wallpapers: https://github.com/atraxsrc/tokyonight-wallpapers

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
```

---

## Switch back to Tokyo Night

1. Appearance → Import the Tokyo Night COSMIC theme (or pick accent colors by hand)
2. Terminal → import the Tokyo Night scheme
3. `../Pop_OS-Cosmic-TokyoNight/firefox/install.sh`

---

## Stack

| Tool | What it does |
|------|-------------|
| [Pop!_OS 24.04](https://pop.system76.com/) | Base OS by System76 |
| [COSMIC DE](https://system76.com/cosmic) | Desktop environment |
| [Pop_OS-Cosmic-TokyoNight](https://github.com/atraxsrc/Pop_OS-Cosmic-TokyoNight) | Color sibling rice |
| This repo | Monochrome accent variant |

## License

MIT
