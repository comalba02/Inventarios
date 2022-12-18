/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

/**
 *
 * @author Angela
 */

//CLASE
public class modeloSalidas {
    //ATRIBUTOS
    private String id;
    private String documento;
    private String inventario;
    private String cantidad;

    
    //CONSTRUCTOR

    public modeloSalidas() {
    }

    public modeloSalidas(String id, String documento, String inventario, String cantidad) {
        this.id = id;
        this.documento = documento;
        this.inventario = inventario;
        this.cantidad = cantidad;
    }

    public modeloSalidas(String id, String inventario, String cantidad) {
        this.id = id;
        this.inventario = inventario;
        this.cantidad = cantidad;
    }
    
    
    //GETTERS & SETTERS
    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * @return the documento
     */
    public String getDocumento() {
        return documento;
    }

    /**
     * @param documento the documento to set
     */
    public void setDocumento(String documento) {
        this.documento = documento;
    }

    /**
     * @return the inventario
     */
    public String getInventario() {
        return inventario;
    }

    /**
     * @param inventario the inventario to set
     */
    public void setInventario(String inventario) {
        this.inventario = inventario;
    }

    /**
     * @return the cantidad
     */
    public String getCantidad() {
        return cantidad;
    }

    /**
     * @param cantidad the cantidad to set
     */
    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }
    
    
    //TO STRING

    @Override
    public String toString() {
        return super.toString(); //To change body of generated methods, choose Tools | Templates.
    }
}
