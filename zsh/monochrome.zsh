# Monochrome zsh layer: colours, aliases, prompt.
#
# Source it at the END of your own ~/.zshrc, after oh-my-zsh.sh:
#   source /path/to/cosmic-monochrome-theme/zsh/monochrome.zsh
#
# Keep machine-specific or private lines (PATH, scaling, nvm, ...) in your
# own ~/.zshrc, not here.
#
#  bg:      #111111   fg:      #828282
#  primary: #aaaaaa   secondary:#a7a7a7
#  border:  #bdbdbd   success: #cccccc
#  error:   #dddddd   dim:     #636363
#
# No hue, so weight and underline do the work colour would.

# ── File colours (ls, lsd file names, completion menu) ─────────────────────────

export LS_COLORS="di=1;38;2;189;189;189:ln=3;38;2;167;167;167:ex=1;38;2;221;221;221:*.zip=4;38;2;204;204;204:*.tar=4;38;2;204;204;204:*.gz=4;38;2;204;204;204:*.xz=4;38;2;204;204;204:*.7z=4;38;2;204;204;204:*.deb=4;38;2;204;204;204:*.png=38;2;130;130;130:*.jpg=38;2;130;130;130:*.jpeg=38;2;130;130;130:*.webp=38;2;130;130;130:*.gif=38;2;130;130;130:*.mp4=3;38;2;130;130;130:*.mkv=3;38;2;130;130;130:*.rs=38;2;221;221;221:*.py=38;2;221;221;221:*.js=38;2;221;221;221:*.ts=38;2;221;221;221:*.sh=38;2;221;221;221:*.md=38;2;204;204;204:*.txt=38;2;204;204;204:or=9;38;2;221;221;221"

# oh-my-zsh reads LS_COLORS before this file loads, so refresh the menu colours
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ── zsh-autosuggestions / zsh-syntax-highlighting ──────────────────────────────

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#636363'

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#aaaaaa'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#aaaaaa'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#aaaaaa'
ZSH_HIGHLIGHT_STYLES[function]='fg=#aaaaaa'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#aaaaaa'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#aaaaaa,underline'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#a7a7a7,underline'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#bdbdbd,bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#dddddd,bold,underline'
ZSH_HIGHLIGHT_STYLES[path]='fg=#828282,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#bdbdbd'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#bdbdbd'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#828282'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#828282'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#cccccc'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#cccccc'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#cccccc'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#828282'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#828282'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#636363'

# ── Aliases (only when the tool is installed) ──────────────────────────────────

if (( $+commands[lsd] )); then
    alias ls='lsd'
    alias la='lsd -a'
    alias ll='lsd -l'
    alias lla='lsd -la'
fi

# Debian/Ubuntu ship bat as batcat
if (( $+commands[batcat] )); then
    alias cat='batcat'
elif (( $+commands[bat] )); then
    alias cat='bat'
fi

(( $+commands[cosmic-edit] )) && alias edit='cosmic-edit'

if (( $+commands[nvim] )); then
    alias vi='nvim'
    alias vim='nvim'
    alias v='nvim'
fi

# ── Prompt ─────────────────────────────────────────────────────────────────────

# needs ZSH_THEME="" in ~/.zshrc
(( $+commands[starship] )) && eval "$(starship init zsh)"
