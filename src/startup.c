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
const void *vector_table[] =
{
    &_estack,               /*  0 Initial MSP */
    Reset_Handler,          /*  1 Reset */
    Default_Handler,        /*  2 NMI */
    Default_Handler,        /*  3 HardFault */
    Default_Handler,        /*  4 MemManage */
    Default_Handler,        /*  5 BusFault */
    Default_Handler,        /*  6 UsageFault */
    0,                      /*  7 Reserved */
    0,                      /*  8 Reserved */
    0,                      /*  9 Reserved */
    0,                      /* 10 Reserved */
    Default_Handler,        /* 11 SVC */
    Default_Handler,        /* 12 DebugMon */
    0,                      /* 13 Reserved */
    Default_Handler,        /* 14 PendSV */
    Default_Handler,        /* 15 SysTick */
};

