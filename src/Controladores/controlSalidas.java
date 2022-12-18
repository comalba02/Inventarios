/*
SGI - Sistema Gestion de Inventarios 
Controlador Entradas
 */
package Controladores;

import Conexion.conexion;
import Modelos.modeloEmpleados;
import Modelos.modeloSalidas;
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
 * @author Marco Coronado
 */
public class controlSalidas {

    public String contar() {

        conexion con = new conexion();
        String sql = "SELECT COUNT(`docsa_id`) + 1 AS ID FROM documento_sa";
        ResultSet rs = con.consultar(sql);
        try {
            while (rs.next()) {
                String codigo = Integer.toString(rs.getInt("ID"));
                return codigo;
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlEmpleados.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public String empleados(String empleado) {

        conexion con = new conexion();
        String sqlEmpleados = "SELECT emp_id FROM `empleados` WHERE emp_nombre = '" + empleado + "'";
        ResultSet rsEmpleados = con.consultar(sqlEmpleados);
        String idEmpleado = null;

        try {
            while (rsEmpleados.next()) {
                idEmpleado = rsEmpleados.getString("emp_id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlSalidas.class.getName()).log(Level.SEVERE, null, ex);
        }

        return idEmpleado;

    }

    public void crearDocumentoSalida(String docSalida, String usuario, String empleado) {

        conexion con = new conexion();
        String idUsuario = consultarUsuario(usuario);
        String idEmpleado = empleados(empleado);
        DateTimeFormatter fechaCompleta = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String fecha = fechaCompleta.format(LocalDateTime.now());
        String sql = "INSERT INTO `documento_sa` "
                + "(`docsa_id`, "
                + "`docsa_fecha`, "
                + "`docsa_usuario`, "
                + "`docsa_empleado`)"
                + "VALUES ("
                + "'" + docSalida + "', "
                + "'" + fecha + "', "
                + "'" + idUsuario + "', "
                + "'" + idEmpleado + "')";
        con.ejecutar(sql);

    }

    private String consultarUsuario(String usuario) {

        conexion con = new conexion();
        String sql;
        ResultSet resultado;
        String idUsuario = null;

        sql = "SELECT * FROM usuarios WHERE usu_usuario='" + usuario + "'";
        resultado = con.consultar(sql);

        try {
            while (resultado.next()) {
                idUsuario = resultado.getString("usu_id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlSalidas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return idUsuario;

    }

    public void crearSalidas(String docSalida, List<modeloSalidas> listaSalidas) {

        for (modeloSalidas salida : listaSalidas) {
            conexion con = new conexion();
            String sql = "INSERT INTO `salidas` "
                    + "(`sal_documento`, "
                    + "`sal_inventario`, "
                    + "`sal_cantidad`)"
                    + "VALUES ("
                    + "'" + docSalida + "', "
                    + "'" + salida.getId() + "', "
                    + "'" + salida.getCantidad() + "')";
            con.ejecutar(sql);
        }

    }

    public void crearPDF(String docSalida, String usuario, List<modeloSalidas> listaSalidas, String empleado) {

        Document documento = new Document(PageSize.LEGAL.rotate(), 25, 25, 25, 25);
        DateTimeFormatter fechaCompleta = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String fecha = fechaCompleta.format(LocalDateTime.now());

        FileOutputStream ficheroPDF;
        try {
            ficheroPDF = new FileOutputStream("reportes/Salida " + docSalida + ".pdf");
            PdfWriter.getInstance(documento, ficheroPDF);
            Image logo = Image.getInstance("imagenes/logo.png");
            documento.open();
            documento.add(logo);
            
            Paragraph titulo1 = new Paragraph("Salida de Almacen Nº" + docSalida,
                    FontFactory.getFont("arial",
                            22,
                            Font.BOLD,
                            BaseColor.BLACK
                    )
            );
            
            Paragraph titulo2 = new Paragraph("Fecha: " + fecha + " Usuario: " + usuario,
                    FontFactory.getFont("arial",
                            18,
                            BaseColor.BLACK
                    )
            );
            
            Paragraph titulo3 = new Paragraph("Elementos entregados a:  "+ empleado +"\n\n",
                    FontFactory.getFont("arial",
                            18,
                            BaseColor.BLACK
                    )
            );

            titulo1.setAlignment(Paragraph.ALIGN_CENTER);
            documento.add(titulo1);
            titulo2.setAlignment(Paragraph.ALIGN_CENTER);
            documento.add(titulo2);
            titulo3.setAlignment(Paragraph.ALIGN_CENTER);
            documento.add(titulo3);
            
            PdfPTable tabla = new PdfPTable(4);
            float[] values = new float[4];
            values[0] = 25;
            values[1] = 50;
            values[2] = 50;
            values[3] = 60;
            tabla.setWidths(values);

            BaseColor verde = new BaseColor(99, 167, 48);

            tabla.addCell(new Paragraph("Consecutivo", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Cod Item", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Item", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Cantidad", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));

            for (int i = 0; i < listaSalidas.size(); i++) {
                tabla.addCell(Integer.toString(i + 1));
                tabla.addCell(listaSalidas.get(i).getId());
                tabla.addCell(listaSalidas.get(i).getInventario());
                tabla.addCell(listaSalidas.get(i).getCantidad());
            }

            documento.add(tabla);

            documento.close();

            File myFile = new File("reportes/Salida " + docSalida + ".pdf");
            Desktop.getDesktop().open(myFile);

        } catch (FileNotFoundException ex) {
            Logger.getLogger(controlSalidas.class.getName()).log(Level.SEVERE, null, ex);
        } catch (DocumentException ex) {
            Logger.getLogger(controlSalidas.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(controlSalidas.class.getName()).log(Level.SEVERE, null, ex);
        }

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
            Logger.getLogger(controlSalidas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return empleados;

    }

    public void crearXLS() {

        try {
            File myFile = new File("plantillas/Salidas.xlsx");
            Desktop.getDesktop().open(myFile);
        } catch (IOException ex) {
            Logger.getLogger(controlSalidas.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
