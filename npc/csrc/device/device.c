
#include <common.h>
#include <utils.h>
#include <SDL2/SDL.h>

#define TIMER_HZ 60

void init_i8042();

void send_key(uint8_t, bool);

void device_update() {
  static uint64_t last = 0;
  uint64_t now = get_time();
  if (now - last < 1000000 / TIMER_HZ) {
    return;
  }
  last = now;

  // IFDEF(CONFIG_HAS_VGA, vga_update_screen());


  SDL_Event event;
  while (SDL_PollEvent(&event)) {
    switch (event.type) {
      case SDL_QUIT:
        exit(0);
        break;
      #ifdef CONFIG_KEYBOARD
      // If a key was pressed
      case SDL_KEYDOWN:
      case SDL_KEYUP: {
        uint8_t k = event.key.keysym.scancode;
        bool is_keydown = (event.key.type == SDL_KEYDOWN);
        send_key(k, is_keydown);
        break;
      }
      #endif
      default: break;
    }
  }

}

void sdl_clear_event_queue() {
#ifndef CONFIG_TARGET_AM
  SDL_Event event;
  while (SDL_PollEvent(&event));
#endif
}

void init_device() {

#ifdef CONFIG_DEVICE
  init_i8042();
#endif

}
