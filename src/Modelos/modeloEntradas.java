/*
SGI - Sistema Gestion de Inventarios 
Modelo Entradas
 */

package Modelos;

/**
 *
 * @author Marco Coronado
 */
public class modeloEntradas {

   private String id;
   private String documento;
   private String inventario;
   private String cantidad;

    public modeloEntradas() {
    }

    public modeloEntradas(String id, String documento, String Inventario, String cantidad) {
        this.id = id;
        this.documento = documento;
        this.inventario = inventario;
        this.cantidad = cantidad;
    }

    public modeloEntradas(String id, String inventario, String cantidad) {
        this.id = id;
        this.inventario = inventario;
        this.cantidad = cantidad;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String Documento) {
        this.documento = Documento;
    }

    public String getInventario() {
        return inventario;
    }

    public void setInventario(String Inventario) {
        this.inventario = Inventario;
    }

    public String getCantidad() {
        return cantidad;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }

    @Override
    public String toString() {
        return "modeloEntradas{" + "id=" + id + ", Documento=" + documento + ", Inventario=" + inventario + ", cantidad=" + cantidad + '}';
    }

}
