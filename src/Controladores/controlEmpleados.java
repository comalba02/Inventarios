/*
SGI - Sistema Gestion de Inventarios 
Controlador Empleados
 */
package Controladores;

import Conexion.conexion;
import Modelos.modeloDocumentos;
import Modelos.modeloEmpleados;
import Modelos.modeloEmpresa;
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
public class controlEmpleados {

    public String contar() {

        conexion con = new conexion();
        String sql = "SELECT COUNT(`emp_id`) + 1 AS ID FROM empleados";
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
            Logger.getLogger(controlEmpleados.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public List<modeloDocumentos> tipoDoc() {

        conexion con = new conexion();

        String sqlDocumentos = "SELECT * from `documentos`";
        ResultSet rsDocumentos = con.consultar(sqlDocumentos);

        modeloDocumentos modDocumentos = new modeloDocumentos();
        List<modeloDocumentos> documentos = new ArrayList<modeloDocumentos>();
        try {
            while (rsDocumentos.next()) {
                String idDocumento = rsDocumentos.getString("doc_id");
                String tipoDocumento = rsDocumentos.getString("doc_tipo");
                String prefijoDocumento = rsDocumentos.getString("doc_prefijo");
                modDocumentos = new modeloDocumentos(idDocumento, tipoDocumento, prefijoDocumento);
                documentos.add(modDocumentos);
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlEmpleados.class.getName()).log(Level.SEVERE, null, ex);
        }
        return documentos;
    }

    private boolean verificar(String documento) {

        conexion con = new conexion();
        con.getConnection();

        String sqlVerificar = "SELECT * from `vista_empleados` WHERE Documento = '" + documento + "'";
        ResultSet rs = con.consultar(sqlVerificar);
        try {
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlEmpleados.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;

    }

    public boolean crearEmpleado(modeloEmpleados modelo) {

        conexion con = new conexion();
        String tipoDoc = null;
        String genero;
        String sql = null;

        List<modeloDocumentos> docTipos = tipoDoc();
        for (int i = 0; i < docTipos.size(); i++) {
            if (modelo.getTipoDoc().equals(docTipos.get(i).getTipo())) {
                tipoDoc = docTipos.get(i).getId();
            }

        }

        if (modelo.getGenero().equals("Femenino")) {
            genero = "F";
        } else {
            genero = "M";
        }

        int id = Integer.parseInt(contar());

        if (verificar(modelo.getDocumento())) {
            sql = "UPDATE empleados "
                    + "SET emp_tipodoc='" + tipoDoc + "', "
                    + "emp_documento='" + modelo.getDocumento() + "', "
                    + "emp_nombre='" + modelo.getNombre() + "', "
                    + "emp_genero='" + genero + "', "
                    + "emp_correo='" + modelo.getCorreo() + "' "
                    + "WHERE emp_id='" + modelo.getId() + "'";
        } else {
            sql = "INSERT INTO `empleados`"
                    + "(`emp_id`, "
                    + "`emp_empresa`, "
                    + "`emp_tipodoc`, "
                    + "`emp_documento`, "
                    + "`emp_nombre`, "
                    + "`emp_genero`, "
                    + "`emp_correo`) "
                    + "VALUES ("
                    + "'" + modelo.getId() + "',"
                    + "'" + modelo.getEmpresa() + "',"
                    + "'" + tipoDoc + "',"
                    + "'" + modelo.getDocumento() + "',"
                    + "'" + modelo.getNombre() + "',"
                    + "'" + genero + "',"
                    + "'" + modelo.getCorreo() + "')";
        }
        try {
            con.ejecutar(sql);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<modeloEmpleados> Consultar(String buscar) {
        conexion con = new conexion();
        con.getConnection();

        String sqlEmpresa = "SELECT * from `empresa`";
        ResultSet rsEmpresa = con.consultar(sqlEmpresa);

        modeloEmpresa modEmpresa = new modeloEmpresa();
        List<modeloEmpresa> empresas = new ArrayList<modeloEmpresa>();
        try {
            while (rsEmpresa.next()) {
                String idEmpresa = rsEmpresa.getString("empr_id");
                String nombreEmpresa = rsEmpresa.getString("empr_nombre");
                String nitEmpresa = rsEmpresa.getString("empr_nit");
                modEmpresa = new modeloEmpresa(idEmpresa, nombreEmpresa, nitEmpresa);
                empresas.add(modEmpresa);
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlEmpleados.class.getName()).log(Level.SEVERE, null, ex);
        }

        List<modeloDocumentos> documentos = tipoDoc();

        String sqlEmpleados = "SELECT * FROM `empleados` WHERE emp_nombre LIKE '%" + buscar + "%' OR emp_documento LIKE '%" + buscar + "%'";
        ResultSet rsEmpleados = con.consultar(sqlEmpleados);

        modeloEmpleados modEmpleados = new modeloEmpleados();
        List<modeloEmpleados> empleados = new ArrayList<modeloEmpleados>();
        try {
            while (rsEmpleados.next()) {
                String id = rsEmpleados.getString("emp_id");

                String empresa = rsEmpleados.getString("emp_empresa");
                for (int i = 0; i < empresas.size(); i++) {
                    if (empresa.equals(empresas.get(i).getId())) {
                        empresa = empresas.get(i).getNombre();
                    }
                }

                String tipodoc = rsEmpleados.getString("emp_tipodoc");
                for (int i = 0; i < documentos.size(); i++) {
                    if (tipodoc.equals(documentos.get(i).getId())) {
                        tipodoc = documentos.get(i).getTipo();
                    }
                }

                String documento = rsEmpleados.getString("emp_documento");
                String nombre = rsEmpleados.getString("emp_nombre");
                String genero = rsEmpleados.getString("emp_genero");
                String correo = rsEmpleados.getString("emp_correo");
                modEmpleados = new modeloEmpleados(id, empresa, tipodoc, documento, nombre, genero, correo);
                empleados.add(modEmpleados);
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlEmpleados.class.getName()).log(Level.SEVERE, null, ex);
        }
        return empleados;
    }

    public void crearPDF() {

        Document documento = new Document(PageSize.LEGAL.rotate(), 25, 25, 25, 25);
        DateTimeFormatter fechaCompleta = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String fecha = fechaCompleta.format(LocalDateTime.now());

        FileOutputStream ficheroPDF;
        try {
            ficheroPDF = new FileOutputStream("reportes/Empleados.pdf");
            PdfWriter.getInstance(documento, ficheroPDF);
            Image logo = Image.getInstance("imagenes/logo.png");
            documento.open();
            documento.add(logo);

            Paragraph titulo1 = new Paragraph("listado de Empleados",
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

            PdfPTable tabla = new PdfPTable(7);
            float[] values = new float[7];
            values[0] = 25;
            values[1] = 50;
            values[2] = 50;
            values[3] = 60;
            values[4] = 120;
            values[5] = 50;
            values[6] = 120;
            tabla.setWidths(values);

            BaseColor verde = new BaseColor(99, 167, 48);

            tabla.addCell(new Paragraph("Id", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Empresa", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Tipo de Documento", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Documento", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));
            tabla.addCell(new Paragraph("Nombre", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));tabla.addCell(new Paragraph("Genero", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));tabla.addCell(new Paragraph("Correo", FontFactory.getFont("arial",
                    16,
                    Font.BOLD,
                    verde
            )));

            List<modeloEmpleados> lista = new ArrayList<modeloEmpleados>();
            lista = Consultar("");

            for (int i = 0; i < lista.size(); i++) {
                tabla.addCell(lista.get(i).getId());
                tabla.addCell(lista.get(i).getEmpresa());
                tabla.addCell(lista.get(i).getTipoDoc());
                tabla.addCell(lista.get(i).getDocumento());
                tabla.addCell(lista.get(i).getNombre());
                tabla.addCell(lista.get(i).getGenero());
                tabla.addCell(lista.get(i).getCorreo());
            }

            documento.add(tabla);

            documento.close();

            File myFile = new File("reportes/Empleados.pdf");
            Desktop.getDesktop().open(myFile);

        } catch (FileNotFoundException ex) {
            Logger.getLogger(controlEmpleados.class.getName()).log(Level.SEVERE, null, ex);
        } catch (DocumentException ex) {
            Logger.getLogger(controlEmpleados.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(controlEmpleados.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void crearXLS() {

        try {
            File myFile = new File("plantillas/Empleados.xlsx");
            Desktop.getDesktop().open(myFile);
        } catch (IOException ex) {
            Logger.getLogger(controlEmpleados.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private Object toString(int i) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
