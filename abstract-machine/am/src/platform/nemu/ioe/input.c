#include <am.h>
#include <nemu.h>

#define KEYDOWN_MASK 0x8000

void __am_input_keybrd(AM_INPUT_KEYBRD_T *kbd) {
  uint32_t temp = inl(KBD_ADDR);
  if(temp != AM_KEY_NONE){
    kbd->keydown = 1;
    kbd->keycode = (temp & ~KEYDOWN_MASK);
  }else{
    kbd->keydown = 0;
    kbd->keycode = AM_KEY_NONE;
  }
}
