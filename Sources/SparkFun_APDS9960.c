/**
 * @file    SparkFun_APDS-9960.cpp
 * @brief   Library for the SparkFun APDS-9960 breakout board
 * @author  Shawn Hymel (SparkFun Electronics)
 *
 * @copyright	This code is public domain but you buy me a beer if you use
 * this and we meet someday (Beerware license).
 *
 * This library interfaces the Avago APDS-9960 to Arduino over I2C. The library
 * relies on the Arduino Wire (I2C) library. to use the library, instantiate an
 * APDS9960 object, call init(), and call the appropriate functions.
 *
 * APDS-9960 current draw tests (default parameters):
 *   Off:                   1mA
 *   Waiting for gesture:   14mA
 *   Gesture in progress:   35mA
 */
#include <math.h>
#include <stdlib.h>
#include "SparkFun_APDS9960.h"
#include "i2c_master_poll.h"



/* Members */
gesture_data_type gesture_data_;
int gesture_ud_delta_;
int gesture_lr_delta_;
int gesture_ud_count_;
int gesture_lr_count_;
int gesture_near_count_;
int gesture_far_count_;
int gesture_state_;
int gesture_motion_;

/**
 * @brief Constructor - Instantiates SparkFun_APDS9960 object
 */
void SparkFun_APDS9960(void)
{
	gesture_ud_delta_ = 0;
	gesture_lr_delta_ = 0;

	gesture_ud_count_ = 0;
	gesture_lr_count_ = 0;

	gesture_near_count_ = 0;
	gesture_far_count_ = 0;

	gesture_state_ = 0;
	gesture_motion_ = DIR_NONE;
}

/**
 * @brief Configures I2C communications and initializes registers to defaults
 *
 * @return 1 if initialized successfully. 0 otherwise.
 */
uint8_t init(void)
{
	uint8_t id;
	uint8_t ret;

	SparkFun_APDS9960();
	/* Initialize I2C */
	ret = I2C_Config();
	if(ret != IIC_SUCCESS) {
		return 0;
	}

	/* Read ID register and check against known values for APDS-9960 */
	if( !wireReadDataByte(APDS9960_ID, &id) ) {
		return 0;
	}
	if( !(id == APDS9960_ID_1 || id == APDS9960_ID_2) ) {
		return 0;
	}

	/* Set ENABLE register to 0 (disable all features) */
	if( !setMode(ALL, OFF) ) {
		return 0;
	}

	/* Set default values for ambient light and proximity registers */
	if( !wireWriteDataByte(APDS9960_ATIME, DEFAULT_ATIME) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_WTIME, DEFAULT_WTIME) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_PPULSE, DEFAULT_PROX_PPULSE) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_POFFSET_UR, DEFAULT_POFFSET_UR) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_POFFSET_DL, DEFAULT_POFFSET_DL) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_CONFIG1, DEFAULT_CONFIG1) ) {
		return 0;
	}
	if( !setLEDDrive(DEFAULT_LDRIVE) ) {
		return 0;
	}
	if( !setProximityGain(DEFAULT_PGAIN) ) {
		return 0;
	}
	if( !setAmbientLightGain(DEFAULT_AGAIN) ) {
		return 0;
	}
	if( !setProxIntLowThresh(DEFAULT_PILT) ) {
		return 0;
	}
	if( !setProxIntHighThresh(DEFAULT_PIHT) ) {
		return 0;
	}
	if( !setLightIntLowThreshold(DEFAULT_AILT) ) {
		return 0;
	}
	if( !setLightIntHighThreshold(DEFAULT_AIHT) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_PERS, DEFAULT_PERS) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_CONFIG2, DEFAULT_CONFIG2) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_CONFIG3, DEFAULT_CONFIG3) ) {
		return 0;
	}

	/* Set default values for gesture sense registers */
	if( !setGestureEnterThresh(DEFAULT_GPENTH) ) {
		return 0;
	}
	if( !setGestureExitThresh(DEFAULT_GEXTH) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_GCONF1, DEFAULT_GCONF1) ) {
		return 0;
	}
	if( !setGestureGain(DEFAULT_GGAIN) ) {
		return 0;
	}
	if( !setGestureLEDDrive(DEFAULT_GLDRIVE) ) {
		return 0;
	}
	if( !setGestureWaitTime(DEFAULT_GWTIME) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_GOFFSET_U, DEFAULT_GOFFSET) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_GOFFSET_D, DEFAULT_GOFFSET) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_GOFFSET_L, DEFAULT_GOFFSET) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_GOFFSET_R, DEFAULT_GOFFSET) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_GPULSE, DEFAULT_GPULSE) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_GCONF3, DEFAULT_GCONF3) ) {
		return 0;
	}
	if( !setGestureIntEnable(DEFAULT_GIEN) ) {
		return 0;
	}


	return 1;

}

/*******************************************************************************
 * Public methods for controlling the APDS-9960
 ******************************************************************************/

/**
 * @brief Reads and returns the contents of the ENABLE register
 *
 * @return Contents of the ENABLE register. 0xFF if error.
 */
uint8_t getMode(void)
{
	uint8_t enable_value;

	/* Read current ENABLE register */
	if( !wireReadDataByte(APDS9960_ENABLE, &enable_value) ) {
		return APDS9960_ERROR;
	}

	return enable_value;
}

/**
 * @brief Enables or disables a feature in the APDS-9960
 *
 * @param[in] mode which feature to enable
 * @param[in] enable ON (1) or OFF (0)
 * @return 1 if operation success. 0 otherwise.
 */
