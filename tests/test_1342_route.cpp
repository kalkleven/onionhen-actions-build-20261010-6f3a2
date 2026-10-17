#include "port_toolbox_route.hpp"

#include <cassert>
#include <cstring>
#include <cstdint>

int main() {
    using etahen_port::toolbox_uri_for_system_version;

    constexpr const char *legacy =
        "pssettings:play?mode=settings&function=debug_settings_old";
    constexpr const char *standard =
        "pssettings:play?mode=settings&function=debug_settings";
    constexpr const char *standard_no_mode =
        "pssettings:play?function=debug_settings";

    assert(std::strcmp(toolbox_uri_for_system_version(0x13420000u), legacy) == 0);
    assert(std::strcmp(toolbox_uri_for_system_version(0x13420000u, false), legacy) == 0);
    assert(std::strcmp(toolbox_uri_for_system_version(0x13600000u), legacy) == 0);
    assert(std::strcmp(toolbox_uri_for_system_version(0x11000000u), legacy) == 0);
    assert(std::strcmp(toolbox_uri_for_system_version(0x11000000u, false), legacy) == 0);
    assert(std::strcmp(toolbox_uri_for_system_version(0x10600000u), standard) == 0);
    assert(std::strcmp(toolbox_uri_for_system_version(0x10600000u, false), standard_no_mode) == 0);
}
