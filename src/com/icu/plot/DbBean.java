package com.icu.plot;
import java.sql.*;  
import java.io.*;  
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;
import java.sql.*;

public class DbBean { 
  //String dbURL = "jdbc:db2:sample";
  //String dbDriver = "COM.ibm.db2.jdbc.app.DB2Driver"; 
	   DataSource ds = null;
       Connection con = null;
       PreparedStatement ps=null;
       Statement stmt = null;
       InitialContext ic;
  //private Connection dbCon; 
  public DbBean(){  
   connect();
   System.out.println("inside connect");
   } 
  public Connection connect() {
	  
	  try{
	  ic = new InitialContext();
      ds = (DataSource) ic.lookup("java:/icuasapp");

      con = ds.getConnection();
      stmt = con.createStatement(); 
    
      //System.out.println("Success");
     }catch(Exception e){e.printStackTrace();}
  
	  return con;
	  } 
  
  public void close() throws SQLException{ 
  con.close(); 
   } 
  
  public ResultSet execSQL(String sql) throws SQLException{ 
  Statement s = con.createStatement(); 
  ResultSet r = s.executeQuery(sql); 
  return (r == null) ? null : r; 
  } 
  
  public PreparedStatement PreStmt(String sql) throws SQLException
  {
	   ps=con.prepareStatement(sql);
	  return ps;
	  
  }
  
  public int updateSQL(String sql) throws SQLException{   
     Statement s = con.createStatement();
   int r = s.executeUpdate(sql);
   return (r == 0) ? 0 : r; 
  } 
  
  public static java.util.Date getCurrentDateWithoutMilliseconds() {
		//Parse date to remove milliseconds
		Calendar c = Calendar.getInstance();
	    c.set(Calendar.MILLISECOND, 0); // set milliseconds to 0
	    return new java.util.Date(c.getTimeInMillis());
	}
  
  
  
} 



