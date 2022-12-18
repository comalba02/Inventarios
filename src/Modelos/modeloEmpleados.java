/*
PROYECTO SGI INVENTARIOS
Modelo Empleados
 */

package Modelos;

/**
 *
 * @author Marco Coronado
 */

public class modeloEmpleados {
    
    private String id;
    private String empresa;
    private String tipoDoc;
    private String documento;
    private String nombre;
    private String genero;
    private String correo;

    public modeloEmpleados() {
    }

    public modeloEmpleados(String id, String empresa, String tipoDoc, String documento, String nombre, String genero, String correo) {
        this.id = id;
        this.empresa = empresa;
        this.tipoDoc = tipoDoc;
        this.documento = documento;
        this.nombre = nombre;
        this.genero = genero;
        this.correo = correo;
    }

    public modeloEmpleados(String id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmpresa() {
        return empresa;
    }

    public void setEmpresa(String empresa) {
        this.empresa = empresa;
    }

    public String getTipoDoc() {
        return tipoDoc;
    }

    public void setTipoDoc(String tipoDoc) {
        this.tipoDoc = tipoDoc;
    }

    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento = documento;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    @Override
    public String toString() {
        return "modeloEmpleados{" + "id=" + id + ", empresa=" + empresa + ", tipoDoc=" + tipoDoc + ", documento=" + documento + ", nombre=" + nombre + ", genero=" + genero + ", correo=" + correo + '}';
    }

}
