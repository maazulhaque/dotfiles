# Vars
	HISTFILE=~/.zsh_history
	SAVEHIST=1000
	setopt inc_append_history # To save every command before it is executed
	setopt share_history # setopt inc_append_history

	git config --global push.default current

# Aliases
	alias v="vim -p"
	alias ll="ls -lart"
	mkdir -p /tmp/log

	# This is currently causing problems (fails when you run it anywhere that isn't a git project's root directory)
	# alias vs="v `git status --porcelain | sed -ne 's/^ M //p'`"

# Settings
	export VISUAL=vim

source ~/dotfiles/zsh/plugins/fixls.zsh

#Functions
	# Loop a command and show the output in vim
	loop() {
		echo ":cq to quit\n" > /tmp/log/output
		fc -ln -1 > /tmp/log/program
		while true; do
			cat /tmp/log/program >> /tmp/log/output ;
			$(cat /tmp/log/program) |& tee -a /tmp/log/output ;
			echo '\n' >> /tmp/log/output
			vim + /tmp/log/output || break;
			rm -rf /tmp/log/output
		done;
	}

# Custom cd
# chpwd() ls
ZSH_THEME="agnoster"

# For vim mappings:
	stty -ixon

# Completions
# These are all the plugin options available: https://github.com/robbyrussell/oh-my-zsh/tree/291e96dcd034750fbe7473482508c08833b168e3/plugins
#
# Edit the array below, or relocate it to ~/.zshrc before anything is sourced
# For help create an issue at github.com/parth/dotfiles

autoload -U compinit

export PATH=$PATH:$HOME/dotfiles/utils
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/local/bin:/opt/local/sbin"
export PATH="/usr/local/sbin:$PATH"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:$HOME/.rvm/bin:/Applications/Postgres.app/Contents/Versions/latest/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn


plugins=(
	sublime
  zsh-syntax-highlighting
  zsh-autosuggestions
  git
)

# source ~/dostfiles/zsh/plugins/oh-my-zsh/tools/install.sh
for plugin ($plugins); do
		# echo $fpath
  fpath=(~/dotfiles/zsh/plugins/oh-my-zsh/plugins/$plugin $fpath)
  if [ -f ~/dotfiles/zsh/plugins/oh-my-zsh/plugins/$plugin/$plugin.plugin.zsh ]; then
    source ~/dotfiles/zsh/plugins/oh-my-zsh/plugins/$plugin/$plugin.plugin.zsh
  elif [ -f ~/dotfiles/zsh/plugins/oh-my-zsh/custom/plugins/$plugin/$plugin.plugin.zsh ]; then
    source ~/dotfiles/zsh/plugins/oh-my-zsh/custom/plugins/$plugin/$plugin.plugin.zsh
  fi
    # echo $fpath
done
# source $fpath
compinit


export EDITOR=sublime




source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/history.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/key-bindings.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/completion.zsh
source ~/dotfiles/zsh/plugins/vi-mode.plugin.zsh
source ~/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/keybindings.sh
# source ~/dotfiles/zsh/plugins/oh-my-zsh/oh-my-zsh.sh
# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

source ~/dotfiles/zsh/prompt.sh

