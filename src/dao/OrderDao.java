package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map.Entry;

import org.apache.log4j.Logger;

import dbManager.DbManager;

public class OrderDao {

	private static final Logger LOG = Logger.getLogger(OrderDao.class);

	public OrderDao() {
	}
	
	/** Метод удаляет заказ
	 * @param idClient
	 * @param date
	 * @return
	 */
	public boolean deleteOrder(int idClient, String date){
		
		String sql = "DELETE FROM `order` WHERE `order`.idClient = " + idClient + " AND"
				+ " `order`.date = '" + date + "' ;";
		Connection connection = null;
		PreparedStatement prStatement = null;

		try {
			connection = DbManager.getConnection();
			prStatement = connection.prepareStatement(sql);

			return prStatement.execute();
		} catch (SQLException s) {
			LOG.error("SQL ERROR!");
			s.printStackTrace();
		} finally {
			DbManager.close(prStatement);
			DbManager.close(connection);
		}
		return false;
	}

	/** Добавление заказа
	 * @param cost
	 * @param typePayment
	 * @param typeReceipt
	 * @param idClient
	 * @param list
	 * @return
	 */
	public boolean addOrder(Double cost, String typePayment, String typeReceipt, int idClient,
			HashMap<Integer, Integer> list) {

		String sql = "INSERT INTO `order` (`status`, `cost`, `typePayment`, `typeReceipt`, `idClient`) VALUES ('registered', ?, ?, ?, ?)";

		Connection connection = null;
		PreparedStatement prStatement = null;

		try {
			connection = DbManager.getConnection();
			prStatement = connection.prepareStatement(sql);

			prStatement.setDouble(1, cost);
			prStatement.setString(2, typePayment);
			prStatement.setString(3, typeReceipt);
			prStatement.setInt(4, idClient);

			prStatement.execute();

			int idOrder = findMaxIdOrder();

			for (Entry<Integer, Integer> entry : list.entrySet()) {
				Integer key = entry.getKey();
				Integer value = entry.getValue();
				addToOrderLaptop(idOrder, key, value);
			}

			return true;
		} catch (SQLException s) {
			LOG.error("SQL ERROR!");
		} finally {
			DbManager.close(prStatement);
			DbManager.close(connection);
		}
		return false;
	}

	public int findMaxIdOrder()  {

		int id = 0;
		String sql = "SELECT MAX(`order`.`id`) FROM `order`";

		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			connection = DbManager.getConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);

			if (resultSet.next()) {
				id = resultSet.getInt(1);
			}
		} catch (SQLException s) {
			LOG.error("SQL ERROR!");
		} finally {
			DbManager.close(resultSet);
			DbManager.close(statement);
			DbManager.close(connection);
		}
		return id;
	}

	public boolean addToOrderLaptop(int idOrder, int idLaptop, int number) {

		String sql = "INSERT INTO `order_laptop` (`id`, `idLaptop`, `idOrder`, `numberLaptops`) VALUES (NULL, ?, ?, ?);";
		Connection connection = null;
		PreparedStatement prStatement = null;

		try {
			connection = DbManager.getConnection();
			prStatement = connection.prepareStatement(sql);

			prStatement.setInt(1, idLaptop);
			prStatement.setInt(2, idOrder);
			prStatement.setInt(3, number);

			return prStatement.execute();
		} catch (SQLException s) {
			LOG.error("SQL ERROR!");
		} finally {
			DbManager.close(prStatement);
			DbManager.close(connection);
		}
		return false;
	}

	/** Обновление статуса заказа
	 * @param status
	 * @param idOrder
	 * @return
	 */
	public boolean updateStatusOrder(String status, int idOrder)  {

		String sql = "UPDATE `order` SET `status` = '" + status + "' WHERE `order`.`id` = " + idOrder;

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
}
