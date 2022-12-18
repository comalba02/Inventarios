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
public class modeloDocumentoEn {

    String id;
    String fecha;
    String Usuario;

    public modeloDocumentoEn() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getUsuario() {
        return Usuario;
    }

    public void setUsuario(String Usuario) {
        this.Usuario = Usuario;
    }
    
    

    public modeloDocumentoEn(String id, String fecha, String Usuario) {
        this.id = id;
        this.fecha = fecha;
        this.Usuario = Usuario;
    }

    @Override
    public String toString() {
        return "modeloDocumentoEn{" + "id=" + id + ", fecha=" + fecha + ", Usuario=" + Usuario + '}';
    }

    
    

}
