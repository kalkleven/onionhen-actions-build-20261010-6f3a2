#define ETAHEN_PORT_1360 1
#include "port_toolbox_route.hpp"

#include <cassert>
#include <cstring>

int main() {
    assert(std::strcmp(ETAHEN_TOOLBOX_URI,
        "pssettings:play?mode=settings&function=debug_settings_old") == 0);
    assert(port_toolbox_root_requested(
        "pssettings:play?mode=settings&function=debug_settings"));
    assert(port_toolbox_root_requested(
        "pssettings:play?function=debug_settings"));
    assert(port_toolbox_root_requested(ETAHEN_TOOLBOX_ROOT_URI));
    assert(port_toolbox_root_requested("etaHEN?Toolbox"));
    assert(!port_toolbox_root_requested(
        "pssettings:play?mode=settings&function=debug_settings_old"));
    assert(!port_toolbox_root_requested(
        "pssettings:play?mode=settings&function=network"));
}
