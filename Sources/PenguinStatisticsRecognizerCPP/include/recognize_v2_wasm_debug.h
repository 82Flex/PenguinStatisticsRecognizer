#ifndef recognize_v2_wasm_debug_h
#define recognize_v2_wasm_debug_h

#include <stdio.h>

#if __cplusplus
extern "C" {
#endif /* __cplusplus */

    void preload_json(const char* stagex, const char* itemx, const char* hashx, const char* i18n);
    void preload_templ(const char* itemId, uint8_t* buffer, size_t size);
    const char* recognize(uint8_t* buffer, size_t size, int fallback);

#if __cplusplus
}
#endif /* __cplusplus */

#endif /* recognize_v2_wasm_debug_h */
