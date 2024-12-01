#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
  const char* title;
  uint16_t    width;
  uint16_t    height;
  int16_t     monitor;
  int16_t     monitorMode;
  bool        borderless;
  bool        fullscreen;
  bool        maximized;
  bool        resizable;
} Config;

Config loadConfig(const char* path);

#ifdef __cplusplus
}
#endif
