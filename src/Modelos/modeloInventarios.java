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
public class modeloInventarios {
    //ATRIBUTOS
    private String id;
    private String item;
    private String cantidad;
    
    
    //CONSTRUCTOR
    public modeloInventarios() {
    }

    public modeloInventarios(String id, String item, String cantidad) {
        this.id = id;
        this.item = item;
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
     * @return the item
     */
    public String getItem() {
        return item;
    }

    /**
     * @param item the item to set
     */
    public void setItem(String item) {
        this.item = item;
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
