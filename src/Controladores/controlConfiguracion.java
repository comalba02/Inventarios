/*
SGI - Sistema Gestion de Inventarios 
Controlador Configuracion
 */
package Controladores;

import Conexion.conexion;
import Modelos.modeloCategorias;
import Modelos.modeloDocumentos;
import Modelos.modeloEmpresa;
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
public class controlConfiguracion {

    public List<modeloDocumentos> consultarDocumentos() {

        conexion con = new conexion();
        con.getConnection();

        String sqlDocumentos = "SELECT * from `documentos`";
        ResultSet rsDocumentos = con.consultar(sqlDocumentos);

        modeloDocumentos modDocumentos = new modeloDocumentos();
        List<modeloDocumentos> documentos = new ArrayList<modeloDocumentos>();
        try {
            while (rsDocumentos.next()) {
                String id = rsDocumentos.getString("doc_id");
                String nombre = rsDocumentos.getString("doc_tipo");
                String nit = rsDocumentos.getString("doc_prefijo");
                modDocumentos = new modeloDocumentos(id, nombre, nit);
                documentos.add(modDocumentos);
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlConfiguracion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return documentos;

    }

    public List<modeloEmpresa> consultarEmpresas() {

        conexion con = new conexion();
        con.getConnection();

        String sqlEmpresa = "SELECT * from `empresa`";
        ResultSet rsEmpresa = con.consultar(sqlEmpresa);

        modeloEmpresa modEmpresa = new modeloEmpresa();
        List<modeloEmpresa> empresas = new ArrayList<modeloEmpresa>();
        try {
            while (rsEmpresa.next()) {
                String id = rsEmpresa.getString("empr_id");
                String nombre = rsEmpresa.getString("empr_nombre");
                String nit = rsEmpresa.getString("empr_nit");
                modEmpresa = new modeloEmpresa(id, nombre, nit);
                empresas.add(modEmpresa);
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlConfiguracion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return empresas;

    }

    public List<modeloCategorias> consultarCategorias() {

        conexion con = new conexion();
        con.getConnection();

        String sqlCategorias = "SELECT * from `categorias`";
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
            Logger.getLogger(controlConfiguracion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return categorias;

    }

    public void actualizarEmpresa(String nombre, String nit) {

        conexion con = new conexion();
        con.getConnection();

        String sql = "UPDATE empresa "
                + "SET empr_nombre='" + nombre + "', "
                + "empr_nit='" + nit + "' "
                + "WHERE empr_id='1'";
        con.ejecutar(sql);

    }

    public boolean crearCategoria(String codigo, String nombre) {

        conexion con = new conexion();
        String sql = null;

        int id = Integer.parseInt(contarCategorias());

        if (Integer.parseInt(codigo) < id) {
            sql = "UPDATE categorias "
                    + "SET cat_nombre='" + nombre + "' "
                    + "WHERE cat_id='" + codigo + "'";
        } else {
            sql = "INSERT INTO `categorias`"
                    + "(`cat_id`, "
                    + "`cat_nombre`) "
                    + "VALUES ("
                    + "'" + id + "',"
                    + "'" + nombre + "')";
        }
        try {
            con.ejecutar(sql);
            return true;
        } catch (Exception e) {
            return false;
        }

    }

    public String contarCategorias() {

        conexion con = new conexion();
        String sql = "SELECT COUNT(`cat_id`) + 1 AS ID FROM categorias";
        ResultSet rs = con.consultar(sql);
        try {
            while (rs.next()) {
                String codigo = Integer.toString(rs.getInt("ID"));
                return codigo;
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlConfiguracion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public boolean crearDocumento(String codigo, String nombre, String prefijo) {

        conexion con = new conexion();
        String sql = null;

        int id = Integer.parseInt(contarDocumentos());

        if (Integer.parseInt(codigo) < id) {
            sql = "UPDATE documentos "
                    + "SET doc_tipo='" + nombre + "', "
                    + "doc_prefijo='" + prefijo + "' "
                    + "WHERE doc_id='" + codigo + "'";
        } else {
            sql = "INSERT INTO `documentos`"
                    + "(`doc_id`, "
                    + "`doc_tipo`, "
                    + "`doc_prefijo`) "
                    + "VALUES ("
                    + "'" + id + "',"
                    + "'" + nombre + "',"
                    + "'" + prefijo + "')";
            System.out.println("sql = " + sql);
        }
        try {
            con.ejecutar(sql);
            return true;
        } catch (Exception e) {
            return false;
        }

    }

    public String contarDocumentos() {

        conexion con = new conexion();
        String sql = "SELECT COUNT(`doc_id`) + 1 AS ID FROM documentos";
        ResultSet rs = con.consultar(sql);
        try {
            while (rs.next()) {
                String codigo = Integer.toString(rs.getInt("ID"));
                return codigo;
            }
        } catch (SQLException ex) {
            Logger.getLogger(controlConfiguracion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

}
