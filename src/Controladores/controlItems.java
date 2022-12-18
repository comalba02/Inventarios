/*
SGI - Sistema Gestion de Inventarios 
Controlador Items
 */
package Controladores;

import Conexion.conexion;
import Modelos.modeloCategorias;
import Modelos.modeloItems;
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
public class controlItems {

    public List<modeloItems> Consultar(String buscar) {

        conexion con = new conexion();
        con.getConnection();

        String sqlItems = "SELECT * from `vista_inventarios` WHERE Item LIKE '%" + buscar + "%' OR Descripcion LIKE '%" + buscar + "%'";
        ResultSet rsItems = con.consultar(sqlItems);

        modeloItems modItems = new modeloItems();
        List<modeloItems> items = new ArrayList<modeloItems>();
        try {
            while (rsItems.next()) {
                String id = rsItems.getString("Id");
                String item = rsItems.getString("Item");
                String descripcion = rsItems.getString("Descripcion");
                String categoria = rsItems.getString("Categoria");
                String disponible = rsItems.getString("Disponible");
                modItems = new modeloItems(id, item, descripcion, categoria, disponible);
                items.add(modItems);
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlItems.class.getName()).log(Level.SEVERE, null, ex);
        }
        return items;
    }

    public String contar() {

        conexion con = new conexion();
        String sql = "SELECT COUNT(`ite_id`) + 1 AS ID FROM items";
        ResultSet rs = con.consultar(sql);
        try {
            while (rs.next()) {
                String codigo = Integer.toString(rs.getInt("ID"));
                return codigo;
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlItems.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<modeloCategorias> categorias() {

        conexion con = new conexion();

        String sqlCategorias = "SELECT * FROM `categorias`";
        ResultSet rsCategorias = con.consultar(sqlCategorias);

        modeloCategorias modCategorias = new modeloCategorias();
        List<modeloCategorias> categorias = new ArrayList<modeloCategorias>();
        try {
            while (rsCategorias.next()) {
                String id = rsCategorias.getString("cat_id");
                String nombre = rsCategorias.getString("cat_nombre");
                modCategorias = new modeloCategorias(id, nombre);
                categorias.add(modCategorias);

            }
        } catch (SQLException ex) {
            Logger.getLogger(controlItems.class.getName()).log(Level.SEVERE, null, ex);
        }
        return categorias;

    }

    public boolean crearItem(modeloItems modelo) {
        conexion con = new conexion();
        String categoria = null;
        String sql = null;

        List<modeloCategorias> categorias = categorias();
        for (int i = 0; i < categorias.size(); i++) {
            if (modelo.getCategoria().equals(categorias.get(i).getNombre())) {
                categoria = categorias.get(i).getId();
            }

        }

        int id = Integer.parseInt(contar());

        if (Integer.parseInt(modelo.getId()) < id) {

            sql = "UPDATE items "
                    + "SET ite_nombre='" + modelo.getNombre() + "', "
                    + "ite_descripcion='" + modelo.getDescripcion() + "', "
                    + "ite_categoria='" + categoria + "' "
                    + "WHERE ite_id='" + modelo.getId() + "'";
        } else {
            sql = "INSERT INTO `items`"
                    + "(`ite_id`, "
                    + "`ite_nombre`, "
                    + "`ite_descripcion`, "
                    + "`ite_categoria` )"
                    + "VALUES ("
                    + "'" + modelo.getId() + "',"
                    + "'" + modelo.getNombre() + "',"
                    + "'" + modelo.getDescripcion() + "',"
                    + "'" + categoria + "')";

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

    public void crearPDF() {

        Document documento = new Document(PageSize.LEGAL.rotate(), 25, 25, 25, 25);
        DateTimeFormatter fechaCompleta = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String fecha = fechaCompleta.format(LocalDateTime.now());

        FileOutputStream ficheroPDF;
        try {
            ficheroPDF = new FileOutputStream("reportes/Items.pdf");
            PdfWriter.getInstance(documento, ficheroPDF);
            Image logo = Image.getInstance("imagenes/logo.png");
            documento.open();
            documento.add(logo);
            
            Paragraph titulo1 = new Paragraph("Listado de Items",
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

            PdfPTable tabla = new PdfPTable(5);
            float[] values = new float[5];
            values[0] = 25;
            values[1] = 50;
            values[2] = 50;
            values[3] = 60;
            values[4] = 60;
            tabla.setWidths(values);

            BaseColor verde = new BaseColor(99, 167, 48);

            tabla.addCell(new Paragraph("Id", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Item", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Descripción", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Categoría", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Disponible", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            
            List<modeloItems> lista = new ArrayList<modeloItems>();
            lista = Consultar("");

            for (int i = 0; i < lista.size(); i++) {
                tabla.addCell(lista.get(i).getId());
                tabla.addCell(lista.get(i).getNombre());
                tabla.addCell(lista.get(i).getDescripcion());
                tabla.addCell(lista.get(i).getCategoria());
                tabla.addCell(lista.get(i).getDisponible());
            }

            documento.add(tabla);

            documento.close();

            File myFile = new File("reportes/Items.pdf");
            Desktop.getDesktop().open(myFile);

        } catch (FileNotFoundException ex) {
            Logger.getLogger(controlItems.class.getName()).log(Level.SEVERE, null, ex);
        } catch (DocumentException | IOException ex) {
            Logger.getLogger(controlItems.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void crearXLS() {

        try {
            File myFile = new File("plantillas/Items.xlsx");
            Desktop.getDesktop().open(myFile);
        } catch (IOException ex) {
            Logger.getLogger(controlItems.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
