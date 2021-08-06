# Layouts

This directory contains the disks layout descriptions. These descriptions are in
a Json format and are used by scripts in `scripts` directory to format the
partitions as needed and produce the filesystems configurations in `filesystems`
directory.

```python
{
    "disks": [
        {
            "device": "/dev/mmcblk0",
            "mode": "uefi",
            "read_only": false,
            "contains_system": true,

            "partitions": [
                {
                    "id": 1,
                    "size": "1G",
                    "type": "efi",
                    "encrypted": false,
                    "fs_type": "fat32",
                    "label": "uefi",
                    "is_efi": true
                },

                {
                    "id": 2,
                    "size": null,
                    "type": "linux",
                    "encrypted": true,
                    "fs_type": "lvm",
                    "label": "system",
                    "is_system": true,

                    "lvm": [
                        {
                            "id": 0,
                            "size": "1G",
                            "fs_type": "swap",
                            "label": "swap"
                        },

                        {
                            "id": 1,
                            "size": null,
                            "fs_type": "ext4",
                            "label": "root",
                            "is_root": true
                        }
                    ]
                }
            ]
        }
    ]
}
```

> **disks.disk.device**: path of the device file.
> **disks.disk.mode**: uefi|mbr
> **disks.disk.read_only**: true|false
> **disks.disk.contains_system**: true|false

> **disks.disk.partitions.partition.id**: partition ID
> **disks.disk.partitions.partition.size**: 1G|1M|1K|1|null
> **disks.disk.partitions.partition.type**: efi|linux
> **disks.disk.partitions.partition.encrypted**: true|false
> **disks.disk.partitions.partition.fs_type**: fat32|ext4|swap|lvm
> **disks.disk.partitions.partition.label**: label of the partition
> **disks.disk.partitions.partition.is_system**: true|false
> **disks.disk.partitions.partition.is_root**: true|false

> **disks.disk.partitions.partition.lvm.lv.id**: logical volume ID
> **disks.disk.partitions.partition.lvm.lv.size**: 1G|1M|1K|1|null
> **disks.disk.partitions.partition.lvm.lv.type**: linux
> **disks.disk.partitions.partition.lvm.lv.encrypted**: true|false
> **disks.disk.partitions.partition.lvm.lv.fs_type**: fat32|ext4|swap
> **disks.disk.partitions.partition.lvm.lv.label**: label of the logical volume
> **disks.disk.partitions.partition.lvm.lv.is_system**: true|false
> **disks.disk.partitions.partition.lvm.lv.is_root**: true|false
