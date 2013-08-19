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
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.util.Log;

public class GyroscopeListener implements SensorEventListener {

	private GyroscopeExtensionContext ctx;



	public GyroscopeListener(GyroscopeExtensionContext ctx)
	{

			this.ctx = ctx;
	}



	@Override
	public void onAccuracyChanged(Sensor arg0, int arg1) {
		// TODO Auto-generated method stub

	}


	/* The Android OS calls this function when sensor values have changed.
	 * The sensor values are in the SensorEvent object's values field, which is an array of floats.
	 * The float values at values[0], values[1], and values[2] correspond to the x, y, and z axis values, respectively.
	 *
	 * This function dispatches an event to the ActionScript side of the extension.
	 * However, the dispatched event cannot contain an array of float values. It can only
	 * contain a string. Therefore, this function creates a string of the float values, delimited by ampersands (&).
	 *
	 * When the ActionScript side receives the event, it parses the string to recreate the x, y, z values.
	 * The AIR application receives the x, y, z values in events that the ActionScript side of the extension dispatches.
	 */
	@Override
	public void onSensorChanged(SensorEvent evt) {

		if(ctx != null) {

			StringBuilder s = new StringBuilder(Float.toString(evt.values[0]));

			s.append("&").append(Float.toString(evt.values[1])).append("&").append(Float.toString(evt.values[2]));

			Log.i("GyroscopeListener", s.toString());

			ctx.dispatchStatusEventAsync("CHANGE", s.toString());
		}
	}


	public void dispose(){
		Log.i("GyroscopeListener","dispose");
		this.ctx = null;
	}

}
