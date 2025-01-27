{ ... }:
{
	nix.distributedBuilds = true;
	
  nix.buildMachines = [{
	  hostName = "yggdrasil";
	  # if the builder supports building for multiple architectures, 
	  # replace the previous line by, e.g.
	  # systems = ["x86_64-linux" "aarch64-linux" "i386"];
    system = "x86_64-linux";
    protocol = "ssh-ng";
	  maxJobs = 24;
	  speedFactor = 10;
	  supportedFeatures = [ "benchmark" "big-parallel" "kvm" "nixos-test" ];
	}];

	# optional, useful when the builder has a faster internet connection than yours
	#nix.extraOptions = ''
	#  builders-use-substitutes = true
	#'';

  programs.ssh.extraConfig = ''
Host yggdrasil
  Hostname 192.168.178.58
  IdentitiesOnly yes
  IdentityFile /root/.ssh/id_ed25519
  User nixremotebuilder
  '';
}
