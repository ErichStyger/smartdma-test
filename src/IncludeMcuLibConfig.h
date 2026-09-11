/*
 * Copyright (c) 2026, Erich Styger
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

/**
 * \file
 * \brief Project-wide McuLib, RTOS, middleware, and board configuration macros.
 * \author Erich Styger, erich.styger@hslu.ch
 * \license SPDX-License-Identifier: BSD-3-Clause
 */

/* header file is included with -include compiler option */

#ifndef MCULIB_CONFIG_CONFIG_H_
#define MCULIB_CONFIG_CONFIG_H_

/* ---------------------------------------------------------------------------------------*/
/* SDK */
#define McuLib_CONFIG_CPU_IS_KINETIS    (0)  /* not Kinetis */
#define McuLib_CONFIG_CPU_IS_MCXN       (1)  /* MCXN947 */
#define McuLib_CONFIG_CORTEX_M          (33)    /*!< 0: Cortex-M0, 3: M3, 4: M4, 7: M7, 33: M33, -1 otherwise */
#define McuLib_CONFIG_SDK_VERSION_USED  McuLib_CONFIG_SDK_MCUXPRESSO_2_0

#endif /* MCULIB_CONFIG_CONFIG_H_ */
