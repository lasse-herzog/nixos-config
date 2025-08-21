{...}: {
  services.ollama = {
    enable = true;
    acceleration = "cuda";

    loadModels = [
      "deepseek-r1:8b"
      "qwen3:8b"
    ];
  };

  services.open-webui.enable = true;
}
