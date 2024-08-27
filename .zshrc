
export TRANSFORMERS_CACHE=/Volumes/models/ai
export TORCH_TMPDIR=/Volumes/models/ai
export OPENAI_API_KEY=''
export HF_HOME=/Volumes/models/ai
export HF_DATASETS_DOWNLOADED_DATASETS_PATH=/Volumes/models/ai
export HF_TOKEN=''
export gemini_token=''
export GOOGLE_API_KEY=''
export PYTHONPATH=$(pwd)
export PKG_CONFIG_PATH=/Users/leonardlangsdorf/dev/packages
export ANTHROPIC_API_KEY=''



# Aliases
alias vim=nvim
alias python=python3
# Alias ls to eza with common ls options
alias ls='eza --icons'

# Optional: Alias common ls flags to eza equivalents
alias ll='eza -l --icons'    # Long listing format
alias la='eza -la --icons'   # Show hidden files
alias l='eza -l --icons'     # Shorter alias for long listing
# Alias for 'ls -lat'
alias ls-lat='eza -la --sort=modified --icons'

# Alias for 'ls -lst'
alias ls-lst='eza -la --sort=size --icons'


# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."


# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

## autocomplete
if [[ ! -o interactive ]]; then
    return
fi

compctl -K _jina jina

_jina() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(jina commands)"
  else
    completions="$(jina completions ${words[2,-2]})"
  fi

  reply=(${(ps:
:)completions})
}

# session-wise fix
ulimit -n 4096
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# JINA_CLI_END

eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh
# YAZI END
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}



# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"


export BAT_THEME=nightfox



# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

eval "$(starship init zsh)"

