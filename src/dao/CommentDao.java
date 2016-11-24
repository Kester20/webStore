package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import dbManager.DbManager;

public class CommentDao {

	private static final Logger LOG = Logger.getLogger(CommentDao.class);

	public CommentDao() {
	}

	/** Добавление комментария
	 * @param idClient
	 * @param idLaptop
	 * @param text
	 * @return
	 */
	public boolean addComment(int idClient, int idLaptop, String text) {

		String sql = "INSERT into comment (idClient, idLaptop, text)  VALUES (" + "'" + idClient + "', '" + idLaptop
				+ "', '" + text + "');";

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

	/** Действие с комментарием
	 * @param action
	 * @param idLaptop
	 * @param loginClient
	 * @param date
	 * @return
	 */
	public boolean actionComment(String action, int idLaptop, String loginClient, String date) {

		Connection connection = null;
		Statement statement = null;

		String act = "";
		switch (action) {
		case "publish": {
			act = "yes";
			break;
		}
		case "hide": {
			act = "no";
			break;
		}

		case "delete": {

			String sql = "DELETE FROM comment WHERE idLaptop = " + idLaptop + " "
					+ "AND idClient = (SELECT id FROM client WHERE login = '" + loginClient + "')" + " AND date = '"
					+ date + "'";

			try {
				connection = DbManager.getConnection();
				statement = connection.createStatement();
				return statement.execute(sql);
			} catch (SQLException e) {
				LOG.error("SQL ERROR!");
			} finally {
				DbManager.close(statement);
				DbManager.close(connection);
			}
		}

		default:
			break;
		}

		String sql = "UPDATE comment SET publish = '" + act + "' WHERE idLaptop = " + idLaptop + " "
				+ "AND idClient = (SELECT id FROM client WHERE login = '" + loginClient + "')" + " AND date = '" + date
				+ "'";

		try {
			connection = DbManager.getConnection();
			statement = connection.createStatement();
			return statement.execute(sql);
		} catch (SQLException e) {
			LOG.error("SQL ERROR!");
		} finally {
			DbManager.close(statement);
			DbManager.close(connection);
		}
		return false;
	}
}
