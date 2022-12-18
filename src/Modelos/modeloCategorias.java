/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

/**
 *
 * @author Windows 10
 */
public class modeloCategorias {
    
   String id ;
   String nombre;
    
    public modeloCategorias() {
    }

    public modeloCategorias(String id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @Override
    public String toString() {
        return "modeloCategorias{" + "id=" + id + ", nombre=" + nombre + '}';
    }
    
    
}
