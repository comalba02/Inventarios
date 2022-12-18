/*
PROYECTO SGI INVENTARIOS
Modelo Documentos
 */

package Modelos;

/**
 *
 * @author Marco Coronado
 */

public class modeloDocumentos {
    
    private String id;
    private String tipo;
    private String prefijo;

    public modeloDocumentos() {
    }

    public modeloDocumentos(String id, String tipo, String prefijo) {
        this.id = id;
        this.tipo = tipo;
        this.prefijo = prefijo;
    }

    public String getPrefijo() {
        return prefijo;
    }

    public void setPrefijo(String prefijo) {
        this.prefijo = prefijo;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    @Override
    public String toString() {
        return "modeloDocumentos{" + "id=" + id + ", tipo=" + tipo + ", prefijo=" + prefijo + '}';
    }
    
}