uint8_t setMode(uint8_t mode, uint8_t enable)
{
	uint8_t reg_val;

	/* Read current ENABLE register */
	reg_val = getMode();
	if( reg_val == APDS9960_ERROR ) {
		return 0;
	}

	/* Change bit(s) in ENABLE register */
	enable = enable & 0x01;
	if( mode >= 0 && mode <= 6 ) {
		if (enable) {
			reg_val |= (1 << mode);
		} else {
			reg_val &= ~(1 << mode);
		}
	} else if( mode == ALL ) {
		if (enable) {
			reg_val = 0x7F;
		} else {
			reg_val = 0x00;
		}
	}

	/* Write value back to ENABLE register */
	if( !wireWriteDataByte(APDS9960_ENABLE, reg_val) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Starts the light (R/G/B/Ambient) sensor on the APDS-9960
 *
 * @param[in] interrupts 1 to enable hardware interrupt on high or low light
 * @return 1 if sensor enabled correctly. 0 on error.
 */
uint8_t enableLightSensor(uint8_t interrupts)
{

	/* Set default gain, interrupts, enable power, and enable sensor */
	if( !setAmbientLightGain(DEFAULT_AGAIN) ) {
		return 0;
	}
	if( interrupts ) {
		if( !setAmbientLightIntEnable(1) ) {
			return 0;
		}
	} else {
		if( !setAmbientLightIntEnable(0) ) {
			return 0;
		}
	}
	if( !enablePower() ) {
		return 0;
	}
	if( !setMode(AMBIENT_LIGHT, 1) ) {
		return 0;
	}

	return 1;

}

/**
 * @brief Ends the light sensor on the APDS-9960
 *
 * @return 1 if sensor disabled correctly. 0 on error.
 */
uint8_t disableLightSensor(void)
{
	if( !setAmbientLightIntEnable(0) ) {
		return 0;
	}
	if( !setMode(AMBIENT_LIGHT, 0) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Starts the proximity sensor on the APDS-9960
 *
 * @param[in] interrupts 1 to enable hardware external interrupt on proximity
 * @return 1 if sensor enabled correctly. 0 on error.
 */
uint8_t enableProximitySensor(uint8_t interrupts)
{
	/* Set default gain, LED, interrupts, enable power, and enable sensor */
	if( !setProximityGain(DEFAULT_PGAIN) ) {
		return 0;
	}
	if( !setLEDDrive(DEFAULT_LDRIVE) ) {
		return 0;
	}
	if( interrupts ) {
		if( !setProximityIntEnable(1) ) {
			return 0;
		}
	} else {
		if( !setProximityIntEnable(0) ) {
			return 0;
		}
	}
	if( !enablePower() ) {
		return 0;
	}
	if( !setMode(PROXIMITY, 1) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Ends the proximity sensor on the APDS-9960
 *
 * @return 1 if sensor disabled correctly. 0 on error.
 */
uint8_t disableProximitySensor(void)
{
	if( !setProximityIntEnable(0) ) {
		return 0;
	}
	if( !setMode(PROXIMITY, 0) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Starts the gesture recognition engine on the APDS-9960
 *
 * @param[in] interrupts 1 to enable hardware external interrupt on gesture
 * @return 1 if engine enabled correctly. 0 on error.
 */
uint8_t enableGestureSensor(uint8_t interrupts)
{

	/* Enable gesture mode
	   Set ENABLE to 0 (power off)
	   Set WTIME to 0xFF
	   Set AUX to LED_BOOST_300
	   Enable PON, WEN, PEN, GEN in ENABLE
	*/
	resetGestureParameters();
	if( !wireWriteDataByte(APDS9960_WTIME, 0xFF) ) {
		return 0;
	}
	if( !wireWriteDataByte(APDS9960_PPULSE, DEFAULT_GESTURE_PPULSE) ) {
		return 0;
	}
	if( !setLEDBoost(LED_BOOST_300) ) {
		return 0;
	}
	if( interrupts ) {
		if( !setGestureIntEnable(1) ) {
			return 0;
		}
	} else {
		if( !setGestureIntEnable(0) ) {
			return 0;
		}
	}
	if( !setGestureMode(1) ) {
		return 0;
	}
	if( !enablePower() ) {
		return 0;
	}
	if( !setMode(WAIT, 1) ) {
		return 0;
	}
	if( !setMode(PROXIMITY, 1) ) {
		return 0;
	}
	if( !setMode(GESTURE, 1) ) {
		return 0;
	}

	return 1;

}

/**
 * @brief Ends the gesture recognition engine on the APDS-9960
 *
 * @return 1 if engine disabled correctly. 0 on error.
 */
uint8_t disableGestureSensor(void)
{
	resetGestureParameters();
	if( !setGestureIntEnable(0) ) {
		return 0;
	}
	if( !setGestureMode(0) ) {
		return 0;
	}
	if( !setMode(GESTURE, 0) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Determines if there is a gesture available for reading
 *
 * @return 1 if gesture available. 0 otherwise.
 */
uint8_t isGestureAvailable(void)
{
	uint8_t val;

	/* Read value from GSTATUS register */
	if( !wireReadDataByte(APDS9960_GSTATUS, &val) ) {
		return APDS9960_ERROR;
	}

	/* Shift and mask out GVALID bit */
	val &= APDS9960_GVALID;

	/* Return 1/0 based on GVALID bit */
	if( val == 1) {
		return 1;
	} else {
		return 0;
	}

}



/*-----------------------------------------------------------------------------
    手势分析
    返回0表示失败， 1表示结束，0xff表示未结束
------------------------------------------------------------------------------*/
u8 gesture_read_data(u8 *dir)
{
	u8  fifo_level = 0;
	u8  bytes_read = 0;
	u8  fifo_data[128];			/* 32 * 4 */
	u8  gstatus = 0;
	u8  ret = 0xff, i;

	/* Get the contents of the STATUS register. Is data still valid? */
	if( !wireReadDataByte(APDS9960_GSTATUS, &gstatus) ) {
		return 0;
	}

	/* If we have valid data, read in FIFO */
	if( (gstatus & APDS9960_GVALID) == APDS9960_GVALID ) {

		/* Read the current FIFO level */
		if( !wireReadDataByte(APDS9960_GFLVL, &fifo_level) ) {
			return 0;
		}

		/* If there's stuff in the FIFO, read it into our data block */
		if(fifo_level > 0) {
			if(fifo_level >= 32){		//避免越界
				fifo_level = 32;
			}
			bytes_read = wireReadDataBlock(APDS9960_GFIFO_U, (uint8_t*)fifo_data, (fifo_level * 4) );
			if( bytes_read == 0 ) {
				return 0;
			}

			/* If at least 1 set of data, sort the data into U/D/L/R */
			if( bytes_read >= 4 ) {

				for( i = 0; i < bytes_read; i += 4 ) {
					gesture_data_.u_data[gesture_data_.index] = \
							fifo_data[i + 0];
					gesture_data_.d_data[gesture_data_.index] = \
							fifo_data[i + 1];
					gesture_data_.l_data[gesture_data_.index] = \
							fifo_data[i + 2];
					gesture_data_.r_data[gesture_data_.index] = \
							fifo_data[i + 3];
					gesture_data_.index++;
					gesture_data_.total_gestures++;
				}

				/* Filter and process gesture data. Decode near/far state */
//				if( processGestureData() ) {
//					if( decodeGesture() ) {
//						//***TODO: U-Turn Gestures

//					}
//				}
				
				processGestureData();
				decodeGesture();

				/* Reset data */
				gesture_data_.index = 0;
				gesture_data_.total_gestures = 0;	
				
			}			
		}
		
	}
	else {
		ret = 1;
		/* Determine best guessed gesture and clean up */
//		decodeGesture();
		*dir = (u8)gesture_motion_;
		resetGestureParameters();
		
	}

	return ret;

}









/**
 * @brief Processes a gesture event and returns best guessed gesture
 *
 * @return Number corresponding to gesture. -1 on error.
 */
int readGesture(void)
{
	uint8_t fifo_level = 0;
	uint8_t bytes_read = 0;
	uint8_t fifo_data[128];
	uint8_t gstatus;
	int motion;
	int i;

	/* Make sure that power and gesture is on and data is valid */
	if( !isGestureAvailable() || !(getMode() & 0b01000001) ) {
		return DIR_NONE;
	}

	/* Keep looping as long as gesture data is valid */
	while(1) {

		/* Wait some time to collect next batch of FIFO data */
		delay_ms(FIFO_PAUSE_TIME);

		/* Get the contents of the STATUS register. Is data still valid? */
		if( !wireReadDataByte(APDS9960_GSTATUS, &gstatus) ) {
			return APDS9960_ERROR;
		}

		/* If we have valid data, read in FIFO */
		if( (gstatus & APDS9960_GVALID) == APDS9960_GVALID ) {

			/* Read the current FIFO level */
			if( !wireReadDataByte(APDS9960_GFLVL, &fifo_level) ) {
				return APDS9960_ERROR;
			}

			/* If there's stuff in the FIFO, read it into our data block */
			if( fifo_level > 0) {
				bytes_read = wireReadDataBlock(  APDS9960_GFIFO_U,
				                                 (uint8_t*)fifo_data,
				                                 (fifo_level * 4) );
				if( bytes_read == -1 ) {
					return APDS9960_ERROR;
				}

				/* If at least 1 set of data, sort the data into U/D/L/R */
				if( bytes_read >= 4 ) {
					for( i = 0; i < bytes_read; i += 4 ) {
						gesture_data_.u_data[gesture_data_.index] = \
						        fifo_data[i + 0];
						gesture_data_.d_data[gesture_data_.index] = \
						        fifo_data[i + 1];
						gesture_data_.l_data[gesture_data_.index] = \
						        fifo_data[i + 2];
						gesture_data_.r_data[gesture_data_.index] = \
						        fifo_data[i + 3];
						gesture_data_.index++;
						gesture_data_.total_gestures++;
					}



					/* Filter and process gesture data. Decode near/far state */
					if( processGestureData() ) {
						if( decodeGesture() ) {
							//***TODO: U-Turn Gestures

						}
					}

					/* Reset data */
					gesture_data_.index = 0;
					gesture_data_.total_gestures = 0;
				}
			}
		} else {

			/* Determine best guessed gesture and clean up */
//			delay_ms(FIFO_PAUSE_TIME);
			decodeGesture();
			motion = gesture_motion_;
			resetGestureParameters();
			return motion;
		}
	}
}

/**
 * Turn the APDS-9960 on
 *
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t enablePower(void)
{
	if( !setMode(POWER, 1) ) {
		return 0;
	}

	return 1;
}

/**
 * Turn the APDS-9960 off
 *
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t disablePower(void)
{
	if( !setMode(POWER, 0) ) {
		return 0;
	}

	return 1;
}

/*******************************************************************************
 * Ambient light and color sensor controls
 ******************************************************************************/

/**
 * @brief Reads the ambient (clear) light level as a 16-bit value
 *
 * @param[out] val value of the light sensor.
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t readAmbientLight(uint16_t *val)
{
	uint8_t val_byte;
	*val = 0;

	/* Read value from clear channel, low byte register */
	if( !wireReadDataByte(APDS9960_CDATAL, &val_byte) ) {
		return 0;
	}
	*val = val_byte;

	/* Read value from clear channel, high byte register */
	if( !wireReadDataByte(APDS9960_CDATAH, &val_byte) ) {
		return 0;
	}
	*val = *val + ((uint16_t)val_byte << 8);

	return 1;
}

/**
 * @brief Reads the red light level as a 16-bit value
 *
 * @param[out] val value of the light sensor.
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t readRedLight(uint16_t *val)
{
	uint8_t val_byte;
	*val = 0;

	/* Read value from clear channel, low byte register */
	if( !wireReadDataByte(APDS9960_RDATAL, &val_byte) ) {
		return 0;
	}
	*val = val_byte;

	/* Read value from clear channel, high byte register */
	if( !wireReadDataByte(APDS9960_RDATAH, &val_byte) ) {
		return 0;
	}
	*val = *val + ((uint16_t)val_byte << 8);

	return 1;
}

/**
 * @brief Reads the green light level as a 16-bit value
 *
 * @param[out] val value of the light sensor.
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t readGreenLight(uint16_t *val)
{
	uint8_t val_byte;
	*val = 0;

	/* Read value from clear channel, low byte register */
	if( !wireReadDataByte(APDS9960_GDATAL, &val_byte) ) {
		return 0;
	}
	*val = val_byte;

	/* Read value from clear channel, high byte register */
	if( !wireReadDataByte(APDS9960_GDATAH, &val_byte) ) {
		return 0;
	}
	*val = *val + ((uint16_t)val_byte << 8);

	return 1;
}

/**
 * @brief Reads the red light level as a 16-bit value
 *
 * @param[out] val value of the light sensor.
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t readBlueLight(uint16_t *val)
{
	uint8_t val_byte;
	*val = 0;

	/* Read value from clear channel, low byte register */
	if( !wireReadDataByte(APDS9960_BDATAL, &val_byte) ) {
		return 0;
	}
	*val = val_byte;

	/* Read value from clear channel, high byte register */
	if( !wireReadDataByte(APDS9960_BDATAH, &val_byte) ) {
		return 0;
	}
	*val = *val + ((uint16_t)val_byte << 8);

	return 1;
}

/*******************************************************************************
 * Proximity sensor controls
 ******************************************************************************/

/**
 * @brief Reads the proximity level as an 8-bit value
 *
 * @param[out] val value of the proximity sensor.
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t readProximity(uint8_t *val)
{
	*val = 0;

	/* Read value from proximity data register */
	if( !wireReadDataByte(APDS9960_PDATA, val) ) {
		return 0;
	}

	return 1;
}

/*******************************************************************************
 * High-level gesture controls
 ******************************************************************************/

/**
 * @brief Resets all the parameters in the gesture data member
 */
void resetGestureParameters(void)
{
	gesture_data_.index = 0;
	gesture_data_.total_gestures = 0;

	gesture_ud_delta_ = 0;
	gesture_lr_delta_ = 0;

	gesture_ud_count_ = 0;
	gesture_lr_count_ = 0;

	gesture_near_count_ = 0;
	gesture_far_count_ = 0;

	gesture_state_ = 0;
	gesture_motion_ = DIR_NONE;
}

/**
 * @brief Processes the raw gesture data to determine swipe direction
 *
 * @return 1 if near or far state seen. 0 otherwise.
 */
uint8_t processGestureData(void)
{
	uint8_t u_first = 0;
	uint8_t d_first = 0;
	uint8_t l_first = 0;
	uint8_t r_first = 0;
	uint8_t u_last = 0;
	uint8_t d_last = 0;
	uint8_t l_last = 0;
	uint8_t r_last = 0;
	int ud_ratio_first;
	int lr_ratio_first;
	int ud_ratio_last;
	int lr_ratio_last;
	int ud_delta;
	int lr_delta;
	int i;

	/* If we have less than 4 total gestures, that's not enough */
	if( gesture_data_.total_gestures <= 4 ) {
		return 0;
	}

	/* Check to make sure our data isn't out of bounds */
	if( (gesture_data_.total_gestures <= 32) && \
	        (gesture_data_.total_gestures > 0) ) {

		/* Find the first value in U/D/L/R above the threshold */
		for( i = 0; i < gesture_data_.total_gestures; i++ ) {
			if( (gesture_data_.u_data[i] > GESTURE_THRESHOLD_OUT) &&
			        (gesture_data_.d_data[i] > GESTURE_THRESHOLD_OUT) &&
			        (gesture_data_.l_data[i] > GESTURE_THRESHOLD_OUT) &&
			        (gesture_data_.r_data[i] > GESTURE_THRESHOLD_OUT) ) {

				u_first = gesture_data_.u_data[i];
				d_first = gesture_data_.d_data[i];
				l_first = gesture_data_.l_data[i];
				r_first = gesture_data_.r_data[i];
				break;
			}
		}

		/* If one of the _first values is 0, then there is no good data */
		if( (u_first == 0) || (d_first == 0) || \
		        (l_first == 0) || (r_first == 0) ) {

			return 0;
		}
		/* Find the last value in U/D/L/R above the threshold */
		for( i = gesture_data_.total_gestures - 1; i >= 0; i-- ) {
#if DEBUG
			Serial.print(F("Finding last: "));
			Serial.print(F("U:"));
			Serial.print(gesture_data_.u_data[i]);
			Serial.print(F(" D:"));
			Serial.print(gesture_data_.d_data[i]);
			Serial.print(F(" L:"));
			Serial.print(gesture_data_.l_data[i]);
			Serial.print(F(" R:"));
			Serial.println(gesture_data_.r_data[i]);
#endif
			if( (gesture_data_.u_data[i] > GESTURE_THRESHOLD_OUT) &&
			        (gesture_data_.d_data[i] > GESTURE_THRESHOLD_OUT) &&
			        (gesture_data_.l_data[i] > GESTURE_THRESHOLD_OUT) &&
			        (gesture_data_.r_data[i] > GESTURE_THRESHOLD_OUT) ) {

				u_last = gesture_data_.u_data[i];
				d_last = gesture_data_.d_data[i];
				l_last = gesture_data_.l_data[i];
				r_last = gesture_data_.r_data[i];
				break;
			}
		}
	}

	/* Calculate the first vs. last ratio of up/down and left/right */
	ud_ratio_first = ((u_first - d_first) * 100) / (u_first + d_first);
	lr_ratio_first = ((l_first - r_first) * 100) / (l_first + r_first);
	ud_ratio_last = ((u_last - d_last) * 100) / (u_last + d_last);
	lr_ratio_last = ((l_last - r_last) * 100) / (l_last + r_last);

#if DEBUG
	Serial.print(F("Last Values: "));
	Serial.print(F("U:"));
	Serial.print(u_last);
	Serial.print(F(" D:"));
	Serial.print(d_last);
	Serial.print(F(" L:"));
	Serial.print(l_last);
	Serial.print(F(" R:"));
	Serial.println(r_last);

	Serial.print(F("Ratios: "));
	Serial.print(F("UD Fi: "));
	Serial.print(ud_ratio_first);
	Serial.print(F(" UD La: "));
	Serial.print(ud_ratio_last);
	Serial.print(F(" LR Fi: "));
	Serial.print(lr_ratio_first);
	Serial.print(F(" LR La: "));
	Serial.println(lr_ratio_last);
#endif

	/* Determine the difference between the first and last ratios */
	ud_delta = ud_ratio_last - ud_ratio_first;
	lr_delta = lr_ratio_last - lr_ratio_first;

#if DEBUG
	Serial.print("Deltas: ");
	Serial.print("UD: ");
	Serial.print(ud_delta);
	Serial.print(" LR: ");
	Serial.println(lr_delta);
#endif

	/* Accumulate the UD and LR delta values */
	gesture_ud_delta_ += ud_delta;
	gesture_lr_delta_ += lr_delta;

#if DEBUG
	Serial.print("Accumulations: ");
	Serial.print("UD: ");
	Serial.print(gesture_ud_delta_);
	Serial.print(" LR: ");
	Serial.println(gesture_lr_delta_);
#endif

	/* Determine U/D gesture */
	if( gesture_ud_delta_ >= GESTURE_SENSITIVITY_1 ) {
		gesture_ud_count_ = 1;
	} else if( gesture_ud_delta_ <= -GESTURE_SENSITIVITY_1 ) {
		gesture_ud_count_ = -1;
	} else {
		gesture_ud_count_ = 0;
	}

	/* Determine L/R gesture */
	if( gesture_lr_delta_ >= GESTURE_SENSITIVITY_1 ) {
		gesture_lr_count_ = 1;
	} else if( gesture_lr_delta_ <= -GESTURE_SENSITIVITY_1 ) {
		gesture_lr_count_ = -1;
	} else {
		gesture_lr_count_ = 0;
	}

	/* Determine Near/Far gesture */
	if( (gesture_ud_count_ == 0) && (gesture_lr_count_ == 0) ) {
		if( (abs(ud_delta) < GESTURE_SENSITIVITY_2) && \
		        (abs(lr_delta) < GESTURE_SENSITIVITY_2) ) {

			if( (ud_delta == 0) && (lr_delta == 0) ) {
				gesture_near_count_++;
			} else if( (ud_delta != 0) || (lr_delta != 0) ) {
				gesture_far_count_++;
			}

			if( (gesture_near_count_ >= 10) && (gesture_far_count_ >= 2) ) {
				if( (ud_delta == 0) && (lr_delta == 0) ) {
					gesture_state_ = NEAR_STATE;
				} else if( (ud_delta != 0) && (lr_delta != 0) ) {
					gesture_state_ = FAR_STATE;
				}
				return 1;
			}
		}
	} else {
		if( (abs(ud_delta) < GESTURE_SENSITIVITY_2) && \
		        (abs(lr_delta) < GESTURE_SENSITIVITY_2) ) {

			if( (ud_delta == 0) && (lr_delta == 0) ) {
				gesture_near_count_++;
			}

			if( gesture_near_count_ >= 10 ) {
				gesture_ud_count_ = 0;
				gesture_lr_count_ = 0;
				gesture_ud_delta_ = 0;
				gesture_lr_delta_ = 0;
			}
		}
	}

#if DEBUG
	Serial.print("UD_CT: ");
	Serial.print(gesture_ud_count_);
	Serial.print(" LR_CT: ");
	Serial.print(gesture_lr_count_);
	Serial.print(" NEAR_CT: ");
	Serial.print(gesture_near_count_);
	Serial.print(" FAR_CT: ");
	Serial.println(gesture_far_count_);
	Serial.println("----------");
#endif

	return 0;
}

/**
 * @brief Determines swipe direction or near/far state
 *
 * @return 1 if near/far event. 0 otherwise.
 */
uint8_t decodeGesture(void)
{
	/* Return if near or far event is detected */
	if( gesture_state_ == NEAR_STATE ) {
		gesture_motion_ = DIR_NEAR;
		return 1;
	} else if ( gesture_state_ == FAR_STATE ) {
		gesture_motion_ = DIR_FAR;
		return 1;
	}

	/* Determine swipe direction */
	if( (gesture_ud_count_ == -1) && (gesture_lr_count_ == 0) ) {
		gesture_motion_ = DIR_UP;
	} else if( (gesture_ud_count_ == 1) && (gesture_lr_count_ == 0) ) {
		gesture_motion_ = DIR_DOWN;
	} else if( (gesture_ud_count_ == 0) && (gesture_lr_count_ == 1) ) {
		gesture_motion_ = DIR_RIGHT;
	} else if( (gesture_ud_count_ == 0) && (gesture_lr_count_ == -1) ) {
		gesture_motion_ = DIR_LEFT;
	} else if( (gesture_ud_count_ == -1) && (gesture_lr_count_ == 1) ) {
		if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
			gesture_motion_ = DIR_UP;
		} else {
			gesture_motion_ = DIR_RIGHT;
		}
	} else if( (gesture_ud_count_ == 1) && (gesture_lr_count_ == -1) ) {
		if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
			gesture_motion_ = DIR_DOWN;
		} else {
			gesture_motion_ = DIR_LEFT;
		}
	} else if( (gesture_ud_count_ == -1) && (gesture_lr_count_ == -1) ) {
		if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
			gesture_motion_ = DIR_UP;
		} else {
			gesture_motion_ = DIR_LEFT;
		}
	} else if( (gesture_ud_count_ == 1) && (gesture_lr_count_ == 1) ) {
		if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
			gesture_motion_ = DIR_DOWN;
		} else {
			gesture_motion_ = DIR_RIGHT;
		}
	} else {
		return 0;
	}

	return 1;
}

/*******************************************************************************
 * Getters and setters for register values
 ******************************************************************************/

/**
 * @brief Returns the lower threshold for proximity detection
 *
 * @return lower threshold
 */
uint8_t getProxIntLowThresh(void)
{
	uint8_t val;

	/* Read value from PILT register */
	if( !wireReadDataByte(APDS9960_PILT, &val) ) {
		val = 0;
	}

	return val;
}

/**
 * @brief Sets the lower threshold for proximity detection
 *
 * @param[in] threshold the lower proximity threshold
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setProxIntLowThresh(uint8_t threshold)
{
	if( !wireWriteDataByte(APDS9960_PILT, threshold) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Returns the high threshold for proximity detection
 *
 * @return high threshold
 */
uint8_t getProxIntHighThresh(void)
{
	uint8_t val;

	/* Read value from PIHT register */
	if( !wireReadDataByte(APDS9960_PIHT, &val) ) {
		val = 0;
	}

	return val;
}

/**
 * @brief Sets the high threshold for proximity detection
 *
 * @param[in] threshold the high proximity threshold
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setProxIntHighThresh(uint8_t threshold)
{
	if( !wireWriteDataByte(APDS9960_PIHT, threshold) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Returns LED drive strength for proximity and ALS
 *
 * Value    LED Current
 *   0        100 mA
 *   1         50 mA
 *   2         25 mA
 *   3         12.5 mA
 *
 * @return the value of the LED drive strength. 0xFF on failure.
 */
uint8_t getLEDDrive(void)
{
	uint8_t val;

	/* Read value from CONTROL register */
	if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
		return APDS9960_ERROR;
	}

	/* Shift and mask out LED drive bits */
	val = (val >> 6) & 0b00000011;

	return val;
}

