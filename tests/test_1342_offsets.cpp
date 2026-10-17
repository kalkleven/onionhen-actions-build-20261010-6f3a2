#include <cassert>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <limits>

namespace offsets {
size_t allproc();
size_t security_flags();
size_t qa_flags();
size_t utoken_flags();
size_t root_vnode();
}

#ifdef TEST_UNSUPPORTED_VERSION
static constexpr uint32_t kReportedFirmware = 0x13430000u;
#else
static constexpr uint32_t kReportedFirmware = 0x13420000u;
#endif

extern "C" int sysctlbyname(const char *, void *oldp, size_t *oldlenp,
                            const void *, size_t) {
    if (!oldp || !oldlenp || *oldlenp < sizeof(kReportedFirmware)) return -1;
    std::memcpy(oldp, &kReportedFirmware, sizeof(kReportedFirmware));
    *oldlenp = sizeof(kReportedFirmware);
    return 0;
}

int main() {
#ifdef TEST_UNSUPPORTED_VERSION
    constexpr size_t kUnsupported = std::numeric_limits<size_t>::max();
    assert(offsets::allproc() == kUnsupported);
    assert(offsets::security_flags() == kUnsupported);
    assert(offsets::qa_flags() == kUnsupported);
    assert(offsets::utoken_flags() == kUnsupported);
    assert(offsets::root_vnode() == kUnsupported);
#else
    assert(offsets::allproc() == 0x28c9e80u);
    assert(offsets::security_flags() == 0x0d99064u);
    assert(offsets::qa_flags() == 0x0d99088u);
    assert(offsets::utoken_flags() == 0x0d990f0u);
    assert(offsets::root_vnode() == 0x3137510u);
#endif
}

