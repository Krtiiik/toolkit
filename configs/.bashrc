# Color GIT prompt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT_COMMAND='git_branch=$(git branch --show-current 2>/dev/null);git_lpar=""; git_rpar="";if [[ -n "$git_branch" ]]; then
    git_lpar="("
    git_rpar=")"
fi'
PS1='\[\e[92m\]\u\[\e[36m\]@\[\e[92m\]\H\[\e[36m\]:\[\e[96m\]\w\[\e[36m\]${git_lpar}\[\e[93m\]${git_branch}\[\e[36m\]${git_rpar}\n\$\[\e[0m\] '

# Case insensitive tab-completion ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# If ~/.inputrc doesn't exist yet: First include the original /etc/inputrc
# so it won't get overriden
if [ ! -a ~/.inputrc ]; then echo '$include /etc/inputrc' > ~/.inputrc; fi

# Add shell-option to ~/.inputrc to enable case-insensitive tab completion
echo 'set completion-ignore-case On' >> ~/.inputrc