/**
 * @brief Sets the LED drive strength for proximity and ALS
 *
 * Value    LED Current
 *   0        100 mA
 *   1         50 mA
 *   2         25 mA
 *   3         12.5 mA
 *
 * @param[in] drive the value (0-3) for the LED drive strength
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setLEDDrive(uint8_t drive)
{
	uint8_t val;

	/* Read value from CONTROL register */
	if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
		return 0;
	}

	/* Set bits in register to given value */
	drive &= 0b00000011;
	drive = drive << 6;
	val &= 0b00111111;
	val |= drive;

	/* Write register value back into CONTROL register */
	if( !wireWriteDataByte(APDS9960_CONTROL, val) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Returns receiver gain for proximity detection
 *
 * Value    Gain
 *   0       1x
 *   1       2x
 *   2       4x
 *   3       8x
 *
 * @return the value of the proximity gain. 0xFF on failure.
 */
uint8_t getProximityGain(void)
{
	uint8_t val;

	/* Read value from CONTROL register */
	if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
		return APDS9960_ERROR;
	}

	/* Shift and mask out PDRIVE bits */
	val = (val >> 2) & 0b00000011;

	return val;
}

/**
 * @brief Sets the receiver gain for proximity detection
 *
 * Value    Gain
 *   0       1x
 *   1       2x
 *   2       4x
 *   3       8x
 *
 * @param[in] drive the value (0-3) for the gain
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setProximityGain(uint8_t drive)
{
	uint8_t val;

	/* Read value from CONTROL register */
	if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
		return 0;
	}

	/* Set bits in register to given value */
	drive &= 0b00000011;
	drive = drive << 2;
	val &= 0b11110011;
	val |= drive;

	/* Write register value back into CONTROL register */
	if( !wireWriteDataByte(APDS9960_CONTROL, val) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Returns receiver gain for the ambient light sensor (ALS)
 *
 * Value    Gain
 *   0        1x
 *   1        4x
 *   2       16x
 *   3       64x
 *
 * @return the value of the ALS gain. 0xFF on failure.
 */
uint8_t getAmbientLightGain(void)
{
	uint8_t val;

	/* Read value from CONTROL register */
	if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
		return APDS9960_ERROR;
	}

	/* Shift and mask out ADRIVE bits */
	val &= 0b00000011;

	return val;
}

