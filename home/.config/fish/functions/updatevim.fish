function updatevim
  set SHELL (which sh)
  #vim +PluginInstall! +PluginClean +qall
  vim +PluginUpdate +PluginClean +qall
  set SHELL (which fish)
end
