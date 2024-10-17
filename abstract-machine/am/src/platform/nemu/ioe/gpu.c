#include <am.h>
#include <nemu.h>

#define SYNC_ADDR (VGACTL_ADDR + 4)
#define W_ADDR    (VGACTL_ADDR + 12)
#define H_ADDR    (VGACTL_ADDR + 12)
#define X_ADDR    (VGACTL_ADDR + 16)
#define Y_ADDR    (VGACTL_ADDR + 20)
#define PIXELS_ADDR (VGACTL_ADDR + 24)

void __am_gpu_init() {
  // int i;
  // int w = 400;  // TODO: get the correct width
  // int h = 300;  // TODO: get the correct height
  // uint32_t *fb = (uint32_t *)(uintptr_t)FB_ADDR;
  
  // for (i = 0; i < w * h; i ++) fb[i] = i;

  // outl(SYNC_ADDR, 1);
}

void __am_gpu_config(AM_GPU_CONFIG_T *cfg) {
  *cfg = (AM_GPU_CONFIG_T) {
    .present = true, .has_accel = false,
    .width = 400, .height = 300,
    .vmemsz = 0
  };
}

void __am_gpu_fbdraw(AM_GPU_FBDRAW_T *ctl) {
  if (ctl->sync) {
    outl(SYNC_ADDR, 1);
    outl(W_ADDR, ctl->w);
    outl(H_ADDR, ctl->h);
    outl(X_ADDR, ctl->x);
    outl(Y_ADDR, ctl->y);
    // outl(PIXELS_ADDR, ctl->pixels);
  }
}

void __am_gpu_status(AM_GPU_STATUS_T *status) {
  status->ready = true;
}

void __am_gpu_memcpy(AM_GPU_MEMCPY_T *memcpy){
  memcpy->size = inl(FB_ADDR);
}