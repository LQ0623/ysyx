#include <am.h>
#include <nemu.h>

#define KEYDOWN_MASK 0x8000

void __am_input_keybrd(AM_INPUT_KEYBRD_T *kbd) {
  if(inb(0x60) & 0x1){
    kbd->keydown = true;
    kbd->keycode = inl(KBD_ADDR);
  }else {
    kbd->keydown = false;
    kbd->keycode = AM_KEY_NONE;
  }
}
