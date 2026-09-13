# Firefox — Monochrome Dark

Firefox chrome matching the COSMIC monochrome rice. Same layout as Cosmic Night
in the Tokyo Night repo, with lime and blue swapped for gray.

## Palette

| Hex       | Role                      |
|-----------|---------------------------|
| `#111111` | Frame, page chrome        |
| `#1c1c1c` | Panels, menus             |
| `#3a3a3a` | Hover / active row        |
| `#484848` | Separators, menu border   |
| `#828282` | Muted text                |
| `#aaaaaa` | Accent, URL bar border    |
| `#bdbdbd` | Secondary border          |
| `#cccccc` | Body text                 |
| `#dddddd` | Hover text / error        |

## Structure

```
firefox/
├── chrome/
│   ├── userChrome.css    browser UI: rounded corners, solid menu hover
│   └── userContent.css   new tab page: accent colour only
└── install.sh            copies chrome/ into the default profile
```

No WebExtension theme package in this repo. Use Firefox's built-in Dark theme
plus these stylesheets.

## Setup

```bash
./install.sh
```

Copies `chrome/` into your `*.default-release` profile, backs up anything it
replaces, and adds the required pref to `user.js`. Then **fully restart**
Firefox — `userChrome.css` is parsed only at startup.

Manual equivalent:

1. `about:config` → `toolkit.legacyUserProfileCustomizations.stylesheets` = `true`
2. `about:support` → Profile Directory → Open Directory
3. Copy `chrome/` in
4. Restart

To undo: delete the two files and restart, or run the Tokyo Night
`firefox/install.sh` to switch back.

## Notes

- **Never set `--panel-*` or `--arrowpanel-*` on `:root`.** Those variables leak
  into the toolbar and blank the URL bar. They stay on the popup elements.
- **Context menus do not get an extra element border.** A second stroke made
  the right-click panel look detached. Hover is a solid `#3a3a3a` row, not an
  inset ring.
- **`[_moz-menuactive="true"]` is required.** Firefox marks the active
  context-menu row with that attribute, not only `:hover`.
- **`userContent.css` sets colour variables only.** No size or position rules
  on new-tab tiles.
- Built against **Firefox 154**.

## License

MIT, same as the rest of the repo.
