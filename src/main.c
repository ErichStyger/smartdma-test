#include <stdio.h>

extern void initialise_monitor_handles(void);

int main(void) {
    // Initialize semihosting (newlib / rdimon)
    initialise_monitor_handles();

    // This will generate a semihosting call
    printf("Hello from semihosting!\n");

    return 0;
}
