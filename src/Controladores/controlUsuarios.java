/*
SGI - Sistema Gestion de Inventarios 
Controlador Usuarios
 */
package Controladores;

import Alertas.vistas.alertaInfo;
import Conexion.conexion;
import Conexion.encriptar;
import Modelos.modeloEmpleados;
import Modelos.modeloRoles;
import Modelos.modeloUsuarios;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.awt.Desktop;
import java.awt.Font;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author marco.coronado
 */
public class controlUsuarios {

    public String contar() {

        conexion con = new conexion();
        String sql = "SELECT COUNT(`usu_id`) + 1 AS ID FROM usuarios";
        ResultSet rs = con.consultar(sql);
        try {
            while (rs.next()) {
                String codigo = Integer.toString(rs.getInt("ID"));
                return codigo;
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public String empresa() {

        conexion con = new conexion();
        String sql = "SELECT `empr_nombre` AS EMPRESA FROM `empresa` WHERE 1";
        ResultSet rs = con.consultar(sql);
        try {
            while (rs.next()) {
                String empresa = rs.getString("EMPRESA");
                return empresa;
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public List<modeloEmpleados> empleados() {

        conexion con = new conexion();

        String sqlEmpleados = "SELECT * FROM `empleados`";
        ResultSet rsEmpleados = con.consultar(sqlEmpleados);

        modeloEmpleados modEmpleados = new modeloEmpleados();
        List<modeloEmpleados> empleados = new ArrayList<modeloEmpleados>();
        try {
            while (rsEmpleados.next()) {
                String id = rsEmpleados.getString("emp_id");
                String sqlUsuarios = "SELECT * FROM `usuarios`";
                ResultSet rsUsuarios = con.consultar(sqlUsuarios);
                String nombre = rsEmpleados.getString("emp_nombre");
                modEmpleados = new modeloEmpleados(id, nombre);
                empleados.add(modEmpleados);

            }
        } catch (SQLException ex) {
            Logger.getLogger(controlUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        }
        return empleados;

    }

    public List<modeloRoles> roles() {

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
            Logger.getLogger(controlUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        }
        return roles;

    }

    public void crearXLS() {
        try {
            File myFile = new File("plantillas/Usuarios.xlsx");
            Desktop.getDesktop().open(myFile);
        } catch (IOException ex) {
            Logger.getLogger(controlUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private boolean verificar(String empleado) {

        conexion con = new conexion();
        con.getConnection();

        String sqlVerificar = "SELECT * from `vista_usuarios` WHERE Empleado = '" + empleado + "'";
        ResultSet rs = con.consultar(sqlVerificar);
        try {
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;

    }

    public boolean crearUsuario(modeloUsuarios modelo) {

        conexion con = new conexion();
        String empleado = null;
        String rol = null;
        String sql = null;

        List<modeloEmpleados> empleados = empleados();
        for (int i = 0; i < empleados.size(); i++) {
            if (modelo.getEmp().equals(empleados.get(i).getNombre())) {
                empleado = empleados.get(i).getId();
            }

        }

        List<modeloRoles> roles = roles();
        for (int i = 0; i < roles.size(); i++) {
            if (modelo.getRol().equals(roles.get(i).getNombre())) {
                rol = roles.get(i).getId();
            }

        }

        int id = Integer.parseInt(contar());

        if (Integer.parseInt(modelo.getId()) < id) {

            sql = "UPDATE usuarios "
                    + "SET usu_usuario='" + modelo.getUsuario() + "', "
                    + "usu_rol='" + rol + "' "
                    + "WHERE usu_id='" + modelo.getId() + "'";
        } else {
            if (verificar(modelo.getEmp())) {
                alertaInfo alerta = new alertaInfo("El empleado ya tiene usuario.");
                alerta.setVisible(true);
            } else {
                String contrasena = encriptar.md5(modelo.getContrasena());
                sql = "INSERT INTO `usuarios`"
                        + "(`usu_id`, "
                        + "`usu_emp`, "
                        + "`usu_rol`, "
                        + "`usu_usuario`, "
                        + "`usu_contrasena` )"
                        + "VALUES ("
                        + "'" + modelo.getId() + "',"
                        + "'" + empleado + "',"
                        + "'" + rol + "',"
                        + "'" + modelo.getUsuario() + "',"
                        + "'" + contrasena + "')";

            }
        }
        try {
            if (sql != null) {

                con.ejecutar(sql);
                return true;
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }

    public List<modeloUsuarios> Consultar(String buscar) {

        conexion con = new conexion();
        con.getConnection();

        String sqlUsuarios = "SELECT * from `vista_usuarios`WHERE Empleado LIKE '%" + buscar + "%' OR Usuario LIKE '%" + buscar + "%'";
        ResultSet rsUsuarios = con.consultar(sqlUsuarios);

        modeloUsuarios modUsuarios = new modeloUsuarios();
        List<modeloUsuarios> usuarios = new ArrayList<modeloUsuarios>();
        try {
            while (rsUsuarios.next()) {
                String idUsuario = rsUsuarios.getString("Id");
                String empleadoUsuario = rsUsuarios.getString("Empleado");
                String nombreUsuario = rsUsuarios.getString("Usuario");
                String rolUsuario = rsUsuarios.getString("Rol");
                modUsuarios = new modeloUsuarios(idUsuario, empleadoUsuario, rolUsuario, nombreUsuario);
                usuarios.add(modUsuarios);
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        }

        return usuarios;

    }

    public void crearPDF() {

        Document documento = new Document(PageSize.LEGAL.rotate(), 25, 25, 25, 25);
        DateTimeFormatter fechaCompleta = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String fecha = fechaCompleta.format(LocalDateTime.now());

        FileOutputStream ficheroPDF;
        try {
            ficheroPDF = new FileOutputStream("reportes/Usuarios.pdf");
            PdfWriter.getInstance(documento, ficheroPDF);
            Image logo = Image.getInstance("imagenes/logo.png");
            documento.open();
            documento.add(logo);

            Paragraph titulo1 = new Paragraph("Listado de Usuarios",
                    FontFactory.getFont("arial",
                            22,
                            Font.BOLD,
                            BaseColor.BLACK
                    )
            );

            Paragraph titulo2 = new Paragraph("Fecha: " + fecha + "\n\n",
                    FontFactory.getFont("arial",
                            18,
                            BaseColor.BLACK
                    )
            );

            titulo1.setAlignment(Paragraph.ALIGN_CENTER);
            documento.add(titulo1);
            titulo2.setAlignment(Paragraph.ALIGN_CENTER);
            documento.add(titulo2);

            PdfPTable tabla = new PdfPTable(4);
            float[] values = new float[4];
            values[0] = 25;
            values[1] = 50;
            values[2] = 50;
            values[3] = 60;
            tabla.setWidths(values);

            BaseColor verde = new BaseColor(99, 167, 48);

            tabla.addCell(new Paragraph("Id", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Empleado", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Usuario", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Rol", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));

            List<modeloUsuarios> lista = new ArrayList<modeloUsuarios>();
            lista = Consultar("");

            for (int i = 0; i < lista.size(); i++) {
                tabla.addCell(lista.get(i).getId());
                tabla.addCell(lista.get(i).getEmp());
                tabla.addCell(lista.get(i).getUsuario());
                tabla.addCell(lista.get(i).getRol());
            }

            documento.add(tabla);

            documento.close();

            File myFile = new File("reportes/Usuarios.pdf");
            Desktop.getDesktop().open(myFile);

        } catch (FileNotFoundException ex) {
            Logger.getLogger(controlUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        } catch (DocumentException | IOException ex) {
            Logger.getLogger(controlUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
