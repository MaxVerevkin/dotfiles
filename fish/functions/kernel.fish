# Defined in - @ line 1
function kernel --wraps=uname\ -r\ \|\ cut\ -d\ \'-\'\ -f\ 1\ \|\ figlet\ -k\ \|\ lolcat\ -F\ .5 --description alias\ kernel=uname\ -r\ \|\ cut\ -d\ \'-\'\ -f\ 1\ \|\ figlet\ -k\ \|\ lolcat\ -F\ .5
  uname -r | cut -d '-' -f 1 | figlet -k | lolcat -F .5 $argv;
end
