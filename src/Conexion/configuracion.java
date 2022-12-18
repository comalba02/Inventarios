/*
PROYECTO SGI INVENTARIOS
Clase de Configuracion a Conexion Base de Datos
 */
package Conexion;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Alejandro Caidedo
 * @modify Marco Coronado
 */
public interface configuracion {

    public static String[] leerArchivo(String nombreArchivo) {

        File archivo = new File(nombreArchivo);
        String[] datos = new String[6];

        try {
            BufferedReader lector = new BufferedReader(new FileReader(archivo));
            try {
                String lectura = lector.readLine();
                int linea = 0;
                while (lectura != null) {
                    String[] dato = lectura.split(": ");
                    //System.out.println("lectura linea " + ++linea + ": " + dato[1]);
                    datos[linea++] = dato[1];
                    lectura = lector.readLine();
                }
                lector.close();
            } catch (IOException ex) {
                Logger.getLogger(configuracion.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (FileNotFoundException ex) {
            Logger.getLogger(configuracion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return datos;

    }

    String[] datos = leerArchivo("config/db.ini");
    String DRIVER = "com.mysql.jdbc.Driver";
    String SERVIDOR = datos[1];
    String PUERTO = datos[2];
    String BASE_DATOS = datos[3];
    String CONNECTION_URL = "jdbc:mysql://" + SERVIDOR + ":" + PUERTO + "/" + BASE_DATOS;
    String USUARIO = datos[4];
    String CONTRASENA = datos[5];

}
