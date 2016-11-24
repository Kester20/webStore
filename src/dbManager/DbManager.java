package dbManager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import connectionPool.ConnectionPool;


public class DbManager {
	
	private static final Logger LOG = Logger.getLogger(DbManager.class);
	private static ConnectionPool pool;
	private static Connection connection;
	
	public static final ConnectionPool getConnectionPool(){
		
		if(pool == null){
			
			pool = ConnectionPool.getInstance("com.mysql.jdbc.Driver",
					"jdbc:mysql://localhost:3306/web_store?characterEncoding=utf8", "root", "", 5);
		}
		
		LOG.info("get Connection pool " + pool);
		return pool;
	}
	
	public static final Connection getConnection(){
		
		connection = getConnectionPool().getConnection();
		LOG.info("get connection " + connection);
		return connection;
	}
	
	public static void close(Connection con) {
		if (con != null) {
			try {
				con.close();
			} catch (SQLException ex) {
				LOG.error("Cannot commit transaction and close connection", ex);
			}
		}
	}

	public static void close(ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException ex) {
				LOG.error("Cannot close a result set", ex);
			}
		}
	}

	public static void close(Statement stmt) {
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException ex) {
				LOG.error("Cannot close a statement", ex);
			}
		}
	}
}
