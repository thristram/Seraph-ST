/**
  ******************************************************************************
  * @file STM8_TSL_RC_MultiChannelKey.c
  * @brief RC Touch Sensing Library for STM8 CPU family.
  * Multi channel Key management. Allows to manage wheels and sliders.
  * @author STMicroelectronics - MCD Application Team
  * @version V1.2.0
  * @date 24-MAR-2009
  ******************************************************************************
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2009 STMicroelectronics</center></h2>
  * @image html logo.bmp
  ******************************************************************************
  */

#include "STM8_TSL_RC_MultiChannelKey.h"
#include "STM8_TSL_RC_API.h"
#include "STM8_TSL_RC_Services.h"

//============================================================================
//-----         CONDITIONAL COMPILING FOR MCKEYS !!!               -----------
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0
//============================================================================

//--------    SECTION DEFINITION FOR THIS FILE   --------------
#if defined(__CSMC__) && defined(USE_PRAGMA_SECTION)
#pragma section [TSLMCK_RAM]
#pragma section @tiny [TSLMCK_RAM0]
#pragma section (TSLMCK_CODE)
#pragma section const {TSLMCK_CONST}
#endif

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//-----        MCKEY1 CONSTANT TABLES FOR POSITION CALCULATION           -----
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#if CHANNEL_PER_MCKEY == 5

#if MCKEY1_TYPE == 0 // Wheel
#if MCKEY1_LAYOUT_TYPE == 0 // Interlaced electrodes
const s16 MCKEY1_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5
//   j = 0     1     2     3     4
         0,  -19, -83,  122,   58, // maj = 1; i = 0
         6,    0, -32, -122,   96, // maj = 2; i = 1
        70,   19,   0,  -45,  -96, // maj = 3; i = 2
        -6,  109,  32,    0,  -58, // maj = 4; i = 3
       -70, -109,  83,   45,    0  // maj = 5; i = 4
};
#define MCKEY1_SECTOR_COMPUTATION (26)
#define MCKEY1_POSITION_CORRECTION (0)
#else // Normal electrodes
const s16 MCKEY1_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5
//   j = 0     1     2     3     4
         0,  -38,   0,    0,  115, // maj = 1; i = 0
        13,    0, -64,    0,    0, // maj = 2; i = 1
         0,   38,   0,  -90,    0, // maj = 3; i = 2
         0,    0,  64,    0, -115, // maj = 4; i = 3
       -13,    0,   0,   90,    0  // maj = 5; i = 4
};
#define MCKEY1_SECTOR_COMPUTATION (51)
#define MCKEY1_POSITION_CORRECTION (0)
#endif
#endif

#if MCKEY1_TYPE == 1 // Slider
#if MCKEY1_LAYOUT_TYPE == 0 // Interlaced electrodes
const s16 MCKEY1_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5
//   j = 0     1     2     3     4
         0,  -21, -92,  135,   64, // maj = 1; i = 0
         7,    0, -36, -135,  107, // maj = 2; i = 1
        78,   21,   0,  -50, -107, // maj = 3; i = 2
      -149,  121,  36,    0,  -64, // maj = 4; i = 3
       -78, -121,  92,   50,    0  // maj = 5; i = 4
};
#define MCKEY1_SECTOR_COMPUTATION (28)
#define MCKEY1_POSITION_CORRECTION (28)
#else // Normal electrodes
const s16 MCKEY1_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5
//   j = 0     1     2     3     4
         0,  -64,    0,    0,    0, // maj = 1; i = 0
        21,    0, -107,    0,    0, // maj = 2; i = 1
         0,   64,    0, -149,    0, // maj = 3; i = 2
         0,    0,  107,    0, -192, // maj = 4; i = 3
         0,    0,    0,  149,    0  // maj = 5; i = 4
};
#define MCKEY1_SECTOR_COMPUTATION (85)
#define MCKEY1_POSITION_CORRECTION (85)
#endif
#endif

#endif // CHANNEL_PER_MCKEY == 5

#if CHANNEL_PER_MCKEY == 8

#if MCKEY1_TYPE == 0 // Wheel
#if MCKEY1_LAYOUT_TYPE == 0 // Interlaced electrodes
const s16 MCKEY1_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5     6     7     8 
//   j = 0     1     2     3     4     5     6     7
         0,  -12,    0,  -76,    0,  124,    0,   60, // maj = 1; i = 0
         4,    0,  -20,    0, -100,    0,   84,    0, // maj = 2; i = 1
         0,   12,    0,  -28,    0, -124,    0,  108, // maj = 3; i = 2
        68,    0,   20,    0,  -36,    0,  -84,    0, // maj = 4; i = 3
         0,   92,    0,   28,    0,  -44,    0, -108, // maj = 5; i = 4
        -4,    0,  116,    0,   36,    0,  -52,    0, // maj = 6; i = 5
         0,  -92,    0,   76,    0,   44,    0,  -60, // maj = 7; i = 6
       -68,    0, -116,    0,  100,    0,   52,    0  // maj = 8; i = 7
};
#define MCKEY1_SECTOR_COMPUTATION (16)
#define MCKEY1_POSITION_CORRECTION (0)
#else // Normal electrodes
const s16 MCKEY1_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5     6     7     8 
//   j = 0     1     2     3     4     5     6     7
         0,  -24,    0,    0,    0,    0,    0,  120, // maj = 1; i = 0
         8,    0,  -40,    0,    0,    0,    0,    0, // maj = 2; i = 1
         0,   24,    0,  -56,    0,    0,    0,    0, // maj = 3; i = 2
         0,    0,   40,    0,  -72,    0,    0,    0, // maj = 4; i = 3
         0,    0,    0,   56,    0,  -88,    0,    0, // maj = 5; i = 4
         0,    0,    0,    0,   72,    0, -104,    0, // maj = 6; i = 5
         0,    0,    0,    0,    0,   88,    0, -120, // maj = 7; i = 6
        -8,    0,    0,    0,    0,    0,  104,    0  // maj = 8; i = 7
};
#define MCKEY1_SECTOR_COMPUTATION (32)
#define MCKEY1_POSITION_CORRECTION (0)
#endif
#endif

#if MCKEY1_TYPE == 1 // Slider
#if MCKEY1_LAYOUT_TYPE == 0 // Interlaced electrodes
const s16 MCKEY1_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5     6     7     8 
//   j = 0     1     2     3     4     5     6     7
         0,  -13,    0,  -81,    0,  132,    0,   64, // maj = 1; i = 0
         4,    0,  -21,    0, -107,    0,   90,    0, // maj = 2; i = 1
         0,   13,    0,  -30,    0, -132,    0,  115, // maj = 3; i = 2
        73,    0,   21,    0,  -38,    0,  -90,    0, // maj = 4; i = 3
         0,   98,    0,   30,    0,  -47,    0, -115, // maj = 5; i = 4
      -141,    0,  124,    0,   38,    0,  -55,    0, // maj = 6; i = 5
         0,  -98,    0,   81,    0,   47,    0,  -64, // maj = 7; i = 6
       -73,    0, -124,    0,  107,    0,   55,    0  // maj = 8; i = 7
};
#define MCKEY1_SECTOR_COMPUTATION (17)
#define MCKEY1_POSITION_CORRECTION (17)
#else // Normal electrodes
const s16 MCKEY1_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5     6     7     8 
//   j = 0     1     2     3     4     5     6     7
         0,  -32,    0,    0,    0,    0,    0,    0, // maj = 1; i = 0
        11,    0,  -53,    0,    0,    0,    0,    0, // maj = 2; i = 1
         0,   32,    0,  -75,    0,    0,    0,    0, // maj = 3; i = 2
         0,    0,   53,    0,  -96,    0,    0,    0, // maj = 4; i = 3
         0,    0,    0,   75,    0, -117,    0,    0, // maj = 5; i = 4
         0,    0,    0,    0,   96,    0, -139,    0, // maj = 6; i = 5
         0,    0,    0,    0,    0,  117,    0, -160, // maj = 7; i = 6
         0,    0,    0,    0,    0,    0,  139,    0  // maj = 8; i = 7
};
#define MCKEY1_SECTOR_COMPUTATION (43)
#define MCKEY1_POSITION_CORRECTION (43)
#endif
#endif

#endif // CHANNEL_PER_MCKEY == 8

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//-----        MCKEY2 CONSTANT TABLES FOR POSITION CALCULATION           -----
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1

#if CHANNEL_PER_MCKEY == 5

#if MCKEY2_TYPE == 0 // Wheel
#if MCKEY2_LAYOUT_TYPE == 0 // Interlaced electrodes
const s16 MCKEY2_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5
//   j = 0     1     2     3     4
         0,  -19, -83,  122,   58, // maj = 1; i = 0
         6,    0, -32, -122,   96, // maj = 2; i = 1
        70,   19,   0,  -45,  -96, // maj = 3; i = 2
        -6,  109,  32,    0,  -58, // maj = 4; i = 3
       -70, -109,  83,   45,    0  // maj = 5; i = 4
};
#define MCKEY2_SECTOR_COMPUTATION (26)
#define MCKEY2_POSITION_CORRECTION (0)
#else // Normal electrodes
const s16 MCKEY2_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5
//   j = 0     1     2     3     4
         0,  -38,   0,    0,  115, // maj = 1; i = 0
        13,    0, -64,    0,    0, // maj = 2; i = 1
         0,   38,   0,  -90,    0, // maj = 3; i = 2
         0,    0,  64,    0, -115, // maj = 4; i = 3
       -13,    0,   0,   90,    0  // maj = 5; i = 4
};
#define MCKEY2_SECTOR_COMPUTATION (51)
#define MCKEY2_POSITION_CORRECTION (0)
#endif
#endif

