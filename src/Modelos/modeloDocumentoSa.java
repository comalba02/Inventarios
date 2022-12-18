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
public class modeloDocumentoSa {
    //ATRIBUTOS
    private String id;
    private String fecha;
    private String usuario;
    private String contrasena;
    
    
    //CONSTRUCTOR
    public modeloDocumentoSa() {
    }

    public modeloDocumentoSa(String id, String fecha, String usuario, String contrasena) {
        this.id = id;
        this.fecha = fecha;
        this.usuario = usuario;
        this.contrasena = contrasena;
    }

    
    //GETTERS AND SETTERS
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
     * @return the fecha
     */
    public String getFecha() {
        return fecha;
    }

    /**
     * @param fecha the fecha to set
     */
    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    /**
     * @return the usuario
     */
    public String getUsuario() {
        return usuario;
    }

    /**
     * @param usuario the usuario to set
     */
    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    /**
     * @return the contrasena
     */
    public String getContrasena() {
        return contrasena;
    }

    /**
     * @param contrasena the contrasena to set
     */
    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }
    
    
    //TO STRING

    @Override
    public String toString() {
        return super.toString(); //To change body of generated methods, choose Tools | Templates.
    }
}
