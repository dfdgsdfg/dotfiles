if [[ $(sysctl -n machdep.cpu.brand_string) =~ "Apple" ]]
then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi
