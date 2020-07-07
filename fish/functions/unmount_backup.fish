# Defined in - @ line 1
function unmount_backup --wraps='udisksctl unmount -b /dev/disk/by-uuid/ddb3a586-36d4-4e3e-889d-7e41f6b407a2 && udisksctl power-off -b /dev/disk/by-uuid/ddb3a586-36d4-4e3e-889d-7e41f6b407a2' --description 'alias unmount_backup=udisksctl unmount -b /dev/disk/by-uuid/ddb3a586-36d4-4e3e-889d-7e41f6b407a2 && udisksctl power-off -b /dev/disk/by-uuid/ddb3a586-36d4-4e3e-889d-7e41f6b407a2'
  udisksctl unmount -b /dev/disk/by-uuid/ddb3a586-36d4-4e3e-889d-7e41f6b407a2 && udisksctl power-off -b /dev/disk/by-uuid/ddb3a586-36d4-4e3e-889d-7e41f6b407a2 $argv;
end
