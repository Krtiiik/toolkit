# Color prompt
PROMPT_COMMAND='git_branch=$(git branch --show-current 2>/dev/null);git_lpar=""; git_rpar="";if [[ -n "$git_branch" ]]; then
    git_lpar="("
    git_rpar=")"
fi'
PS1='\[\e[92m\]\u\[\e[36m\]@\[\e[92m\]\H\[\e[36m\]:\[\e[96m\]\w\[\e[36m\]${git_lpar}\[\e[93m\]${git_branch}\[\e[36m\]${git_rpar}\n\$\[\e[0m\] '
