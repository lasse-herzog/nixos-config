{...}: {
  services.ollama = {
    enable = true;

    loadModels = [
      "deepseek-r1:8b"
      "qwen3:8b"
    ];
  };
}
