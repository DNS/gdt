package com.gdt.utils;

import android.content.Context;
import android.graphics.BitmapFactory;

import com.gdt.valentine.R;
import com.threed.jpct.Texture;
import com.threed.jpct.TextureManager;
import com.threed.jpct.util.BitmapHelper;

public class Textures {
	private Context _context;
	//
	public Textures(Context context) {
		this._context = context;
		
		TextureManager.getInstance().addTexture("fon", new Texture(BitmapFactory.decodeResource(this._context.getResources(), R.raw.street)));// fon
		//TextureManager.getInstance().addTexture("front", new Texture(BitmapFactory.decodeResource(this._context.getResources(), R.raw.fon)));
		//TextureManager.getInstance().addTexture("right", new Texture(BitmapFactory.decodeResource(this._context.getResources(), R.raw.fon)));
		//TextureManager.getInstance().addTexture("back", new Texture(BitmapFactory.decodeResource(this._context.getResources(), R.raw.fon)));
		//TextureManager.getInstance().addTexture("up", new Texture(BitmapFactory.decodeResource(this._context.getResources(), R.raw.fon)));
		//TextureManager.getInstance().addTexture("down", new Texture(BitmapFactory.decodeResource(this._context.getResources(), R.raw.fon)));
		
	}

	
}