#if MCKEY2_TYPE == 1 // Slider
#if MCKEY2_LAYOUT_TYPE == 0 // Interlaced electrodes
const s16 MCKEY2_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5
//   j = 0     1     2     3     4
         0,  -21, -92,  135,   64, // maj = 1; i = 0
         7,    0, -36, -135,  107, // maj = 2; i = 1
        78,   21,   0,  -50, -107, // maj = 3; i = 2
      -149,  121,  36,    0,  -64, // maj = 4; i = 3
       -78, -121,  92,   50,    0  // maj = 5; i = 4
};
#define MCKEY2_SECTOR_COMPUTATION (28)
#define MCKEY2_POSITION_CORRECTION (28)
#else // Normal electrodes
const s16 MCKEY2_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5
//   j = 0     1     2     3     4
         0,  -64,    0,    0,    0, // maj = 1; i = 0
        21,    0, -107,    0,    0, // maj = 2; i = 1
         0,   64,    0, -149,    0, // maj = 3; i = 2
         0,    0,  107,    0, -192, // maj = 4; i = 3
         0,    0,    0,  149,    0  // maj = 5; i = 4
};
#define MCKEY2_SECTOR_COMPUTATION (85)
#define MCKEY2_POSITION_CORRECTION (85)
#endif
#endif

#endif // CHANNEL_PER_MCKEY == 5

#if CHANNEL_PER_MCKEY == 8

#if MCKEY2_TYPE == 0 // Wheel
#if MCKEY2_LAYOUT_TYPE == 0 // Interlaced electrodes
const s16 MCKEY2_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5     6     7     8 
//   j = 0     1     2     3     4     5     6     7
         0,  -12,    0,  -76,    0,  124,    0,   60, // maj = 1; i = 0
         4,    0,  -20,    0, -100,    0,   84,    0, // maj = 2; i = 1
         0,   12,    0,  -28,    0, -124,    0,  108, // maj = 3; i = 2
        68,    0,   20,    0,  -36,    0,  -84,    0, // maj = 4; i = 3
         0,   92,    0,   28,    0,  -44,    0, -108, // maj = 5; i = 4
        -4,    0,  116,    0,   36,    0,  -52,    0, // maj = 6; i = 5
         0,  -92,    0,   76,    0,   44,    0,  -60, // maj = 7; i = 6
       -68,    0, -116,    0,  100,    0,   52,    0  // maj = 8; i = 7
};
#define MCKEY2_SECTOR_COMPUTATION (16)
#define MCKEY2_POSITION_CORRECTION (0)
#else // Normal electrodes
const s16 MCKEY2_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5     6     7     8 
//   j = 0     1     2     3     4     5     6     7
         0,  -24,    0,    0,    0,    0,    0,  120, // maj = 1; i = 0
         8,    0,  -40,    0,    0,    0,    0,    0, // maj = 2; i = 1
         0,   24,    0,  -56,    0,    0,    0,    0, // maj = 3; i = 2
         0,    0,   40,    0,  -72,    0,    0,    0, // maj = 4; i = 3
         0,    0,    0,   56,    0,  -88,    0,    0, // maj = 5; i = 4
         0,    0,    0,    0,   72,    0, -104,    0, // maj = 6; i = 5
         0,    0,    0,    0,    0,   88,    0, -120, // maj = 7; i = 6
        -8,    0,    0,    0,    0,    0,  104,    0  // maj = 8; i = 7
};
#define MCKEY2_SECTOR_COMPUTATION (32)
#define MCKEY2_POSITION_CORRECTION (0)
#endif
#endif

#if MCKEY2_TYPE == 1 // Slider
#if MCKEY2_LAYOUT_TYPE == 0 // Interlaced electrodes
const s16 MCKEY2_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5     6     7     8 
//   j = 0     1     2     3     4     5     6     7
         0,  -13,    0,  -81,    0,  132,    0,   64, // maj = 1; i = 0
         4,    0,  -21,    0, -107,    0,   90,    0, // maj = 2; i = 1
         0,   13,    0,  -30,    0, -132,    0,  115, // maj = 3; i = 2
        73,    0,   21,    0,  -38,    0,  -90,    0, // maj = 4; i = 3
         0,   98,    0,   30,    0,  -47,    0, -115, // maj = 5; i = 4
      -141,    0,  124,    0,   38,    0,  -55,    0, // maj = 6; i = 5
         0,  -98,    0,   81,    0,   47,    0,  -64, // maj = 7; i = 6
       -73,    0, -124,    0,  107,    0,   55,    0  // maj = 8; i = 7
};
#define MCKEY2_SECTOR_COMPUTATION (17)
#define MCKEY2_POSITION_CORRECTION (17)
#else // Normal electrodes
const s16 MCKEY2_TABLE_POSITION_OFFSET[CHANNEL_PER_MCKEY][CHANNEL_PER_MCKEY] =
{
// sec = 1     2     3     4     5     6     7     8 
//   j = 0     1     2     3     4     5     6     7
         0,  -32,    0,    0,    0,    0,    0,    0, // maj = 1; i = 0
        11,    0,  -53,    0,    0,    0,    0,    0, // maj = 2; i = 1
         0,   32,    0,  -75,    0,    0,    0,    0, // maj = 3; i = 2
         0,    0,   53,    0,  -96,    0,    0,    0, // maj = 4; i = 3
         0,    0,    0,   75,    0, -117,    0,    0, // maj = 5; i = 4
         0,    0,    0,    0,   96,    0, -139,    0, // maj = 6; i = 5
         0,    0,    0,    0,    0,  117,    0, -160, // maj = 7; i = 6
         0,    0,    0,    0,    0,    0,  139,    0  // maj = 8; i = 7
};
#define MCKEY2_SECTOR_COMPUTATION (43)
#define MCKEY2_POSITION_CORRECTION (43)
#endif
#endif