/**
 * @brief Sets the receiver gain for the ambient light sensor (ALS)
 *
 * Value    Gain
 *   0        1x
 *   1        4x
 *   2       16x
 *   3       64x
 *
 * @param[in] drive the value (0-3) for the gain
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setAmbientLightGain(uint8_t drive)
{
	uint8_t val;

	/* Read value from CONTROL register */
	if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
		return 0;
	}

	/* Set bits in register to given value */
	drive &= 0b00000011;
	val &= 0b11111100;
	val |= drive;

	/* Write register value back into CONTROL register */
	if( !wireWriteDataByte(APDS9960_CONTROL, val) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Get the current LED boost value
 *
 * Value  Boost Current
 *   0        100%
 *   1        150%
 *   2        200%
 *   3        300%
 *
 * @return The LED boost value. 0xFF on failure.
 */
uint8_t getLEDBoost(void)
{
	uint8_t val;

	/* Read value from CONFIG2 register */
	if( !wireReadDataByte(APDS9960_CONFIG2, &val) ) {
		return APDS9960_ERROR;
	}

	/* Shift and mask out LED_BOOST bits */
	val = (val >> 4) & 0b00000011;

	return val;
}

/**
 * @brief Sets the LED current boost value
 *
 * Value  Boost Current
 *   0        100%
 *   1        150%
 *   2        200%
 *   3        300%
 *
 * @param[in] drive the value (0-3) for current boost (100-300%)
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setLEDBoost(uint8_t boost)
{
	uint8_t val;

	/* Read value from CONFIG2 register */
	if( !wireReadDataByte(APDS9960_CONFIG2, &val) ) {
		return 0;
	}

	/* Set bits in register to given value */
	boost &= 0b00000011;
	boost = boost << 4;
	val &= 0b11001111;
	val |= boost;

	/* Write register value back into CONFIG2 register */
	if( !wireWriteDataByte(APDS9960_CONFIG2, val) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets proximity gain compensation enable
 *
 * @return 1 if compensation is enabled. 0 if not. 0xFF on error.
 */
uint8_t getProxGainCompEnable(void)
{
	uint8_t val;

	/* Read value from CONFIG3 register */
	if( !wireReadDataByte(APDS9960_CONFIG3, &val) ) {
		return APDS9960_ERROR;
	}

	/* Shift and mask out PCMP bits */
	val = (val >> 5) & 0b00000001;

	return val;
}

/**
 * @brief Sets the proximity gain compensation enable
 *
 * @param[in] enable 1 to enable compensation. 0 to disable compensation.
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setProxGainCompEnable(uint8_t enable)
{
	uint8_t val;

	/* Read value from CONFIG3 register */
	if( !wireReadDataByte(APDS9960_CONFIG3, &val) ) {
		return 0;
	}

	/* Set bits in register to given value */
	enable &= 0b00000001;
	enable = enable << 5;
	val &= 0b11011111;
	val |= enable;

	/* Write register value back into CONFIG3 register */
	if( !wireWriteDataByte(APDS9960_CONFIG3, val) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets the current mask for enabled/disabled proximity photodiodes
 *
 * 1 = disabled, 0 = enabled
 * Bit    Photodiode
 *  3       UP
 *  2       DOWN
 *  1       LEFT
 *  0       RIGHT
 *
 * @return Current proximity mask for photodiodes. 0xFF on error.
 */
uint8_t getProxPhotoMask(void)
{
	uint8_t val;

	/* Read value from CONFIG3 register */
	if( !wireReadDataByte(APDS9960_CONFIG3, &val) ) {
		return APDS9960_ERROR;
	}

	/* Mask out photodiode enable mask bits */
	val &= 0b00001111;

	return val;
}

/**
 * @brief Sets the mask for enabling/disabling proximity photodiodes
 *
 * 1 = disabled, 0 = enabled
 * Bit    Photodiode
 *  3       UP
 *  2       DOWN
 *  1       LEFT
 *  0       RIGHT
 *
 * @param[in] mask 4-bit mask value
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setProxPhotoMask(uint8_t mask)
{
	uint8_t val;

	/* Read value from CONFIG3 register */
	if( !wireReadDataByte(APDS9960_CONFIG3, &val) ) {
		return 0;
	}

	/* Set bits in register to given value */
	mask &= 0b00001111;
	val &= 0b11110000;
	val |= mask;

	/* Write register value back into CONFIG3 register */
	if( !wireWriteDataByte(APDS9960_CONFIG3, val) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets the entry proximity threshold for gesture sensing
 *
 * @return Current entry proximity threshold.
 */
uint8_t getGestureEnterThresh(void)
{
	uint8_t val;

	/* Read value from GPENTH register */
	if( !wireReadDataByte(APDS9960_GPENTH, &val) ) {
		val = 0;
	}

	return val;
}

/**
 * @brief Sets the entry proximity threshold for gesture sensing
 *
 * @param[in] threshold proximity value needed to start gesture mode
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setGestureEnterThresh(uint8_t threshold)
{
	if( !wireWriteDataByte(APDS9960_GPENTH, threshold) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets the exit proximity threshold for gesture sensing
 *
 * @return Current exit proximity threshold.
 */
uint8_t getGestureExitThresh(void)
{
	uint8_t val;

	/* Read value from GEXTH register */
	if( !wireReadDataByte(APDS9960_GEXTH, &val) ) {
		val = 0;
	}

	return val;
}

/**
 * @brief Sets the exit proximity threshold for gesture sensing
 *
 * @param[in] threshold proximity value needed to end gesture mode
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setGestureExitThresh(uint8_t threshold)
{
	if( !wireWriteDataByte(APDS9960_GEXTH, threshold) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets the gain of the photodiode during gesture mode
 *
 * Value    Gain
 *   0       1x
 *   1       2x
 *   2       4x
 *   3       8x
 *
 * @return the current photodiode gain. 0xFF on error.
 */
uint8_t getGestureGain(void)
{
	uint8_t val;

	/* Read value from GCONF2 register */
	if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
		return APDS9960_ERROR;
	}

	/* Shift and mask out GGAIN bits */
	val = (val >> 5) & 0b00000011;

	return val;
}

/**
 * @brief Sets the gain of the photodiode during gesture mode
 *
 * Value    Gain
 *   0       1x
 *   1       2x
 *   2       4x
 *   3       8x
 *
 * @param[in] gain the value for the photodiode gain
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setGestureGain(uint8_t gain)
{
	uint8_t val;

	/* Read value from GCONF2 register */
	if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
		return 0;
	}

	/* Set bits in register to given value */
	gain &= 0b00000011;
	gain = gain << 5;
	val &= 0b10011111;
	val |= gain;

	/* Write register value back into GCONF2 register */
	if( !wireWriteDataByte(APDS9960_GCONF2, val) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets the drive current of the LED during gesture mode
 *
 * Value    LED Current
 *   0        100 mA
 *   1         50 mA
 *   2         25 mA
 *   3         12.5 mA
 *
 * @return the LED drive current value. 0xFF on error.
 */
uint8_t getGestureLEDDrive(void)
{
	uint8_t val;

	/* Read value from GCONF2 register */
	if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
		return APDS9960_ERROR;
	}

	/* Shift and mask out GLDRIVE bits */
	val = (val >> 3) & 0b00000011;

	return val;
}

/**
 * @brief Sets the LED drive current during gesture mode
 *
 * Value    LED Current
 *   0        100 mA
 *   1         50 mA
 *   2         25 mA
 *   3         12.5 mA
 *
 * @param[in] drive the value for the LED drive current
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setGestureLEDDrive(uint8_t drive)
{
	uint8_t val;

	/* Read value from GCONF2 register */
	if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
		return 0;
	}

	/* Set bits in register to given value */
	drive &= 0b00000011;
	drive = drive << 3;
	val &= 0b11100111;
	val |= drive;

	/* Write register value back into GCONF2 register */
	if( !wireWriteDataByte(APDS9960_GCONF2, val) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets the time in low power mode between gesture detections
 *
 * Value    Wait time
 *   0          0 ms
 *   1          2.8 ms
 *   2          5.6 ms
 *   3          8.4 ms
 *   4         14.0 ms
 *   5         22.4 ms
 *   6         30.8 ms
 *   7         39.2 ms
 *
 * @return the current wait time between gestures. 0xFF on error.
 */
uint8_t getGestureWaitTime(void)
{
	uint8_t val;

	/* Read value from GCONF2 register */
	if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
		return APDS9960_ERROR;
	}

	/* Mask out GWTIME bits */
	val &= 0b00000111;

	return val;
}

/**
 * @brief Sets the time in low power mode between gesture detections
 *
 * Value    Wait time
 *   0          0 ms
 *   1          2.8 ms
 *   2          5.6 ms
 *   3          8.4 ms
 *   4         14.0 ms
 *   5         22.4 ms
 *   6         30.8 ms
 *   7         39.2 ms
 *
 * @param[in] the value for the wait time
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setGestureWaitTime(uint8_t time)
{
	uint8_t val;

	/* Read value from GCONF2 register */
	if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
		return 0;
	}

	/* Set bits in register to given value */
	time &= 0b00000111;
	val &= 0b11111000;
	val |= time;

	/* Write register value back into GCONF2 register */
	if( !wireWriteDataByte(APDS9960_GCONF2, val) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets the low threshold for ambient light interrupts
 *
 * @param[out] threshold current low threshold stored on the APDS-9960
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t getLightIntLowThreshold(uint16_t *threshold)
{
	uint8_t val_byte;
	*threshold = 0;

	/* Read value from ambient light low threshold, low byte register */
	if( !wireReadDataByte(APDS9960_AILTL, &val_byte) ) {
		return 0;
	}
	*threshold = val_byte;

	/* Read value from ambient light low threshold, high byte register */
	if( !wireReadDataByte(APDS9960_AILTH, &val_byte) ) {
		return 0;
	}
	*threshold = *threshold + ((uint16_t)val_byte << 8);

	return 1;
}

/**
 * @brief Sets the low threshold for ambient light interrupts
 *
 * @param[in] threshold low threshold value for interrupt to trigger
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setLightIntLowThreshold(uint16_t threshold)
{
	uint8_t val_low;
	uint8_t val_high;

	/* Break 16-bit threshold into 2 8-bit values */
	val_low = threshold & 0x00FF;
	val_high = (threshold & 0xFF00) >> 8;

	/* Write low byte */
	if( !wireWriteDataByte(APDS9960_AILTL, val_low) ) {
		return 0;
	}

	/* Write high byte */
	if( !wireWriteDataByte(APDS9960_AILTH, val_high) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets the high threshold for ambient light interrupts
 *
 * @param[out] threshold current low threshold stored on the APDS-9960
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t getLightIntHighThreshold(uint16_t *threshold)
{
	uint8_t val_byte;
	*threshold = 0;

	/* Read value from ambient light high threshold, low byte register */
	if( !wireReadDataByte(APDS9960_AIHTL, &val_byte) ) {
		return 0;
	}
	*threshold = val_byte;

	/* Read value from ambient light high threshold, high byte register */
	if( !wireReadDataByte(APDS9960_AIHTH, &val_byte) ) {
		return 0;
	}
	*threshold = *threshold + ((uint16_t)val_byte << 8);

	return 1;
}

/**
 * @brief Sets the high threshold for ambient light interrupts
 *
 * @param[in] threshold high threshold value for interrupt to trigger
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setLightIntHighThreshold(uint16_t threshold)
{
	uint8_t val_low;
	uint8_t val_high;

	/* Break 16-bit threshold into 2 8-bit values */
	val_low = threshold & 0x00FF;
	val_high = (threshold & 0xFF00) >> 8;

	/* Write low byte */
	if( !wireWriteDataByte(APDS9960_AIHTL, val_low) ) {
		return 0;
	}

	/* Write high byte */
	if( !wireWriteDataByte(APDS9960_AIHTH, val_high) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets the low threshold for proximity interrupts
 *
 * @param[out] threshold current low threshold stored on the APDS-9960
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t getProximityIntLowThreshold(uint8_t *threshold)
{
	*threshold = 0;

	/* Read value from proximity low threshold register */
	if( !wireReadDataByte(APDS9960_PILT, threshold) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Sets the low threshold for proximity interrupts
 *
 * @param[in] threshold low threshold value for interrupt to trigger
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setProximityIntLowThreshold(uint8_t threshold)
{

	/* Write threshold value to register */
	if( !wireWriteDataByte(APDS9960_PILT, threshold) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets the high threshold for proximity interrupts
 *
 * @param[out] threshold current low threshold stored on the APDS-9960
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t getProximityIntHighThreshold(uint8_t *threshold)
{
	*threshold = 0;

	/* Read value from proximity low threshold register */
	if( !wireReadDataByte(APDS9960_PIHT, threshold) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Sets the high threshold for proximity interrupts
 *
 * @param[in] threshold high threshold value for interrupt to trigger
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setProximityIntHighThreshold(uint8_t threshold)
{

	/* Write threshold value to register */
	if( !wireWriteDataByte(APDS9960_PIHT, threshold) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets if ambient light interrupts are enabled or not
 *
 * @return 1 if interrupts are enabled, 0 if not. 0xFF on error.
 */
uint8_t getAmbientLightIntEnable(void)
{
	uint8_t val;

	/* Read value from ENABLE register */
	if( !wireReadDataByte(APDS9960_ENABLE, &val) ) {
		return APDS9960_ERROR;
	}

	/* Shift and mask out AIEN bit */
	val = (val >> 4) & 0b00000001;

	return val;
}

/**
 * @brief Turns ambient light interrupts on or off
 *
 * @param[in] enable 1 to enable interrupts, 0 to turn them off
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setAmbientLightIntEnable(uint8_t enable)
{
	uint8_t val;

	/* Read value from ENABLE register */
	if( !wireReadDataByte(APDS9960_ENABLE, &val) ) {
		return 0;
	}

	/* Set bits in register to given value */
	enable &= 0b00000001;
	enable = enable << 4;
	val &= 0b11101111;
	val |= enable;

	/* Write register value back into ENABLE register */
	if( !wireWriteDataByte(APDS9960_ENABLE, val) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets if proximity interrupts are enabled or not
 *
 * @return 1 if interrupts are enabled, 0 if not. 0xFF on error.
 */
uint8_t getProximityIntEnable(void)
{
	uint8_t val;

	/* Read value from ENABLE register */
	if( !wireReadDataByte(APDS9960_ENABLE, &val) ) {
		return APDS9960_ERROR;
	}

	/* Shift and mask out PIEN bit */
	val = (val >> 5) & 0b00000001;

	return val;
}

/**
 * @brief Turns proximity interrupts on or off
 *
 * @param[in] enable 1 to enable interrupts, 0 to turn them off
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setProximityIntEnable(uint8_t enable)
{
	uint8_t val;

	/* Read value from ENABLE register */
	if( !wireReadDataByte(APDS9960_ENABLE, &val) ) {
		return 0;
	}

	/* Set bits in register to given value */
	enable &= 0b00000001;
	enable = enable << 5;
	val &= 0b11011111;
	val |= enable;

	/* Write register value back into ENABLE register */
	if( !wireWriteDataByte(APDS9960_ENABLE, val) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Gets if gesture interrupts are enabled or not
 *
 * @return 1 if interrupts are enabled, 0 if not. 0xFF on error.
 */
uint8_t getGestureIntEnable(void)
{
	uint8_t val;

	/* Read value from GCONF4 register */
	if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
		return APDS9960_ERROR;
	}

	/* Shift and mask out GIEN bit */
	val = (val >> 1) & 0b00000001;

	return val;
}

/**
 * @brief Turns gesture-related interrupts on or off
 *
 * @param[in] enable 1 to enable interrupts, 0 to turn them off
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setGestureIntEnable(uint8_t enable)
{
	uint8_t val;

	/* Read value from GCONF4 register */
	if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
		return 0;
	}

	/* Set bits in register to given value */
	enable &= 0b00000001;
	enable = enable << 1;
	val &= 0b11111101;
	val |= enable;

	/* Write register value back into GCONF4 register */
	if( !wireWriteDataByte(APDS9960_GCONF4, val) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Clears the ambient light interrupt
 *
 * @return 1 if operation completed successfully. 0 otherwise.
 */
uint8_t clearAmbientLightInt(void)
{
	uint8_t throwaway;
	if( !wireReadDataByte(APDS9960_AICLEAR, &throwaway) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Clears the proximity interrupt
 *
 * @return 1 if operation completed successfully. 0 otherwise.
 */
uint8_t clearProximityInt(void)
{
	uint8_t throwaway;
	if( !wireReadDataByte(APDS9960_PICLEAR, &throwaway) ) {
		return 0;
	}

	return 1;
}

/**
 * @brief Tells if the gesture state machine is currently running
 *
 * @return 1 if gesture state machine is running, 0 if not. 0xFF on error.
 */
uint8_t getGestureMode(void)
{
	uint8_t val;

	/* Read value from GCONF4 register */
	if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
		return APDS9960_ERROR;
	}

	/* Mask out GMODE bit */
	val &= 0b00000001;

	return val;
}

/**
 * @brief Tells the state machine to either enter or exit gesture state machine
 *
 * @param[in] mode 1 to enter gesture state machine, 0 to exit.
 * @return 1 if operation successful. 0 otherwise.
 */
uint8_t setGestureMode(uint8_t mode)
{
	uint8_t val;

	/* Read value from GCONF4 register */
	if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
		return 0;
	}

	/* Set bits in register to given value */
	mode &= 0b00000001;
	val &= 0b11111110;
	val |= mode;

	/* Write register value back into GCONF4 register */
	if( !wireWriteDataByte(APDS9960_GCONF4, val) ) {
		return 0;
	}

	return 1;
}

/*******************************************************************************
 * Raw I2C Reads and Writes
 ******************************************************************************/

/**
 * @brief Writes a single byte to the I2C device (no register)
 *
 * @param[in] val the 1-byte value to write to the I2C device
 * @return 1 if successful write operation. 0 otherwise.
 */
uint8_t wireWriteByte(uint8_t val)
{
	uint8_t ret;

	ret = I2C_WriteBytes(APDS9960_I2C_ADDR, &val, 1, 10);
	if(ret != IIC_SUCCESS) {
		return 0;
	}
	return 1;
}

/**
 * @brief Writes a single byte to the I2C device and specified register
 *
 * @param[in] reg the register in the I2C device to write to
 * @param[in] val the 1-byte value to write to the I2C device
 * @return 1 if successful write operation. 0 otherwise.
 */
uint8_t wireWriteDataByte(uint8_t reg, uint8_t val)
{
	uint8_t ret;
	uint8_t buffer[2];	//={reg,val};

	buffer[0] = reg;
	buffer[1] = val;
	ret = I2C_WriteBytes(APDS9960_I2C_ADDR, buffer, 2, 10);
	if(ret != IIC_SUCCESS) {
		return 0;
	}
	return 1;
}

/**
 * @brief Writes a block (array) of bytes to the I2C device and register
 *
 * @param[in] reg the register in the I2C device to write to
 * @param[in] val pointer to the beginning of the data byte array
 * @param[in] len the length (in bytes) of the data to write
 * @return 1 if successful write operation. 0 otherwise.
 */
uint8_t wireWriteDataBlock(  uint8_t reg,
                             uint8_t *val,
                             unsigned int len)
{
	uint8_t ret;
	int i;
	static uint8_t buffer[128];
	buffer[0] = reg;
	for(i = 0; (i < len)&&(i<sizeof(buffer)); i++) {
		buffer[1+i] = *val++;
	}
	ret = I2C_WriteBytes(APDS9960_I2C_ADDR,buffer,i+1,100);
	if(ret != IIC_SUCCESS) {
		return 0;
	}
	return 1;
}

/**
 * @brief Reads a single byte from the I2C device and specified register
 *
 * @param[in] reg the register to read from
 * @param[out] the value returned from the register
 * @return 1 if successful read operation. 0 otherwise.
 */
uint8_t wireReadDataByte(uint8_t reg, uint8_t *val)
{
	uint8_t ret;
	ret = I2C_WriteReadBytes(APDS9960_I2C_ADDR, &reg, 1, val, 1, 10);
	if(ret != IIC_SUCCESS) {
		return 0;
	}
	return 1;
}

/**
 * @brief Reads a block (array) of bytes from the I2C device and register
 *
 * @param[in] reg the register to read from
 * @param[out] val pointer to the beginning of the data
 * @param[in] len number of bytes to read
 * @return Number of bytes read. -1 on read error.
 */
int wireReadDataBlock(uint8_t reg, uint8_t *val, unsigned int len)
{
	uint8_t ret;
	ret = I2C_WriteReadBytes(APDS9960_I2C_ADDR,&reg,1,val,len,100);
	if(ret != IIC_SUCCESS) {
		return 0;
	}
	return len;
}





















