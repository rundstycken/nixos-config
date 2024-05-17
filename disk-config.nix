{
  disko.devices = {
    disk = {
      my-disk = {
        device = "/dev/vda"; # Specify the virtual disk device
        type = "disk";
        content = {
          type = "gpt"; # Use GPT partition table
          partitions = [
            {
              name = "ESP";
              type = "EF00"; # EFI System Partition
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            }
            {
              name = "swap";
              size = "8G"; # 8GB swap partition
              content = {
                type = "swap";
                resumeDevice = true;
              };
            }
            {
              name = "root";
              size = "100%"; # Use remaining disk space for root partition
              content = {
                type = "filesystem";
                format = "btrfs"; # Use btrfs filesystem for root
                mountpoint = "/";
              };
            }
          ];
        };
      };
    };
  };
}
