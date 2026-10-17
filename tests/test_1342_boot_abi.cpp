#include "port_boot_abi.hpp"
#include "port_mono_abi.hpp"

#include <cassert>

int main() {
    static_assert(sizeof(PortNullableInt64) == 16);
    static_assert(alignof(PortNullableInt64) == 8);

    assert(port_boot_abi(2, false, "System.Boolean", "System.String",
                         "System.Int32", nullptr) == PortBootAbi::TwoArguments);
    assert(port_boot_abi(3, false, "System.Boolean", "System.String",
                         "System.UInt32", "System.String") == PortBootAbi::StringArgument);
    assert(port_boot_abi(3, false, "System.Boolean", "System.String",
                         "System.Int32", "System.Nullable<System.Int64>", 16, 8)
           == PortBootAbi::NullableInt64);
    assert(port_boot_abi(3, false, "System.Boolean", "System.String",
                         "System.Int32", "System.Nullable`1<System.Int64>", 16, 8)
           == PortBootAbi::NullableInt64);
    assert(port_boot_integer32_enum(true, "System.UInt32", 4, 4, false));
    assert(!port_boot_integer32_enum(true, "System.UInt64", 8, 8, false));
    assert(!port_boot_integer32_enum(true, "System.Int32", 4, 4, true));
    assert(port_boot_abi(3, true, "System.Boolean", "System.String",
                         "System.Int32", "System.String") == PortBootAbi::Unsupported);
    assert(port_boot_abi(3, false, "System.Int32", "System.String",
                         "System.Int32", "System.String") == PortBootAbi::Unsupported);
    assert(port_boot_abi(3, false, "System.Boolean", "System.String",
                         "System.Int32", "System.Nullable<System.Int64>", 8, 8)
           == PortBootAbi::Unsupported);
    assert(port_boot_abi(4, false, "System.Boolean", "System.String",
                         "System.Int32", "System.String") == PortBootAbi::Unsupported);
    return 0;
}
