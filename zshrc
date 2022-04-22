# @author     Sebastian Tramp <mail@sebastian.tramp.name>
# @license    http://opensource.org/licenses/gpl-license.php
#
# the main RC file (will be linked to ~/.zshrc)
#

# take tike to measure boot time
bootTimeStart=$(gdate +%s%N 2>/dev/null || date +%s%N)

# first include of the environment
source $HOME/.config/zsh/environment.zsh

typeset -ga sources
sources+="$ZSH_CONFIG/environment.zsh"
sources+="$ZSH_CONFIG/options.zsh"
sources+="$ZSH_CONFIG/prompt.zsh"
sources+="$ZSH_CONFIG/functions.zsh"
sources+="$ZSH_CONFIG/aliases.zsh"

# highlights the live command line
# Cloned From: git://github.com/nicoulaj/zsh-syntax-highlighting.git
sources+="$ZSH_CONFIG/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# provides the package name of a non existing executable
# (sudo apt-get install command-not-found)
sources+="/etc/zsh_command_not_found"

# Check for a system specific file
systemFile=`uname -s | tr "[:upper:]" "[:lower:]"`
sources+="$ZSH_CONFIG/$systemFile.zsh"

# Private aliases and adoptions
sources+="$ZSH_CONFIG/private.zsh"

# completion config needs to be after system and private config
sources+="$ZSH_CONFIG/completion.zsh"

# provides git completion
sources+="$ZSH_CONFIG/git.zsh"

# fasd integration and config
sources+="$ZSH_CONFIG/fasd.zsh"

# fzf integration and config
sources+="$ZSH_CONFIG/fzf.zsh"

# bd - https://github.com/Tarrasch/zsh-bd
sources+="$ZSH_CONFIG/zsh-bd/bd.zsh"

# Private aliases and adoptions added at the very end (e.g. to start byuobu)
sources+="$ZSH_CONFIG/private.final.zsh"

# try to include all sources
foreach file (`echo $sources`)
    if [[ -a $file ]]; then
        # sourceIncludeTimeStart=$(gdate +%s%N)
        source $file
        # sourceIncludeDuration=$((($(gdate +%s%N) - $sourceIncludeTimeStart)/1000000))
        # echo $sourceIncludeDuration ms runtime for $file
    fi
end

bootTimeEnd=$(gdate +%s%N 2>/dev/null || date +%s%N)
bootTimeDuration=$((($bootTimeEnd - $bootTimeStart)/1000000))
echo $bootTimeDuration ms overall boot duration

export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/noah/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/noah/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/noah/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/noah/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

