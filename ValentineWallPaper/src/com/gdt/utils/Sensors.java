package com.gdt.utils;

import com.threed.jpct.Object3D;
import com.threed.jpct.util.Overlay;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.util.Log;
import android.view.Display;
import android.view.Surface;
import android.view.WindowManager;

public class Sensors {
	private static Sensors _instance = null;
	//
	private Display mDisplay;
	private WindowManager mWindowManager;
	private Context _context = null;
	//
	private SensorManager mSensorManager;
	//
	public Sensors() {
		//mAccelerometer = mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
	}
	//
	public static synchronized Sensors getSensors() {
        if (_instance == null)
            _instance = new Sensors();
        return _instance;
    }
	//
	public void setContext(Context context) {
		this._context = context;
		//
		mSensorManager = (SensorManager) _context.getSystemService(_context.SENSOR_SERVICE);
		mWindowManager = (WindowManager) _context.getSystemService(_context.WINDOW_SERVICE);
		mDisplay = mWindowManager.getDefaultDisplay();
	}
	//
	public void newAccel(Overlay fon) {
		AccelerometrEvent testEvents = new AccelerometrEvent(fon);
		testEvents.start();
	}
	///////////////////////////////////////////////////////////////////////////////////////////////////
	 class AccelerometrEvent implements SensorEventListener {
		 private Sensor Accel;
		 //
		 static final float ALPHA = 0.15f; // 15
		 //
		 private float[] accelVals;
		 //
		 private Overlay obj = null;
		 //
		 public AccelerometrEvent(Overlay fon) {
			this.obj = fon;
		}
		//
		 public void start() {
			 Accel = mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
			 //
			 mSensorManager.registerListener(this, Accel, SensorManager.SENSOR_DELAY_FASTEST);
		 }
		 //
		 public void finish() {
			  mSensorManager.unregisterListener(this);
		 }
		 //
		 public void onAccuracyChanged(Sensor arg0, int arg1) {}
		 //
		 public void onSensorChanged(SensorEvent event) {
			 Log.i("GDT", "getOrientation: "+mDisplay.getOrientation());
			 switch (mDisplay.getOrientation()) {
             case Surface.ROTATION_0:
                 //mSensorX = event.values[0];
                 //mSensorY = event.values[1];
                 break;
             case Surface.ROTATION_90:
                 //mSensorX = -event.values[1];
                 //mSensorY = event.values[0];
                 break;
             case Surface.ROTATION_180:
                 //mSensorX = -event.values[0];
                 //mSensorY = -event.values[1];
                 break;
             case Surface.ROTATION_270:
                 //mSensorX = event.values[1];
                 //mSensorY = -event.values[0];
                 break;
			 }
			 //
			 if (event.sensor.getType() != Sensor.TYPE_ACCELEROMETER)
	                return;
			 //
			 accelVals = lowPass( event.values, accelVals);
			 //
			 int offset = 50;
			 
			 float rX = Math.round(accelVals[0] * 100);
			 float rY = Math.round(accelVals[1] * 100);
			 
			 float roundX = rX / 100;
			 float roundY = rY / 100;
			 
			 int tlX = -offset - (int) (roundY * 7);
			 int tlY = -offset - (int) (roundX * 7);
			 int brX = mDisplay.getWidth() + offset -(int) (roundY * 7);
			 int brY = mDisplay.getHeight() + offset -(int) (roundX * 7);
			 
			 Log.i("GDT", "_______________________________________________________");
			 //Log.i("GDT", "raw: "+event.values[0]+" : "+event.values[1]+" : "+event.values[2]);
			 //Log.i("GDT", "lowPass: "+accelVals[0]+" : "+accelVals[1]+" : "+accelVals[2]+", round: "+roundY);
			 Log.i("GDT", "tlX: "+tlX+", tlY: "+tlY+", brX: "+brX+", brY: "+brY);
			 //
			 if(obj != null) {
				 obj.setNewCoordinates(tlX, tlY, brX, brY);
			 }
			 //
			 /*if(obj != null) {
				 float yOffset = event.values[0];
				 float xOffset = event.values[1];
				 float zOffset = event.values[2];
				 //Log.i("GDT", "pos: "+event.values[0]+" : "+event.values[1]+" : "+event.values[2]);
				 //Log.i("GDT","accuracy: "+event.accuracy+", timestamp: "+event.timestamp);
				 if(yOffset - curPosY > 2 || yOffset - curPosY < 2 && yOffset - curPosY != 00){
					 //Log.i("GDT", "new pos: "+yOffset + curPosY);
					 curPosY = (int) yOffset;
					 //update();
				 }
			 }*/
			 //Log.i("GDT", "sensor__ mSensorX: "+event.values[0]+", mSensorY: "+event.values[1]);
		 }
		 //
		 protected float[] lowPass( float[] input, float[] output ) {
				if ( output == null ) return input;
				
				for ( int i=0; i<input.length; i++ ) {
					output[i] = output[i] + ALPHA * (input[i] - output[i]);
				}
				return output;
			}
		 //
		 public void update() {
			 //obj.setNewCoordinates(-50, -50-(int) (curPosY * 7), mDisplay.getWidth()+50, mDisplay.getHeight()+50 -(int) (curPosY * 7));
		 }
		 //
	 }
	///////////////////////////////////////////////////////////////////////////////////////////////////
}