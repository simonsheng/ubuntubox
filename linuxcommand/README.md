# Linux Commands

## find

- -iname  like -name but ignore case
- find a file and open in vim
  find . iname '' -exec vim {} \;
  vim $(find -iname '')