#endif // CHANNEL_PER_MCKEY == 8

#endif // MCKEY2

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//-----             LIBRARY PRIVATE GLOBALS                              -----
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/**
  ******************************************************************************
  * @brief Initialize all MCKey relative parameters and variables.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_Init(void)
{

  for ( KeyIndex = 0; KeyIndex < NUMBER_OF_MULTI_CHANNEL_KEYS; KeyIndex++ )
  {
    TSL_MCKey_SetStructPointer();
    pMCKeyStruct->State.whole = DISABLED_STATE;
    pMCKeyStruct->DetectThreshold = MCKEY_DETECTTHRESHOLD_DEFAULT;
    pMCKeyStruct->EndDetectThreshold = MCKEY_ENDDETECTTHRESHOLD_DEFAULT;
    pMCKeyStruct->RecalibrationThreshold = MCKEY_RECALIBRATIONTHRESHOLD_DEFAULT;
    pMCKeyStruct->Resolution = MCKEY_RESOLUTION_DEFAULT;
    pMCKeyStruct->DirectionChangeIntegrator = MCKEY_DIRECTION_CHANGE_INTEGRATOR_DEFAULT;
    pMCKeyStruct->DirectionChangeThreshold = MCKEY_DIRECTION_CHANGE_THRESHOLD_DEFAULT;
  }

  /* Set MC key type: Wheel or Slider */
  sMCKeyInfo[0].Setting.b.MCKEY_TYPE = MCKEY1_TYPE;
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1
  sMCKeyInfo[1].Setting.b.MCKEY_TYPE = MCKEY2_TYPE;
#endif

}


/**
  ******************************************************************************
  * @brief Select I/Os to burst and call IO driver for burst sequence.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey1_Acquisition(void)
{

  KeyIndex = 0;
  TSL_MCKey_SetStructPointer();

  if ( !( (pMCKeyStruct->State.whole == ERROR_STATE) || (pMCKeyStruct->State.whole == DISABLED_STATE) ) )
  {
    for ( ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++ )
    {
      sTouchIO.PORT_ADDR = (GPIO_TypeDef *)(Table_MCKEY_PORTS[ChannelIndex]);
      sTouchIO.AcqMask = Table_MCKEY_BITS[ChannelIndex];
      sTouchIO.DriveMask = (u8)(sTouchIO.AcqMask | MCKEY1_DRIVEN_SHIELD_MASK);
      sTouchIO.Measurement = &sMCKeyInfo[0].Channel[ChannelIndex].LastMeas;
      sTouchIO.RejectedNb = &sMCKeyInfo[0].Channel[ChannelIndex].LastMeasRejectNb;
      sTouchIO.Type = MCKEY_TYPE;
      TSL_IO_Acquisition(MCKEY_ACQ_NUM, MCKEY_ADJUST_LEVEL);
    }
  }
  
}


#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1
/**
  ******************************************************************************
  * @brief Select I/Os to burst and call IO driver for burst sequence.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey2_Acquisition(void)
{

  KeyIndex = 1;
  TSL_MCKey_SetStructPointer();

  if ( !( (pMCKeyStruct->State.whole == ERROR_STATE) || (pMCKeyStruct->State.whole == DISABLED_STATE) ) )
  {
    for ( ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++ )
    {
      sTouchIO.PORT_ADDR = (GPIO_TypeDef *)(Table_MCKEY_PORTS[CHANNEL_PER_MCKEY + ChannelIndex]);
      sTouchIO.AcqMask = Table_MCKEY_BITS[CHANNEL_PER_MCKEY + ChannelIndex];
      sTouchIO.DriveMask = (u8)(sTouchIO.AcqMask | MCKEY2_DRIVEN_SHIELD_MASK);
      sTouchIO.Measurement = &sMCKeyInfo[1].Channel[ChannelIndex].LastMeas;
      sTouchIO.RejectedNb = &sMCKeyInfo[1].Channel[ChannelIndex].LastMeasRejectNb;
      sTouchIO.Type = MCKEY_TYPE;
      TSL_IO_Acquisition(MCKEY_ACQ_NUM, MCKEY_ADJUST_LEVEL);
    }
  }

}
#endif


/**
  ******************************************************************************
  * @brief After Touch Sensing acquisition, data processing.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_Process(void)
{

  TSL_MCKey_SetStructPointer();

  switch ( pMCKeyStruct->State.whole )
  {
    case IDLE_STATE:
      if ( TSL_MCKey_CheckErrorCondition( ) )
      {
        TSL_MCKey_SetErrorState( );
        break;
      }
      TSL_MCKey_IdleTreatment( );
      TSL_MCKey_CheckDisabled( );
      break;

    case PRE_DETECTED_STATE:
      TSL_MCKey_PreDetectTreatment( );
      break;

    case DETECTED_STATE:
      if ( TSL_MCKey_CheckErrorCondition( ) )
      {
        TSL_MCKey_SetErrorState( );
        break;
      }
      TSL_MCKey_DetectedTreatment( );
      TSL_MCKey_CheckDisabled( );
      break;

    case POST_DETECTED_STATE:
      TSL_MCKey_PostDetectTreatment( );
      break;

    case PRE_CALIBRATION_STATE:
      TSL_MCKey_PreRecalibrationTreatment( );
      break;

    case CALIBRATION_STATE:
      if ( TSL_MCKey_CheckErrorCondition( ) )
      {
        TSL_MCKey_SetErrorState( );
        break;
      }
      TSL_MCKey_CalibrationTreatment( );
      TSL_MCKey_CheckDisabled( );
      break;

    case ERROR_STATE:
      TSL_MCKey_CheckDisabled( );
      break;

    case DISABLED_STATE:
      TSL_MCKey_CheckEnabled( );
      break;

    default:
      for (;;)
      {
        // Infinite loop.
      }
  }

  TSL_TempGlobalSetting.whole |= pMCKeyStruct->Setting.whole;
  TSL_TempGlobalState.whole |= pMCKeyStruct->State.whole;
  pMCKeyStruct->Setting.b.CHANGED = 0;
  pMCKeyStruct->Setting.b.POSCHANGED = 0;

}


/**
  ******************************************************************************
  * @brief Check for MCKey info during Idle state: Verify detection and recalibration.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_IdleTreatment(void)
{

  /* Check all channels to enter in Calibration state if needed */
  for ( ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++ )
  {
    
    /* Ignore channel if too much noise is detected */
    if (pMCKeyStruct->Channel[ChannelIndex].LastMeasRejectNb > MAX_REJECTED_MEASUREMENTS)
    {
      break;
    }
    
    TSL_MCKey_DeltaCalculation( ChannelIndex );
    
    if ( Delta <= pMCKeyStruct->RecalibrationThreshold )
    {
      TSL_MCKey_SetPreRecalibrationState( );
      return;
    }
    
  }

  /* Check all channels to enter in Pre-detect state if needed */ 
  for ( ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++ )
  {
    
    /* Ignore channel if too much noise is detected */
    if (pMCKeyStruct->Channel[ChannelIndex].LastMeasRejectNb > MAX_REJECTED_MEASUREMENTS)
    {
      break;
    }
    
    TSL_MCKey_DeltaCalculation( ChannelIndex );
    
    if ( Delta >= pMCKeyStruct->DetectThreshold )
    {
      TSL_MCKey_SetPreDetectState( );
      if ( !DetectionIntegrator )
      {
        pMCKeyStruct->Channel[0].IntegratorCounter++;
        TSL_MCKey_PreDetectTreatment( );
      }
      return;
    }
    
  }

}


