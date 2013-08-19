package com.gdt.valentine;

import com.gdt.valentine.Valentine;

import net.rbgrn.opengl.GLWallpaperService;
import android.opengl.GLSurfaceView.EGLConfigChooser;
import android.opengl.GLSurfaceView.Renderer;
import android.util.Log;

public class ValentineWallpaperService extends GLWallpaperService {
	public static String SHARED_PREFS_NAME = "ValentineWallpaperService";
	
	public ValentineWallpaperService(){
		//
	}
	
	@Override
    public void onCreate() {
		super.onCreate();
    }
	//
	
	@Override
	public Engine onCreateEngine() {
		return new BaseWallpaperGLEngine();
	}
	//
	 protected class BaseWallpaperGLEngine extends GLEngine {
		 
         private Valentine mRenderer;

         public BaseWallpaperGLEngine() {
        	 mRenderer = new Valentine(this.getContext());
        	 
        	 this.setEGLConfigChooser(true);
        	 
        	 this.setRenderer(mRenderer);
        	 this.setRenderMode(RENDERMODE_CONTINUOUSLY);
         }

         // ===========================================================
         // Methods for/from SuperClass/Interfaces
         // ===========================================================

         /*@Override
         public Bundle onCommand(final String pAction, final int pX, final int pY, final int pZ, final Bundle pExtras, final boolean pResultRequested) {
                 if(pAction.equals(WallpaperManager.COMMAND_TAP)) {
                         BaseLiveWallpaperService.this.onTap(pX, pY);
                 } else if (pAction.equals(WallpaperManager.COMMAND_DROP)) {
                         BaseLiveWallpaperService.this.onDrop(pX, pY);
                 }

                 return super.onCommand(pAction, pX, pY, pZ, pExtras, pResultRequested);
         }*/

         @Override
         public void onResume() {
        	 super.onResume();
         }

         @Override
         public void onPause() {
        	 super.onPause();
         }

         @Override
         public void onDestroy() {
        	 super.onDestroy();
         }
	 }
}
