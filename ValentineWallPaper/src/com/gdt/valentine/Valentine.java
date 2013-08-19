package com.gdt.valentine;

import java.util.Vector;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.DisplayMetrics;
import android.view.WindowManager;
import android.util.Log;

import com.threed.jpct.Camera;
import com.threed.jpct.FrameBuffer;
import com.threed.jpct.Light;
import com.threed.jpct.Object3D;
import com.threed.jpct.Primitives;
import com.threed.jpct.RGBColor;
import com.threed.jpct.SimpleVector;
import com.threed.jpct.Texture;
import com.threed.jpct.TextureManager;
import com.threed.jpct.World;
import com.threed.jpct.util.BitmapHelper;
import com.threed.jpct.util.MemoryHelper;
import com.threed.jpct.util.Overlay;

import net.rbgrn.opengl.GLWallpaperService;

import com.gdt.utils.Textures;
import com.gdt.utils.ObjectsFactory;
import com.gdt.utils.Sensors;

public class Valentine implements GLWallpaperService.GLRenderer {
	public static String GDT = "GDT";
	//
	private SharedPreferences preferences_;
	private SettingsUpdater settingsUpdater;
	//
	private Context _context;
	private WindowManager mWindowManager;
	//
	private Textures textureLib;
	private ObjectsFactory objects;
	//
	private Vector _objects;
	//
	private FrameBuffer fb = null;
	private Camera cam = null;
	private World world = null;
	//
	private Light sun = null;
	private Object3D _center = null;
	//
	private Overlay _fon = null;
	//
	private int _height = 0;
	private int _width = 0;
	//
	private int numDisp = 1;
	private int curDisp = 1;
	//
	private int vect = 1;
	private int CURRENT_ROTATION = 45;
	private int STEP_ROTATION = 45;
	private float offsetX = 0;
	//
	public Valentine(Context context) {
		this._context = context;
		//
		DisplayMetrics metrics = new DisplayMetrics();
		mWindowManager = (WindowManager) this._context.getSystemService(this._context.WINDOW_SERVICE);
		mWindowManager.getDefaultDisplay().getMetrics(metrics);
		//
		this._width = metrics.widthPixels;
		this._height = metrics.heightPixels;
		//
		Sensors.getSensors().setContext(_context);
	}
	//
	private void calcDist() {
		if(numDisp < 3) {
			
		}
	}
	//
	public void onSurfaceCreated(GL10 gl, EGLConfig config) {
		if(TextureManager.getInstance().getTextureCount() <= (int) 1){
			textureLib = new Textures(this._context);
		}
		//
		_center = Primitives.getCube(5); //Object3D.createDummyObj();
		_center.setTexture("fon");
		_center.strip();
		_center.build();
		//
		objects = new ObjectsFactory(textureLib);
	}