/**
  ******************************************************************************
  * @brief Check MCKey info during PRE DETECT state: Verify detection integrator and detection exclusion.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_PreDetectTreatment(void)
{

  u8 ConditionLeaveDetect = 1; /* Per default we go back to idle state */

  /* Go back in idle state if ALL channels are below the detect threshold */
  for ( ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++ )
  {
    TSL_MCKey_DeltaCalculation( ChannelIndex );
    if ((pMCKeyStruct->Channel[ChannelIndex].LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS) &&
       (Delta >= pMCKeyStruct->DetectThreshold))
    {
      ConditionLeaveDetect = 0;
      break;
    }
  }

  if ( ConditionLeaveDetect )
  {
    TSL_MCKey_BackToIdleState( );
    return;
  }
  else
  {
    TSL_MCKey_DES( );
    pMCKeyStruct->Channel[0].IntegratorCounter--;
    if ( !pMCKeyStruct->Channel[0].IntegratorCounter )
    {
      TSL_MCKey_Position( );
      TSL_MCKey_SetDetectedState( );
    }
  }

}


/**
  ******************************************************************************
  * @brief Check MCKey info during DETECTED state:
  * Verify detection timeout, end of detection and detection exclusion.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_DetectedTreatment(void)
{

  u8 ConditionLeaveDetect = 1;

  /* Go in post-detect state if ALL channels are below or equal the end-detect threshold */
  for ( ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++ )
  {
    TSL_MCKey_DeltaCalculation( ChannelIndex );
    if ((pMCKeyStruct->Channel[ChannelIndex].LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS) &&
        (Delta > pMCKeyStruct->EndDetectThreshold))
    {
      ConditionLeaveDetect = 0;
      break;
    }
  }
  
  if ( ConditionLeaveDetect )
  {
    TSL_MCKey_SetPostDetectState( );
    if ( !EndDetectionIntegrator )
    {
      pMCKeyStruct->Channel[0].IntegratorCounter++;
      TSL_MCKey_PostDetectTreatment( );
    }
    return;
  }

  /* Detection TimeOut only if there is no change in the slider/wheel position */
  if (TSL_MCKey_Position() == 0x00)
  {
    TSL_MCKey_DetectionTimeout( );
  }

}


/**
  ******************************************************************************
  * @brief Check MCKey info during POST DETECT state: Verify end of detection.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_PostDetectTreatment(void)
{

  u8 ConditionLeaveDetect = 1;

  /* Go in idle state if ALL channels are below or equal the end-detect threshold */
  for ( ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++ )
  {
    TSL_MCKey_DeltaCalculation( ChannelIndex );
    if ((pMCKeyStruct->Channel[ChannelIndex].LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS) &&
        (Delta > pMCKeyStruct->EndDetectThreshold))
    {
      ConditionLeaveDetect = 0;
      break;
    }
  }

  if ( ConditionLeaveDetect )
  {
    pMCKeyStruct->Channel[0].IntegratorCounter--;
    if ( !pMCKeyStruct->Channel[0].IntegratorCounter )
    {
      TSL_MCKey_SetIdleState( );
    }
  }
  else
  {
    // No reset of DTO counter.
    TSL_MCKey_BackToDetectedState( );
  }
}


