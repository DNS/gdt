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

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class GyroscopeExtension implements FREExtension {

	@Override
	public FREContext createContext(String ctxType) {

		Log.i("GyroscopeExtension", "createContext()");

		GyroscopeExtensionContext extCtx = new GyroscopeExtensionContext();
		return extCtx;
	}

	@Override
	public void dispose() {

		Log.i("GyroscopeExtension", "dispose()");
	}

	@Override
	public void initialize() {
		// TODO Auto-generated method stub

	}

}
