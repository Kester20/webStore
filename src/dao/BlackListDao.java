package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import dbManager.DbManager;

public class BlackListDao {

	private static final Logger LOG = Logger.getLogger(BlackListDao.class);

	public BlackListDao() {
	}

	/** Блокирует клиента
	 * @param idClient
	 * @return
	 */
	public boolean lockClient(int idClient) {

		String sql = "INSERT into black_list (idClient,reason)" + "VALUES (" + idClient
				+ ", 'failure to comply with the rules of the site')";

		Connection connection = null;
		PreparedStatement prStatement = null;

		try {
			connection = DbManager.getConnection();
			prStatement = connection.prepareStatement(sql);

			return prStatement.execute();
		} catch (SQLException s) {
			LOG.error("SQL ERROR!");
		} finally {
			DbManager.close(prStatement);
			DbManager.close(connection);
		}
		return false;
	}

	/** Разблакирует клиета 
	 * @param idClient
	 * @return
	 */
	public boolean unlockClient(int idClient) {

		String sql = "DELETE FROM black_list WHERE idClient = " + idClient;

		Connection connection = null;
		PreparedStatement prStatement = null;

		try {
			connection = DbManager.getConnection();
			prStatement = connection.prepareStatement(sql);

			return prStatement.execute();
		} catch (SQLException s) {
			LOG.error("SQL ERROR!");
		} finally {
			DbManager.close(prStatement);
			DbManager.close(connection);
		}
		return false;
	}

	/** Проверка на наличие клиента в черном списке
	 * @param login
	 * @return
	 */
	public static boolean checkBlackList(String login) {
		String sql = "SELECT idClient FROM black_list WHERE idClient = (SELECT client.id from client where client.login = '"
				+ login + "')";

		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			connection = DbManager.getConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);

			if (resultSet.next()) {
				return true;
			}
		} catch (SQLException s) {
			LOG.error("SQL ERROR!");
		} finally {
			DbManager.close(resultSet);
			DbManager.close(statement);
			DbManager.close(connection);
		}
		return false;
	}
}
