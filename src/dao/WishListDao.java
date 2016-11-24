package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import dbManager.DbManager;

public class WishListDao {

	private static final Logger LOG = Logger.getLogger(WishListDao.class);

	public WishListDao() {
	}

	/** Добавление в список желаний
	 * @param idClient
	 * @param idLaptop
	 * @return
	 */
	public boolean addToWish(int idClient, int idLaptop) {

		if (!checkExistWishes(idClient, idLaptop)) {
			String sql = "INSERT into wishList (idclient, idLaptop)  VALUES ('" + idClient + "', '" + idLaptop + "'"
					+ ");";

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
		}
		return false;
	}

	/** Удаление из списка желаний
	 * @param idClient
	 * @param idLaptop
	 * @return
	 */
	public boolean deleteFromWish(int idClient, int idLaptop) {

		String sql = "DELETE FROM wishList WHERE idClient = " + idClient + " AND idLaptop = " + idLaptop;
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

	/** Проверка на наличие в списке желаний ноутбука
	 * @param idClient
	 * @param idLaptop
	 * @return
	 */
	public boolean checkExistWishes(int idClient, int idLaptop) {

		String sql = "SELECT idClient,idLaptop FROM wishList WHERE idClient = '" + idClient + "' AND idLaptop = '"
				+ idLaptop + "'";

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
