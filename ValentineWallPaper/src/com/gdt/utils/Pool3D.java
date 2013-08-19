package com.gdt.utils;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Vector;
import java.util.concurrent.Semaphore;

import com.threed.jpct.Object3D;

import com.gdt.utils.ICreator;

public class Pool3D<T> {
    private Vector<T> pool; // ������ �������� � ����
    private int count;      // ������� ����� ��������
    private int max;        // ������������ ����� �������� � ���� 
    private Semaphore semaphore;    // ����� ��� ������������������
    private ICreator<T> creator;    // ����������� �������� � ����

    /// <summary>
    /// ������ ������ ��������� �������� �� ����
    /// </summary>
    //public int Size {
        //return pool.Count;
    //}

    /// <summary>
    /// ������������ ����� �������� � ���� 
    /// </summary>
   // public int Max {
        //return this.max;
    //}

    /// <summary>
    /// ������� ����� ��������
    /// </summary>
    //public int Count {
        //return count;
    //}

	//
    public Pool3D(ICreator<T> creator, int maxCount) {
        this.creator = creator;
        max = maxCount;
        count = 0;
        pool = new Vector<T>();
        semaphore = new Semaphore(0);
    }
    
    //
    private T CreateObject() {
        T newObject = creator.Create();
        count++;
        return newObject;
    }
    
    //
    public T Take() {
    	
    	
        /*lock (pool) {
            T thisObject = RemoveObject();
            if (thisObject != null)
                return thisObject;

            if (count < max)
                return CreateObject();
        }
        semaphore.wait();*/
        return Take();
    }

    

	/// <summary>
    /// ������� ������ �� ������ ��������, ����������� � ����
    /// </summary>
    /// <returns></returns>
    /*private T RemoveObject() {
        while (pool.Count > 0) {
            var refThis = (WeakReference)pool[pool.Count - 1];
            pool.RemoveAt(pool.Count - 1);
            var thisObject = (T)refThis.Target;
            if (thisObject != null)
                return thisObject;
            count--;
        }
        return null;
    }*/

    /// <summary>
    /// ���������� ������ � ��� ��������
    /// </summary>
    /// <param name="obj"></param>
    /*public void Put(T obj) {
        if (obj == null)
            throw new NullReferenceException();
        lock (pool) {
            var refThis = new WeakReference(obj);            
            pool.Add(refThis);
            semaphore.Release();
        }
    }*/
}