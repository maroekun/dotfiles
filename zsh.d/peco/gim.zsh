function gim() {
  local selected_file=$(git ls-files | peco)
  if [ -n "$selected_file" ] ; then
    vim $selected_file
  fi
}