/**
  ******************************************************************************
  * @brief Check MCKey info during PRE RECALIBRATION state: Verify condition for recalibration.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_PreRecalibrationTreatment(void)
{

  u8 ConditionLeaveCalib = 1;

  /* Go in calibration state if at least ONE channel is below the calibration threshold */
  for ( ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++ )
  {
    TSL_MCKey_DeltaCalculation( ChannelIndex );
    if ((pMCKeyStruct->Channel[ChannelIndex].LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS) &&
        (Delta <= pMCKeyStruct->RecalibrationThreshold))
    {
      ConditionLeaveCalib = 0;
      break;
    }
  }

  if ( !ConditionLeaveCalib )
  {
    pMCKeyStruct->Channel[0].IntegratorCounter--;
    if ( !pMCKeyStruct->Channel[0].IntegratorCounter )
    {
      TSL_MCKey_SetCalibrationState( );
    }
  }
  else
  {
    TSL_MCKey_BackToIdleState( );
  }

}


/**
  ******************************************************************************
  * @brief During calibration, calculates the new reference.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_CalibrationTreatment(void)
{

  for ( ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++ )
  {
    if (pMCKeyStruct->Channel[ChannelIndex].LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS)
    {
      pMCKeyStruct->Channel[ChannelIndex].Reference += pMCKeyStruct->Channel[ChannelIndex].LastMeas;
    }
    else
    {
      return;
    }
  }
  
  pMCKeyStruct->Counter--;
  
  if ( !pMCKeyStruct->Counter )
  {
    for ( ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++ )
    {
      // Warning: Must be divided by MCKEY_CALIBRATION_COUNT_DEFAULT !!!
      pMCKeyStruct->Channel[ChannelIndex].Reference = (pMCKeyStruct->Channel[ChannelIndex].Reference >> 3);
    }
    TSL_MCKey_SetIdleState( );
  }

}


/**
  ******************************************************************************
  * @brief Calculates the position on the MCKey. 
  * @par Parameters:
  * None
  * @retval u8 Returns 0x00 if no change, 0xFF is new position detected
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
u8 TSL_MCKey_Position(void)
{

  u8 Index1, Index2;
#if CHANNEL_PER_MCKEY == 8  
  u8 Index3;
#endif
  u16 Major, Minor, SectorComputation;
  s16 NewPosition;
  u8 uNewPosition;
  u32 tmpdelta;
  u8 PositionCorrection;
  u8 retval = 0x00;
  
  Delta1 = 0;
  Delta2 = 0;
  Delta3 = 0;

  Index1 = 0;
  Index2 = 0;
#if CHANNEL_PER_MCKEY == 8  
  Index3 = 0;
#endif

  for ( ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++ )
  {
    
    TSL_MCKey_DeltaCalculation( ChannelIndex );
   
    // Delta must be positive only otherwise it is noise
    if ( Delta < 0 )
    {
      Delta = 0;
    }
    
    /* We normalize the Delta */
    tmpdelta = (u32)(Delta * (u32)(pMCKeyStruct->Channel[0].Reference));
    tmpdelta = tmpdelta / pMCKeyStruct->Channel[ChannelIndex].Reference;
    Delta = (s16)tmpdelta;
   
    /* Apply a fixed coefficient */
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1
  if (KeyIndex == 0) // MCKEY1
    {
#endif
      if (MCKEY1_DELTA_COEFF[ChannelIndex] != 0x0100)
      {
        tmpdelta = (u32)(Delta * MCKEY1_DELTA_COEFF[ChannelIndex]);
        Delta = (s16)(tmpdelta >> (u8)8);
      }
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1
    }   
    else // MCKEY2
    {
      if (MCKEY2_DELTA_COEFF[ChannelIndex] != 0x0100)
      {
        tmpdelta = (u32)(Delta * MCKEY2_DELTA_COEFF[ChannelIndex]);
        Delta = (s16)(tmpdelta >> (u8)8);
      }
    }
