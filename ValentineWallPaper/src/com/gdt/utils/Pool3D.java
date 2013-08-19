package com.gdt.utils;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Vector;
import java.util.concurrent.Semaphore;

import com.threed.jpct.Object3D;

import com.gdt.utils.ICreator;

public class Pool3D<T> {
    private Vector<T> pool; // Список объектов в пуле
    private int count;      // Текущее число объектов
    private int max;        // Максимальное число объектов в пуле 
    private Semaphore semaphore;    // Нужен для потокобезопасности
    private ICreator<T> creator;    // Интерфейсов объектов в пуле

    /// <summary>
    /// Длинна списка доступных объектов из пула
    /// </summary>
    //public int Size {
        //return pool.Count;
    //}

    /// <summary>
    /// Максимальное число объектов в пуле 
    /// </summary>
   // public int Max {
        //return this.max;
    //}

    /// <summary>
    /// Текущее число объектов
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
    /// Удаляет объект из списка объектов, находящихся в пуле
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
    /// Возвращает объект в пул объектов
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