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

import java.util.HashMap;
import java.util.Map;

import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;


public class GyroscopeExtensionContext extends FREContext {

	 private SensorManager mSensorManager = null;
     private Sensor mGyroscope = null;
     private GyroscopeListener mListener = null;

	@Override
	public void dispose() {

		mGyroscope = null;
		mSensorManager = null;
		mListener.dispose();
		mListener = null;

		Log.i("GyroscopeExtensionContext", "dispose()");
	}

	@Override
	public Map<String, FREFunction> getFunctions() {

		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();

		functionMap.put("gyroscopeStart", new GyroscopeStartFunction() );
		functionMap.put("gyroscopeStop", new GyroscopeStopFunction() );
		functionMap.put("gyroscopeSupport", new GyroscopeSupportedFunction() );
		functionMap.put("init", new InitFunction() );

		return functionMap;
	}

	public void setSensorManager(SensorManager mSensorManager) {
		this.mSensorManager = mSensorManager;
	}

	public SensorManager getSensorManager() {
		return mSensorManager;
	}

	public void setGyroscope(Sensor mGyroscope) {
		this.mGyroscope = mGyroscope;
	}

	public Sensor getGyroscope() {
		return mGyroscope;
	}

	public void setListener(GyroscopeListener mListener) {
		this.mListener = mListener;
	}

	public GyroscopeListener getListener() {
		return mListener;
	}

}
