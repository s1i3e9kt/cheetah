#include "./config.h"
#include <iostream>
#include <filesystem>
#include <glaze/glaze.hpp>

namespace fs = std::filesystem;

void saveConfig(const char* path, Config config) {
  glz::context ctx{};
  std::string  buffer;

  auto _ = glz::write<glz::opts{.prettify = true}>(config, buffer, ctx);

  std::ofstream file(path);
  file.write(buffer.c_str(), buffer.size());
}

Config loadConfig(const char* path) {
  Config config {
    .title = "Cheetah",
    .width = 640,
    .height = 480,
    .monitor = -1,
    .monitorMode = -1,
    .borderless = true,
    .fullscreen = false,
    .maximized = false,
    .resizable = true,
  };
  if (glz::read_file_json(config, path, std::string{})) {
    saveConfig(path, config);
  }
  return config;
}
