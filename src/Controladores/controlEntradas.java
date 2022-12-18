/*
SGI - Sistema Gestion de Inventarios 
Controlador Entradas
 */
package Controladores;

import Conexion.conexion;
import Modelos.modeloEntradas;
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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Marco Coronado
 */
public class controlEntradas {

    public String contar() {

        conexion con = new conexion();
        String sql = "SELECT COUNT(`docen_id`) + 1 AS ID FROM documento_ent";
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

    public void crearDocumentoEntrada(String docEntrada, String usuario) {

        conexion con = new conexion();
        String idUsuario = consultarUsuario(usuario);
        DateTimeFormatter fechaCompleta = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String fecha = fechaCompleta.format(LocalDateTime.now());
        String sql = "INSERT INTO `documento_ent` "
                + "(`docen_id`, "
                + "`docen_fecha`, "
                + "`docen_usuario`)"
                + "VALUES ("
                + "'" + docEntrada + "', "
                + "'" + fecha + "', "
                + "'" + idUsuario + "')";
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
            Logger.getLogger(controlEntradas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return idUsuario;

    }

    public void crearEntradas(String docEntrada, List<modeloEntradas> listaEntradas) {

        for (modeloEntradas entrada : listaEntradas) {
            conexion con = new conexion();
            String sql = "INSERT INTO `entradas` "
                    + "(`ent_documento`, "
                    + "`ent_inventario`, "
                    + "`ent_cantidad`)"
                    + "VALUES ("
                    + "'" + docEntrada + "', "
                    + "'" + entrada.getId() + "', "
                    + "'" + entrada.getCantidad() + "')";
            con.ejecutar(sql);
        }

    }

    public void crearPDF(String docEntrada, String usuario, List<modeloEntradas> listaEntradas) {

        Document documento = new Document(PageSize.LEGAL.rotate(), 25, 25, 25, 25);
        DateTimeFormatter fechaCompleta = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String fecha = fechaCompleta.format(LocalDateTime.now());

        FileOutputStream ficheroPDF;
        try {
            ficheroPDF = new FileOutputStream("reportes/Entrada " + docEntrada + ".pdf");
            PdfWriter.getInstance(documento, ficheroPDF);
            Image logo = Image.getInstance("imagenes/logo.png");
            documento.open();
            documento.add(logo);
            Paragraph titulo1 = new Paragraph("Entrada de Almacen Nº" + docEntrada,
                    FontFactory.getFont("arial",
                            22,
                            Font.BOLD,
                            BaseColor.BLACK
                    )
            );
            Paragraph titulo2 = new Paragraph("Fecha: " + fecha + " Usuario: " + usuario + "\n\n",
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

            for (int i = 0; i < listaEntradas.size(); i++) {
                tabla.addCell(Integer.toString(i + 1));
                tabla.addCell(listaEntradas.get(i).getId());
                tabla.addCell(listaEntradas.get(i).getInventario());
                tabla.addCell(listaEntradas.get(i).getCantidad());
            }

            documento.add(tabla);

            documento.close();

            File myFile = new File("reportes/Entrada " + docEntrada + ".pdf");
            Desktop.getDesktop().open(myFile);

        } catch (FileNotFoundException ex) {
            Logger.getLogger(controlEntradas.class.getName()).log(Level.SEVERE, null, ex);
        } catch (DocumentException ex) {
            Logger.getLogger(controlEntradas.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(controlEntradas.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void crearXLS() {

        try {
            File myFile = new File("plantillas/Entradas.xlsx");
            Desktop.getDesktop().open(myFile);
        } catch (IOException ex) {
            Logger.getLogger(controlEntradas.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
