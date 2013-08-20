fpath=($ZSH/functions $ZSH/completions $fpath)

for config_file ($ZSH/lib/*.zsh); do
  source $config_file
done

is_plugin() {
  local base_dir=$1
  local name=$2
  test -f $base_dir/plugins/$name/$name.plugin.zsh \
    || test -f $base_dir/plugins/$name/_$name
}

# Add all defined plugins to fpath. This must be done
# before running compinit.
for plugin ($plugins); do
  is_plugin $ZSH $plugin && fpath=($ZSH/plugins/$plugin $fpath)
done

# Load and run compinit
autoload -U compinit
compinit -i


# Load all of the plugins that were defined in ~/.zshrc
for plugin ($plugins); do
  [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ] && source $ZSH/plugins/$plugin/$plugin.plugin.zsh
done

[ -n "$ZSH_THEME" ] && source "$ZSH/themes/$ZSH_THEME.zsh-theme"
