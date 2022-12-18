/*
SGI - Sistema Gestion de Inventarios 
Modelo Usuarios
 */

package Modelos;

/**
 *
 * @author Marco Coronado
 */

public class modeloUsuarios {
    //ATRIBUTOS
    private String id;
    private String emp;
    private String rol;
    private String usuario;
    private String contrasena; 

    
    public modeloUsuarios() {
    }

    public modeloUsuarios(String id, String emp, String rol, String usuario, String contrasena) {
        this.id = id;
        this.emp = emp;
        this.rol = rol;
        this.usuario = usuario;
        this.contrasena = contrasena;
    }
    
    public modeloUsuarios(String id, String emp, String rol, String usuario) {
        this.id = id;
        this.emp = emp;
        this.rol = rol;
        this.usuario = usuario;
    }

//    public modeloUsuarios(String emp, String rol, String usuario, String contrasena) {
//        this.emp = emp;
//        this.rol = rol;
//        this.usuario = usuario;
//        this.contrasena = contrasena;
//    }
    
    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmp() {
        return emp;
    }

    public void setEmp(String emp) {
        this.emp = emp;
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
        return "modeloUsuarios{" + "id=" + id + ", emp=" + emp + ", rol=" + rol + ", usuario=" + usuario + ", contrasena=" + contrasena + '}';
    }
    

}
