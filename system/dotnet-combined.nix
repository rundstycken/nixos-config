{ pkgs, ... }:

{
  config = {
    environment.systemPackages = [
      (with pkgs.dotnetCorePackages; pkgs.combinePackages [
        sdk_8_0
        sdk_7_0
        sdk_6_0
      ]).overrideAttrs (finalAttrs: previousAttrs: {
        postBuild = (previousAttrs.postBuild or "") + ''
          for i in $out/sdk/*; do
            i=$(basename $i)
            length=$(printf "%s" "$i" | wc -c)
            substring=$(printf "%s" "$i" | cut -c 1-$(expr $length - 2))
            i="$substring""00"
            mkdir -p $out/metadata/workloads/${i/-*}
            touch $out/metadata/workloads/${i/-*}/userlocal
          done
        '';
      })
    ];
  };
}

