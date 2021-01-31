#define COMPONENT AUR
#define COMPONENT_BEAUTIFIED AUR

// #define DRAW_FASTROPE_INFO
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_AUR
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_AUR
    #define DEBUG_SETTINGS DEBUG_SETTINGS_AUR
#endif

#include "script_macros_common.hpp"
#include "script_xeh.hpp"

#define AUR_DEFAULT_ROPE_LENGTH 60
