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
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

public class GyroscopeSupportedFunction implements FREFunction {

	@Override
	public FREObject call(FREContext ctx, FREObject[] args) {
		
		FREObject retVal = null;
		
		Log.i("GyroscopeSupportFunction", "call");
		GyroscopeExtensionContext gyroExtCtx = (GyroscopeExtensionContext)ctx;
		Sensor gyroscope = gyroExtCtx.getGyroscope();
		Boolean haveGyroscope = false;
		
		if(gyroscope != null){
			haveGyroscope = true;
		}

		try {
			retVal = FREObject.newObject(haveGyroscope);
		}
		catch (FREWrongThreadException e) { 
			Log.e("GyroscopeSupportFunction", e.getMessage());
			return null;
		}
		
		return retVal;
	}

}
