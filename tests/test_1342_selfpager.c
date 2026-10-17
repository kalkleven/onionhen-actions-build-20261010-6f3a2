#include "firmware_profile_1342.h"

#include <assert.h>
#include <stdint.h>

int main(void) {
    assert(etahen_port_pager_table_offset(0x13420000u) == 0x00e03910u);
    assert(etahen_port_pager_table_offset(0x1342abcdU) == 0x00e03910u);
    assert(etahen_port_pager_table_offset(0x13400000u) == 0u);
    assert(etahen_port_pager_table_offset(0x10000000u) == 0u);
    return 0;
}
