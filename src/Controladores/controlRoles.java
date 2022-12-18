/*
SGI - Sistema Gestion de Inventarios 
Controlador Roles
 */ 
package Controladores;

import Conexion.conexion;
import Modelos.modeloRoles;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Marco Coronado
 */
public class controlRoles {

    public static List<modeloRoles> roles() {
        
        conexion con = new conexion();

        String sqlRoles = "SELECT * from `roles`";
        ResultSet rsRoles = con.consultar(sqlRoles);

        modeloRoles modRoles = new modeloRoles();
        List<modeloRoles> roles = new ArrayList<modeloRoles>();
        try {
            while (rsRoles.next()) {
                String id = rsRoles.getString("rol_id");
                String nombre = rsRoles.getString("rol_nombre");
                modRoles = new modeloRoles(id, nombre);
                roles.add(modRoles);
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlRoles.class.getName()).log(Level.SEVERE, null, ex);
        }
        return roles;
        
    }

}
