{inputs, config, pkgs, lib, ...}:
let 
    cfg = config.modules.services.minecraft;
in
{
    imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];

    options.modules.services.minecraft = {
        enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable Fabric Minecraft server version 1.12.10";
        };
    };

    config = lib.mkIf cfg.enable {
        nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];        
        services.minecraft-servers = {
            enable = true;
            eula = true;
            openFirewall = true;

            servers.fabricLatest = {
                enable = true;
                autoStart = false;

                package = pkgs.fabricServers.fabric-1_21_10;

                symlinks = {
                    mods = pkgs.linkFarmFromDrvs "mods" (
                        builtins.attrValues {
                            Fabric-API = pkgs.fetchurl {
                                url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/tV4Gc0Zo/fabric-api-0.138.4%2B1.21.10.jar";
                                sha512 = "sha512-XmTFM5Hf0cBZd31nHFK+F6TieinZvXNA6p4/Vc56dws42woV4JZumB7owbk3L7iVQ6J4UhYkaJJorOu4W9XG6Q==";
                            };

                            FerriteCore = pkgs.fetchurl {
                                url = "https://cdn.modrinth.com/data/uXXizFIs/versions/MGoveONm/ferritecore-8.0.2-fabric.jar";
                                sha512 = "sha512-jDiQ+xFt+vaB9fSD6g0b/s+4fdWEzHLncv5D6m7PFaCceC/tvlzqO4v36TC9XAB1OmGaxc56+n/QknadaOm+7A==";
                            };

                            Lithium = pkgs.fetchurl {
                                url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/NsswKiwi/lithium-fabric-0.20.1%2Bmc1.21.10.jar";
                                sha512 = "sha512-ebKJLRI/O7EmSZJ92PzMJclV/zihnzq6fNAYDEz1UGwqdtSUGLEwUPkLunu1nzYjrwboonXiroxjgICEBDkCuw==";
                            };

                            Krypton = pkgs.fetchurl {
                                url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/O9LmWYR7/krypton-0.2.10.jar";
                                sha512 = "sha512-Tc1yKNGJDd/HjJn/KEtF+c9Aqud+9jWTCOJtBvoNk4NlJVaWr0zBLVJMRsSIbNzRkmjBZaK/Cig1IC/oV9pcqw==";
                            };

                            Debugify = pkgs.fetchurl {
                                url = "https://cdn.modrinth.com/data/QwxR6Gcd/versions/i4mzYGzu/debugify-1.21.10%2B1.1.jar";
                                sha512 = "sha512-lYmnkBXaFa3lf1mpubiv1b05N9uGMu0bghz7LCHg0bLmKIJm30SV41YBC3MEzd0V1ItsTbpFSr+BCdWOPJgj+A==";
                            };

                            C2ME = pkgs.fetchurl {
                                url = "https://cdn.modrinth.com/data/VSNURh3q/versions/uNick7oj/c2me-fabric-mc1.21.10-0.3.5.1.0.jar";
                                sha512 = "sha512-TQechyq5EP1lpsnocJxwUBeGJvcSXISTico4OI4ZmVvYdOBx6G5qz2+++qLylP2+vsua+ERKkIuaPeiU2AfE2w==";
                            };

                            DistantHorizons = pkgs.fetchurl {
                                url = "https://cdn.modrinth.com/data/uCdwusMi/versions/CKJFSOC6/DistantHorizons-2.4.5-b-1.21.10-fabric-neoforge.jar";
                                sha512 = "sha512-gut6fVsHGvkWQcqipvu7HNznWkGjYU24VBhnGxgWrxC1l86DFbBLnK1JS1varEFfXK60eEiUc3/Xg2MB9ae++A==";
                            };
                            FallingTree = pkgs.fetchurl {
                              url = "https://cdn.modrinth.com/data/Fb4jn8m6/versions/hDjB8uAg/FallingTree-1.21.10-1.21.10.1.jar";
                              sha512 = "sha512-YW02VdD+emtW8rfJc6xF9BOA9o0+XQxiBc8wgv8fNamJXI+K8tPqKnwkQBeErcT8l5tweUql98i8upqVELFDmA==";
                            };
                        }   
                    );
                };
            };
        };
    };
}
