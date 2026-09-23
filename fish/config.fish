function fish_greeting
    fastfetch
end

if test -f ~/.fish_profile
  source ~/.fish_profile
end

if status is-interactive
    set -g fish_color_normal d3c6aa
    set -g fish_color_command a7c080
    set -g fish_color_builtin a7c080
    set -g fish_color_function a7c080
    set -g fish_color_keyword e67e80
    set -g fish_color_quote dbbc7f
    set -g fish_color_redirection 7fbbb3
    set -g fish_color_end e69875
    set -g fish_color_error e67e80
    set -g fish_color_param d3c6aa
    set -g fish_color_option 7fbbb3
    set -g fish_color_comment 859289
    set -g fish_color_valid_path --underline
    set -g fish_color_selection d3c6aa --background=3d484d
    set -g fish_color_operator e69875
    set -g fish_color_escape d699b6
    set -g fish_color_autosuggestion 859289
    set -g fish_color_search_match d3c6aa --background=475258
    set -g fish_color_history_current a7c080 --bold
    set -g fish_color_cancel e67e80 --reverse

    # Default prompt
    set -g fish_color_cwd a7c080
    set -g fish_color_cwd_root e67e80
    set -g fish_color_user dbbc7f
    set -g fish_color_host 7fbbb3
    set -g fish_color_host_remote d699b6
    set -g fish_color_status e67e80

    # Completion menu
    set -g fish_pager_color_progress 859289
    set -g fish_pager_color_background --background=2d353b
    set -g fish_pager_color_prefix a7c080 --bold
    set -g fish_pager_color_completion d3c6aa
    set -g fish_pager_color_description 859289
    set -g fish_pager_color_selected_background --background=3d484d
    set -g fish_pager_color_selected_prefix a7c080 --bold
    set -g fish_pager_color_selected_completion d3c6aa
    set -g fish_pager_color_selected_description d3c6aa
    set -g fish_pager_color_secondary_background --background=343f44
    set -g fish_pager_color_secondary_prefix a7c080 --bold
    set -g fish_pager_color_secondary_completion d3c6aa
    set -g fish_pager_color_secondary_description 859289
end

alias ls='eza --color=always --group-directories-first --icons=always'
alias la='eza -a --color=always --group-directories-first --icons=always'
alias ll='eza -l --color=always --group-directories-first --icons=always'
alias lt='eza -aT --color=always --group-directories-first --icons=always'
alias l.="eza -a | grep -e '^\.'" # show only dotfiles
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'
