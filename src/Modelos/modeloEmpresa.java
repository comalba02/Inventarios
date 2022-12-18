/*
PROYECTO SGI INVENTARIOS
Modelo Empresa
 */

package Modelos;

/**
 *
 * @author Marco Coronado
 */

public class modeloEmpresa {
    
    private String id;
    private String nombre;
    private String nit;

    public modeloEmpresa() {
    }

    public modeloEmpresa(String id, String nombre, String nit) {
        this.id = id;
        this.nombre = nombre;
        this.nit = nit;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
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
        return "modeloEmpresa{" + "id=" + id + ", nombre=" + nombre + ", nit=" + nit + '}';
    }
    
}