#endif
   
    /* Sort the biggest, middle and lowest signals measured
       - Delta1 and Index1 = biggest
       - Delta2 and Index2 = middle
       - Delta3 and Index3 = lowest */
    if ( Delta > Delta1 )
    {
      Delta3 = Delta2;
      Delta2 = Delta1;
      Delta1 = Delta;
#if CHANNEL_PER_MCKEY == 8
      Index3 = Index2;
#endif
      Index2 = Index1;
      Index1 = ChannelIndex;
    }
    else
    {
      if ( Delta > Delta2 )
      {
        Delta3 = Delta2;
        Delta2 = Delta;
#if CHANNEL_PER_MCKEY == 8        
        Index3 = Index2;
#endif
        Index2 = ChannelIndex;
      }
      else
      {
        if ( Delta > Delta3 )
        {
#if CHANNEL_PER_MCKEY == 8          
          Index3 = ChannelIndex;
#endif
          Delta3 = Delta;
        }
      }
    }

  } /* for all channels */

  /* Noise filter: we need at least two significant Delta measurements */
  if (Delta2 < ((u8)(pMCKeyStruct->EndDetectThreshold >> 1)) - 1)
  {
    return retval;
  }

  //----------------------------------------------------------------------------
  // Position calculation...
  //----------------------------------------------------------------------------
  
  /*----------------------------------------------------------------------------
    B = Biggest signal measured (Delta1/Index1)
    M = Middle signal measured (Delta2/Index2)
    S = Smallest signal measured (Delta3/Index3)
    
    - The equation to find the position is:
      Position = Offset +/- [ Sector_Size x ( Major / (Major + Minor) ) ]
   
    - The Offset is the position of the middle of the Middle signal segment.
      All the Offset values are stored in the ROM table Table_POSITION_OFFSET.
   
    - Major = Biggest - Smallest signals
      Minor = Middle - Smallest signals
   
    - The Sector_Size depends of the number of channels used
  ----------------------------------------------------------------------------*/

  /* Calculates the Major and Minor parameters */
  Minor = Delta2 - Delta3; // Middle - Smallest signals
  Major = Delta1 - Delta3; // Biggest - Smallest signals

#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1
  if (KeyIndex == 0) // MCKEY1
  {
#endif
    NewPosition = MCKEY1_TABLE_POSITION_OFFSET[Index1][Index2];
    SectorComputation = MCKEY1_SECTOR_COMPUTATION;
    PositionCorrection = MCKEY1_POSITION_CORRECTION;
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1
  }
  else // MCKEY2
  {
    NewPosition = MCKEY2_TABLE_POSITION_OFFSET[Index1][Index2];
    SectorComputation = MCKEY2_SECTOR_COMPUTATION;
    PositionCorrection = MCKEY2_POSITION_CORRECTION;
  }
#endif

  /* Calculates: [ Sector_Size x ( Major / (Major + Minor) ) ] */
  SectorComputation = Major * SectorComputation;
  SectorComputation = SectorComputation / ( Major + Minor );

  // Use the sign bit from table to define the interpretation direction.
  // The NewPosition is multiplied by 2 because the Offset stored in the ROM
  // table is divided by 2...
  if ( NewPosition > 0 ) // means Offset is > 0 in the ROM table
  {
    NewPosition = (s16)(NewPosition << 1); /*lint !e701 suppress info on this line only */
    NewPosition += SectorComputation;
  }
  else // means Offset is <= 0 in the ROM table
  {
    NewPosition = (s16)((-NewPosition) << 1); /*lint !e701 suppress info on this line only */
    NewPosition -= SectorComputation;
  }

  if (pMCKeyStruct->Setting.b.MCKEY_TYPE) // It's a Slider...
  {
    
    /* First adjustment used to shift all the values to obtain the "zero" */
    if (NewPosition > 0)
    {
      NewPosition -= PositionCorrection;
    }
    else
    {
      NewPosition = NewPosition + 256 - PositionCorrection;
    }
    
    /* Second adjustment used to clamp the values at extremities of slider */
    if (NewPosition < 0)
    {
      NewPosition = 0;
    }
    
    if (NewPosition > 255)
    {
      NewPosition = 255;
    }
   
  }
  else // It's a Wheel: we keep only the low byte
  {
    NewPosition = (u8)NewPosition;
  }
  
  //----------------------------------------------------------------------------
  // Direction Change Process
  //----------------------------------------------------------------------------

