package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import dbManager.DbManager;

public class AdminDao {

	private static final Logger LOG = Logger.getLogger(AdminDao.class);

	public AdminDao() {
	}

	/** Возвращает логин
	 * @return
	 */
	public String getLogin() {

		String sql = "SELECT login FROM admin";
		StringBuilder result = new StringBuilder("");

		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			connection = DbManager.getConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);

			if (resultSet.next()) {
				result.append(resultSet.getString(1));
			}
		} catch (SQLException s) {
			LOG.error("SQL ERROR!");
		} finally {
			DbManager.close(resultSet);
			DbManager.close(statement);
			DbManager.close(connection);
		}

		return result.toString();
	}

	/** Возвращает пароль
	 * @return
	 */
	public String getPass() {

		String sql = "SELECT password FROM admin";
		StringBuilder result = new StringBuilder();

		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			connection = DbManager.getConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);

			if (resultSet.next()) {
				result.append(resultSet.getString(1));
			}
		} catch (SQLException s) {
			LOG.error("SQL ERROR!");
		} finally {
			DbManager.close(resultSet);
			DbManager.close(statement);
			DbManager.close(connection);
		}

		return result.toString();
	}
}
