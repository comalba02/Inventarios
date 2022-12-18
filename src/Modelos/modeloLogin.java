/*
SGI - Sistema Gestion de Inventarios 
Modelo Login
 */

package Modelos;

/**
 *
 * @author Marco Coronado
 */

public class modeloLogin {
    
    private String usuario;
    private String contrasena;
    private String rol;

    public modeloLogin() {
    }
    
    public modeloLogin(String usuario, String contrasena) {
        this.usuario = usuario;
        this.contrasena = contrasena;
    }

    public modeloLogin(String usuario, String contrasena, String rol) {
        this.usuario = usuario;
        this.contrasena = contrasena;
        this.rol = rol;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    @Override
    public String toString() {
        return "modeloLogin{" + "usuario=" + usuario + ", contrasena=" + contrasena + ", rol=" + rol + '}';
    }
    
}