#if MCKEY_DIRECTION_CHANGE_ENABLED > 0

  if (pMCKeyStruct->Setting.b.DIRECTION) // Anticlockwise direction ...
  {
   
    // Check Direction changed and Position overflow from 0x00 to 0xFF not realized !
    if ( ((u8)NewPosition > pMCKeyStruct->UnScaledPosition) && (((u8)NewPosition - pMCKeyStruct->UnScaledPosition) < MCKEY_DIRECTION_CHANGE_MAX_DISPLACEMENT) )
    {
      if ( NewPosition < (u16)(pMCKeyStruct->UnScaledPosition + pMCKeyStruct->DirectionChangeThreshold) )
      {
        pMCKeyStruct->Channel[1].IntegratorCounter = pMCKeyStruct->DirectionChangeIntegrator;
        return retval;
      }
      else
      {
        pMCKeyStruct->Channel[1].IntegratorCounter--;
        if ( !pMCKeyStruct->Channel[1].IntegratorCounter )
        {
          pMCKeyStruct->Channel[1].IntegratorCounter = pMCKeyStruct->DirectionChangeIntegrator;
          pMCKeyStruct->Setting.b.DIRECTION = 0;  // New direction accepted: clockwise.
        }
        else
        {
          return retval;
        }
      }
    }
    
    // Check position overflow from 0xFF to 0x00 to be filtered !
    if ( (NewPosition + MCKEY_DIRECTION_CHANGE_MAX_DISPLACEMENT) < pMCKeyStruct->UnScaledPosition )
    {
      if ( (NewPosition + MCKEY_DIRECTION_CHANGE_TOTAL_STEPS) < (u16)(pMCKeyStruct->UnScaledPosition + pMCKeyStruct->DirectionChangeThreshold) )
      {
        pMCKeyStruct->Channel[1].IntegratorCounter = pMCKeyStruct->DirectionChangeIntegrator;
        return retval;
      }
      else
      {
        pMCKeyStruct->Channel[1].IntegratorCounter--;
        if ( !pMCKeyStruct->Channel[1].IntegratorCounter )
        {
          pMCKeyStruct->Channel[1].IntegratorCounter = pMCKeyStruct->DirectionChangeIntegrator;
          pMCKeyStruct->Setting.b.DIRECTION = 0;  // New direction accepted: clockwise.
        }
        else
        {
          return retval;
        }
      }
    }
    
  }
  else // Clockwise direction... DEFAULT SETTING !
  {
    
    // Check Direction changed and Position overflow from 0xFF to 0x00 not realized !
    if ( ((u8)NewPosition < pMCKeyStruct->UnScaledPosition) && ((pMCKeyStruct->UnScaledPosition - (u8)NewPosition) < MCKEY_DIRECTION_CHANGE_MAX_DISPLACEMENT) )
    {
      if ( (NewPosition + pMCKeyStruct->DirectionChangeThreshold) > pMCKeyStruct->UnScaledPosition )
      {
        pMCKeyStruct->Channel[1].IntegratorCounter = pMCKeyStruct->DirectionChangeIntegrator;
        return retval;
      }
      else
      {
        pMCKeyStruct->Channel[1].IntegratorCounter--;
        if ( !pMCKeyStruct->Channel[1].IntegratorCounter )
        {
          pMCKeyStruct->Channel[1].IntegratorCounter = pMCKeyStruct->DirectionChangeIntegrator;
          pMCKeyStruct->Setting.b.DIRECTION = 1;  // New direction accepted: anticlockwise.
        }
        else
        {
          return retval;
        }
      }
    }
    
    // Check position overflow from 0x00 to 0xFF to be filtered !
    if ( NewPosition > (u16)(pMCKeyStruct->UnScaledPosition + MCKEY_DIRECTION_CHANGE_MAX_DISPLACEMENT) )
    {
      if ( (NewPosition + pMCKeyStruct->DirectionChangeThreshold) > (u16)(pMCKeyStruct->UnScaledPosition + MCKEY_DIRECTION_CHANGE_TOTAL_STEPS) )
      {
        pMCKeyStruct->Channel[1].IntegratorCounter = pMCKeyStruct->DirectionChangeIntegrator;
        return retval;
      }
      else
      {
        pMCKeyStruct->Channel[1].IntegratorCounter--;
        if ( !pMCKeyStruct->Channel[1].IntegratorCounter )
        {
          pMCKeyStruct->Channel[1].IntegratorCounter = pMCKeyStruct->DirectionChangeIntegrator;
          pMCKeyStruct->Setting.b.DIRECTION = 1;  // New direction accepted: anticlockwise.
        }
        else
        {
          return retval;
        }
      }
    }
    
  }

#endif // MCKEY_DIRECTION_CHANGE_ENABLED

  //----------------------------------------------------------------------------
  // Final result...
  //----------------------------------------------------------------------------
  
  // The UnScaledPosition parameter is always updated
  // The Position parameter is updated only if different from the previous one  

  pMCKeyStruct->UnScaledPosition = (u8)NewPosition;
  
  uNewPosition = (u8)((u8)NewPosition >> (MCKEY_RESOLUTION_CALCULATION - pMCKeyStruct->Resolution));
  
  if ( pMCKeyStruct->Position != uNewPosition )
  {
    pMCKeyStruct->Position = uNewPosition;
    pMCKeyStruct->Setting.b.POSCHANGED = 1; /* Warning: Application layer must reset this flag */
    retval = 0xFF;
  }

  return retval;
  
}


/**
  ******************************************************************************
  * @brief Check for customer code setting and adapt key state.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_CheckDisabled(void)
{

  if ( !pMCKeyStruct->Setting.b.ENABLED )
  {
    TSL_MCKey_SetDisabledState( );
  }

}


/**
  ******************************************************************************
  * @brief Check for customer code setting and adapt key state.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_CheckEnabled(void)
{

  if ( pMCKeyStruct->Setting.b.ENABLED && pMCKeyStruct->Setting.b.IMPLEMENTED )
  {
    TSL_MCKey_SetCalibrationState( );
  }

}


/**
  ******************************************************************************
  * @brief Verify the last burst sequence gave a result within the authorized range.
  * @par Parameters:
  * None
  * @retval u8 Return 0 if OK, 0xFF if Error.
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
u8 TSL_MCKey_CheckErrorCondition(void)
{

  for ( ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++ )
  {
    if ( (pMCKeyStruct->Channel[ChannelIndex].LastMeas < MCKEY_MIN_ACQUISITION)
         || (pMCKeyStruct->Channel[ChannelIndex].LastMeas > MCKEY_MAX_ACQUISITION) )
    {
      return 0xFF;  // Error case !
    }
  }
  
  return 0;
  
}

//============================================================================
//-----         CONDITIONAL COMPILING FOR MCKEYS !!!               -----------
#endif
//============================================================================

/*********************** (c) 2009 STMicroelectronics **************************/
