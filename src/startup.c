extern unsigned long _sidata;
extern unsigned long _sdata;
extern unsigned long _edata;
extern unsigned long _sbss;
extern unsigned long _ebss;

int main(void);

void Reset_Handler(void)
{
    unsigned long *src = &_sidata;
    unsigned long *dst = &_sdata;

    while (dst < &_edata) {
        *dst++ = *src++;
    }

    dst = &_sbss;

    while (dst < &_ebss) {
        *dst++ = 0;
    }

    main();

    while (1) {
    }
}

extern unsigned long _estack;

void Reset_Handler(void);
void Default_Handler(void) {
    for(;;){}
}

__attribute__((section(".isr_vector")))
const void *vector_table[] = {
    &_estack,
    Reset_Handler,
    Default_Handler,   /* NMI */
    Default_Handler,   /* HardFault */
    Default_Handler,   /* MemManage */
    Default_Handler,   /* BusFault */
    Default_Handler,   /* UsageFault */
};