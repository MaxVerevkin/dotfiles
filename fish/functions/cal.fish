# Defined in - @ line 1
function cal --wraps='cal -3m' --description 'alias cal=cal -3m'
 command cal -3m $argv;
end
