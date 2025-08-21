{ pkgs, ... }:
{ 
  environment.systemPackages = with pkgs; [            
    dive # look into docker image layers              
    podman-tui # status of containers in the terminal 
    podman-compose # start group of containers for dev
    skopeo
  ];

  #security.unprivilegedUsernsClone = true; # podman as non root
  networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ]; # Allows all podman networks to use DNS
                                                                          
  virtualisation = {                                                   
    # Enable common container config files in /etc/containers          
    containers = {
      enable = true;
      registries.search = [
        "docker.io"
        "quay.io"
      ];
    }; 
    
    podman = {
      enable = true;
      
      dockerSocket.enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
     
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
