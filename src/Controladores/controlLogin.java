/*
SGI - Sistema Gestion de Inventarios 
Controlador Login
 */
package Controladores;

import Alertas.vistas.alertaInfo;
import Conexion.conexion;
import Conexion.encriptar;
import Modelos.modeloLogin;
import Vistas.vistaLogin;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Marco Coronado
 */
public class controlLogin {

    public boolean iniciarSesion(modeloLogin modelo) {

        conexion con = new conexion();
        String sql;
        ResultSet resultado;

        sql = "SELECT * FROM usuarios WHERE usu_usuario='" + modelo.getUsuario() + "'";
        resultado = con.consultar(sql);

        String usu_contrasena = null;
        String usu_rol = null;

        try {
            while (resultado.next()) {
                usu_contrasena = resultado.getString("usu_contrasena");
                usu_rol = resultado.getString("usu_rol");
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(vistaLogin.class.getName()).log(Level.SEVERE, null, ex);
        }

        String pass = encriptar.md5(modelo.getContrasena());

        if (usu_contrasena == null) {
            alertaInfo alerta = new alertaInfo("El usuario no existe");
            alerta.setVisible(true);
            return false;
        } else {
            if (pass.equals(usu_contrasena)) {
                modelo.setRol(usu_rol);
                return true;
            } else {
                alertaInfo alerta = new alertaInfo("La contraseña no es correcta");
                alerta.setVisible(true);
                return false;
            }
        }
    }

}
