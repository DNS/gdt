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
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

public class GyroscopeStartFunction implements FREFunction {

	@Override
	public FREObject call(FREContext ctx, FREObject[] args) {

		Log.i("GyroscopeStartFunction", "call");

		FREObject retVal;
		retVal = null;
		GyroscopeExtensionContext gyroExtCtx = (GyroscopeExtensionContext)ctx;
		Sensor gyroscope = gyroExtCtx.getGyroscope();
		SensorManager sensorManager = gyroExtCtx.getSensorManager();

		try {

			if (gyroscope != null) {
				sensorManager.registerListener(((GyroscopeExtensionContext)ctx).getListener(), gyroscope, args[0].getAsInt());
				retVal = FREObject.newObject(true);
			}
			else {
				retVal = FREObject.newObject(false);
			}

		// In the catch blocks, return null since calling FREObject.newObject(false) may not be safe.
		// The ActionScript method call("gyroscopeStart") will return null.

		} catch (FREWrongThreadException e) {
			Log.e("GyroscopeStartFunction", e.getMessage());
			return null;
		} catch (IllegalStateException e) {
			Log.e("GyroscopeStartFunction", e.getMessage());
			return null;
		} catch (FRETypeMismatchException e) {
			Log.e("GyroscopeStartFunction", e.getMessage());
			return null;
		} catch (FREInvalidObjectException e) {
			Log.e("GyroscopeStartFunction", e.getMessage());
			return null;
		}

		return retVal;
	}

}