	public void onSurfaceChanged(GL10 gl, int w, int h) {
		if (fb != null) {
			fb.dispose();
		}
		
		if(world != null){
			world.dispose();
		}
		
		if(_fon != null){
			_fon.dispose();
		}
		
		if(sun != null){
			sun.disable();
		}
		
		if(gl != null) {// OpenGL versions;
			fb = new FrameBuffer(gl, w, h);
			}else{
				fb = new FrameBuffer(w, h);
				}
		
		//
		world = new World();
		world.setAmbientLight(100, 100, 100);
		
		_fon = objects.getFon(world, 0, 0, _width, _height, "fon", true);
		Sensors.getSensors().newAccel(_fon);
		
		world.addObject(_center);
		
		sun = new Light(world);
		sun.setIntensity(250, 250, 250);
		
		cam = world.getCamera();
		
		cam.moveCamera(Camera.CAMERA_MOVEOUT, 50);
		cam.lookAt(_center.getTransformedCenter());
		//
		CURRENT_ROTATION = (int) cam.getYAxis().y;
		//
		SimpleVector sv = new SimpleVector();
		sv.set(_center.getTransformedCenter());
		sv.y -= 100;
		sv.z -= 100;
		sun.setPosition(sv);
		//
		MemoryHelper.compact();
	}
	//
	public void onTouchEvent(int x, int y) {
		//Log.i("______touch_____", "x: "+x+", y: "+y);
	}
	//
	public void onOffsetsChanged(float offset, float xStep) {
		if(offset - this.offsetX < 0) {
			vect = -1;
		}else{
			vect = 1;
		}
		//
		this.offsetX = offset;
		//
		int td = (int)((1 / xStep) * offset + 1);
		if(td != curDisp) {
			curDisp = td;
		}
		//
		numDisp = (int) ((1 / xStep) + 1);
		//
		if(cam != null) {
			//_fon.setNewCoordinates((int) (-150 * this.offsetX), 0, this._width + 100, this._height);
			//
			cam.moveCamera(Camera.CAMERA_MOVEIN, 50);
			cam.rotateAxis(new SimpleVector(0,vect,0), (float) 0.005 );//STEP_ROTATION
			cam.moveCamera(Camera.CAMERA_MOVEOUT, 50);
			//
			//Log.i("%%%%%%%", "%: "+((int)cam.getYAxis().y % 45 == 1)+", getPosition: "+cam.getPosition().getRotationMatrix().);
		}
	}
	//
	public void onDrawFrame(GL10 gl) {
		/*if(cam != null && cam.getYAxis().y != CURRENT_ROTATION) {
			cam.moveCamera(Camera.CAMERA_MOVEIN, 50);
			cam.rotateAxis(new SimpleVector(0,this.vect,0), STEP_ROTATION);
			cam.moveCamera(Camera.CAMERA_MOVEOUT, 50);
			//
			
			if(cam.getYAxis().y % STEP_ROTATION == 1) {
				CURRENT_ROTATION = (int) cam.getYAxis().y;
			}
		}*/
		
		
		//if(this.offsetX != MAX_ROTATION * ) {
			//float newPos = MAX_ROTATION * this.offsetX;
			//Log.i("moveCamera", "rotation: "+newPos);
			//cam.rotateY(newPos);
			//cam.moveCamera(new SimpleVector(cam.getPosition().x,cam.getPosition().y+positions[curPosition], cam.getPosition().z).normalize(), 5);
			//this.curPosition = this.offsetX;
		//}
		
		//cube1.rotateX((float) -0.005);
		
		/*float currScale = blya.getScale();
		Log.i("_____SCALE", "currScale: "+currScale);
		
		if(currScale > 5) {
			currScale -= (float) 0.009;
		}
		
		if(currScale <= 1) {
			currScale += (float) 0.009;
		}*/
		//blya.setScale(currScale);
		
		/*if (touchTurnUp != 0) {
			cube.rotateX(touchTurnUp);
			touchTurnUp = 0;
		}*/
		//
		//
		fb.clear();
		
		//_sky.render(world, fb);
		
		world.renderScene(fb);
		world.draw(fb);
		fb.display();
	}
	///////////////////////////////////////////////////////////////////////////////////////
	public void setSharedPreferences(SharedPreferences preferences)	{
		settingsUpdater = new SettingsUpdater(this);
		preferences_ = preferences;
		preferences_.registerOnSharedPreferenceChangeListener(settingsUpdater);
		settingsUpdater.onSharedPreferenceChanged(preferences_, null);
	}
	//
	private class SettingsUpdater implements SharedPreferences.OnSharedPreferenceChangeListener {
		private Valentine renderer_;
		
		public SettingsUpdater(Valentine renderer)
		{
			renderer_ = renderer;
		}
		
		public void onSharedPreferenceChanged(
				SharedPreferences sharedPreferences, String key) {
			try
			{
				int backgroundInt = sharedPreferences.getInt("backgroundColor", 0);
				int linesInt = sharedPreferences.getInt("linesColor", -1);
				
				//renderer_.setColors(backgroundInt, linesInt);
				
			}
			catch(final Exception e)
			{
				Log.e("_rendere_", "PREF init error: " + e);			
			}
		}
	}

}
