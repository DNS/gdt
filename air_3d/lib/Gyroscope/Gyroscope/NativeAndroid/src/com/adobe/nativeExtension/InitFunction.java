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

import android.app.Activity;
import android.hardware.Sensor;
import android.hardware.SensorManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class InitFunction implements FREFunction {

	@Override
	public FREObject call(FREContext ctx, FREObject[] args) {

		GyroscopeExtensionContext extCtx = (GyroscopeExtensionContext) ctx;

		SensorManager sm = (SensorManager)extCtx.getActivity().getSystemService(Activity.SENSOR_SERVICE);
		extCtx.setSensorManager(sm);
		extCtx.setGyroscope(sm.getDefaultSensor(Sensor.TYPE_GYROSCOPE));
		extCtx.setListener(new GyroscopeListener((GyroscopeExtensionContext)ctx));

		return null;
	}

}
