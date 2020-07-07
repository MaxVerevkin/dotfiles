# Defined in - @ line 1
function mount_backup --wraps='udisksctl mount -b /dev/disk/by-uuid/ddb3a586-36d4-4e3e-889d-7e41f6b407a2 -o compress=lzo' --description 'alias mount_backup=udisksctl mount -b /dev/disk/by-uuid/ddb3a586-36d4-4e3e-889d-7e41f6b407a2 -o compress=lzo'
  udisksctl mount -b /dev/disk/by-uuid/ddb3a586-36d4-4e3e-889d-7e41f6b407a2 -o compress=lzo $argv;
end
