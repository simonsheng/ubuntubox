# Linux Commands

## find

- -iname  like -name but ignore case
- find a file and open in vim
  find . iname '' -exec vim {} \;
  vim $(find -iname '')

## tmux

- tmux new -s session name
- tmux list-clients
- tmux list-sessions
- tmux attach-session -t session name or tmux attach -t session name
- Ctrl + b  c create new window
- Ctrl + b , rename window
- Ctrl + b p/n previous or next
- Ctrl + b  w list windows
- Ctrl + b  % split windows virtically
- Ctrl + b  " split windows horizontally
- Ctrl + d close the bash shell
- Ctrl + b  d detached the session

## grep

- grep -r 'location' -e 'pattern'
- grep -l only list file name
- grep -n list line number
- grep -w whole word
