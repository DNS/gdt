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
 
#import "FlashRuntimeExtensions.h"
#import <CoreMotion/CoreMotion.h>

CMMotionManager* motionManager = nil;
NSOperationQueue* opQ = nil; 

// startGyro() 
//
// Called from the ActionScript constructor of class Gyroscope.

FREObject ADBE_GYRO_startGyro(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {

    NSLog(@"Entering startGyro()");
	
    BOOL ret = NO;
	FREObject retVal;
    
	if (motionManager != nil) {
    
		if (motionManager.gyroAvailable) {
        
				CMGyroHandler gyroHandler = ^ (CMGyroData *gyroData, NSError *error) {
                
					if (ctx != nil) {
						CMRotationRate rotate = gyroData.rotationRate;                        
						NSString *myStr = [NSString stringWithFormat:@"%f&%f&%f",rotate.x,rotate.y,rotate.z]; 
						NSLog(@"%@",myStr);
                        
						if(ctx != nil) {
							FREDispatchStatusEventAsync(ctx, (uint8_t*)"CHANGE", (uint8_t*)[myStr UTF8String]); 
						}
                        
						myStr = nil;
					}
					
				};
                
			    [motionManager startGyroUpdatesToQueue:opQ withHandler:gyroHandler]; 
			    NSLog(@"Gyroscope started");
			    ret = YES;
		} 
        
        else {
        
			[motionManager release];
			ret = NO;
		}
        
	}
    
    else {
    
		ret = NO;
		NSLog(@"motionManager was NULL. Something is very wrong");
	}

	FRENewObjectFromBool(ret, &retVal);
    
    NSLog(@"Exiting startGyro()");
    
	return retVal;
}



// stopGyro() 
//
// Called from the dispose() method of ActionScript class Gyroscope.

FREObject ADBE_GYRO_stopGyro(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {

    NSLog(@"Entering stopGyro()");
    BOOL ret = NO;
    
	FREObject retVal;
    
	[motionManager stopGyroUpdates];
    
	NSLog(@"gyroScope Stopped");

	FRENewObjectFromBool(ret,&retVal);  
	
    NSLog(@"Exiting stopGyro()");
	
	return retVal; 
}



// supportGyro() 
//
// Called from the isSupported() method of ActionScript class Gyroscope.

FREObject ADBE_GYRO_supportGyro(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {

	NSLog(@"Entering supportGyro()");
    
	BOOL ret = NO;
    
	if (motionManager != nil) {
    
		ret = motionManager.gyroAvailable;
	}
    
	FREObject retVal;
	FRENewObjectFromBool(ret, &retVal);
    
    NSLog(@"Exiting supportGyro()");
	return retVal;
}



// initStub()
//
// An init function is necessary in the Android implementation of this extension.
// Therefore, an analogous function is necessary in the iOS implementation to make
// the ActionScript interface identical for all implementations.
// However, the iOS implementation has nothing to do.

FREObject ADBE_GYRO_initStub(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {

	NSLog(@"init Stub Called");
	return nil;
}



// ContextInitializer() 
//
// The context initializer is called when the runtime creates the extension context instance.

void ADBE_GYRO_ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, 
						   uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
                           
    NSLog(@"Entering ContextInitializer()");
                           
	*numFunctionsToTest = 4;
	FRENamedFunction* func = (FRENamedFunction*)malloc(sizeof(FRENamedFunction) * 4);
    
	func[0].name = (const uint8_t*)"gyroscopeStart";
	func[0].functionData = NULL;
	func[0].function = &ADBE_GYRO_startGyro;

	func[1].name = (const uint8_t*)"gyroscopeStop";
	func[1].functionData = NULL;
	func[1].function = &ADBE_GYRO_stopGyro;

	func[2].name = (const uint8_t*)"gyroscopeSupport";
	func[2].functionData = NULL;
	func[2].function = &ADBE_GYRO_supportGyro;
	
	func[3].name = (const uint8_t*)"init";
	func[3].functionData = NULL;
	func[3].function = &ADBE_GYRO_initStub;
	
	*functionsToSet = func; 
	
	motionManager = [[CMMotionManager alloc] init];
    motionManager.gyroUpdateInterval = 0;
	
	opQ = [[NSOperationQueue currentQueue] retain];  
	
    NSLog(@"Exiting ContextInitializer()");
}



// ContextFinalizer()
//
// The context finalizer is called when the extension's ActionScript code
// calls the ExtensionContext instance's dispose() method.
// If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls
// ContextFinalizer().

void ADBE_GYRO_ContextFinalizer(FREContext ctx) { 

    NSLog(@"Entering ContextFinalizer()");
    
	[motionManager release];
	[opQ release];
	motionManager = nil;
	opQ = nil;
    
    NSLog(@"Exiting ContextFinalizer()");
	
}



// ExtInitializer()
//
// The extension initializer is called the first time the ActionScript side of the extension
// calls ExtensionContext.createExtensionContext() for any context.

void ADBEExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, 
					FREContextFinalizer* ctxFinalizerToSet) {
                    
    NSLog(@"Entering ExtInitializer()");                    
                    
	*extDataToSet = NULL;
	*ctxInitializerToSet = &ADBE_GYRO_ContextInitializer; 
	*ctxFinalizerToSet = &ADBE_GYRO_ContextFinalizer;
    
    NSLog(@"Exiting ExtInitializer()"); 
}  



// ExtFinalizer()
//
// The extension finalizer is called when the runtime unloads the extension. 
// However, it is not always called.

void ADBEExtFinalizer(void* extData) {

    NSLog(@"Entering ExtFinalizer()");
	return;
}
