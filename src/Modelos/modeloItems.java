/*
SGI - Sistema Gestion de Inventarios 
Modelo Items
*/

package Modelos;

/**
 *
 * @author Marco Coronado
 */

public class modeloItems {

    private String id;
    private String nombre;
    private String descripcion;
    private String categoria;
    private String disponible;

    public modeloItems() {
    }

    public modeloItems(String id, String nombre, String descripcion, String categoria, String disponible) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.categoria = categoria;
        this.disponible = disponible;
    }

    public modeloItems(String id, String nombre, String descripcion, String categoria) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.categoria = categoria;
    }

    
    public String getDisponible() {
        return disponible;
    }

    public void setDisponible(String disponible) {
        this.disponible = disponible;
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

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    @Override
    public String toString() {
        return "modeloItems{" + "id=" + id + ", nombre=" + nombre + ", descripcion=" + descripcion + ", categoria=" + categoria + ", disponible=" + disponible + '}';
    }

   
}
