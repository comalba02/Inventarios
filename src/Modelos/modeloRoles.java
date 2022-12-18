/*
PROYECTO SGI INVENTARIOS
Modelo Roles
 */

package Modelos;

/**
 *
 * @author Marco Coronado
 */

public class modeloRoles {
    
    private String id;
    private String nombre;

    public modeloRoles() {
    }

    public modeloRoles(String id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "modeloRoles{" + "id=" + id + ", nombre=" + nombre + '}';
    }
    
}
