package com.gdt.utils;

import com.threed.jpct.Object3D;
import com.threed.jpct.Primitives;
import com.threed.jpct.World;
import com.threed.jpct.util.Overlay;

import com.gdt.utils.Textures;

public class ObjectsFactory {
	//
	private Object3D cube1 = null;
	//
	public ObjectsFactory(Textures textureLib) {
		// TODO Auto-generated constructor stub
	}
	//
	public Overlay getFon(World world, int i, int j, int _width, int _height, String string, boolean b) {// TODO: add texture name
		int offset = 50;
		Overlay fon = new Overlay(world, i-offset, j-offset, _width+offset, _height+offset, string, b);
		fon.setDepth(100);
		//
		return fon;
	}
	//
	private void ttt(){
		cube1 = Primitives.getPlane(8, 5);
		cube1.setTransparencyMode(Object3D.TRANSPARENCY_MODE_ADD);
		//cube1.calcTextureWrapSpherical();
		cube1.setTexture("texture2");
		cube1.setTransparency(10);
		cube1.strip();
		cube1.build();
	}
	
}

