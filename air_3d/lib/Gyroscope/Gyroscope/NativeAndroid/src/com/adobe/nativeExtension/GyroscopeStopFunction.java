////////////////////////////////////////////////////////////////////////////////////////////////////////	
//	ADOBE SYSTEMS INCORPORATED																		  //
//	Copyright 2011 Adobe Systems Incorporated														  //
//	All Rights Reserved.																			  //
//																									  //
//	NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the		  //
//	terms of the Adobe license agreement accompanying it.  If you have received this file from a	  //
//	source other than Adobe, then your use, modification, or distribution of it requires the prior	  //
//	written permission of Adobe.																	  //
////////////////////////////////////////////////////////////////////////////////////////////////////////

package com.adobe.nativeExtension;

import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

public class GyroscopeStopFunction implements FREFunction {

	@Override
	public FREObject call(FREContext ctx, FREObject[] args) {

		FREObject retVal = null;
		GyroscopeExtensionContext gyroExtCtx = (GyroscopeExtensionContext)ctx;	
		Sensor gyroscope = gyroExtCtx.getGyroscope();
		SensorManager sensorManager = gyroExtCtx.getSensorManager();

		try {

			if (gyroscope != null) {
				sensorManager.unregisterListener(gyroExtCtx.getListener());
				retVal = FREObject.newObject(true);
				Log.i("GyroscopeStopFunction", "call");
			}
			else {
				retVal = FREObject.newObject(false);
			}
			
		} catch (FREWrongThreadException e) {
			Log.e("GyroscopeStopFunction", e.getMessage());
			return null;
		}

		return retVal;
	}

}
