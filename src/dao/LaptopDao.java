package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import dbManager.DbManager;

public class LaptopDao {

	private static final Logger LOG = Logger.getLogger(LaptopDao.class);

	public LaptopDao() {
	}

	/** Удаление
	 * @param id
	 * @return
	 */
	public boolean deleteLaptop(int id) {

		String sql = "DELETE FROM laptop WHERE laptop.id = " + id;
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

	/** Добавление
	 * @param producer
	 * @param CPU
	 * @param screen
	 * @param screenResol
	 * @param RAM
	 * @param amountHardDrive
	 * @param color
	 * @param weight
	 * @param videoCard
	 * @param guarantee
	 * @param price
	 * @param model
	 * @return
	 */
	public boolean addLaptop(String producer, String CPU, String screen, String screenResol, String RAM,
			String amountHardDrive, String color, int weight, String videoCard, int guarantee, int price,
			String model) {
		
		String sql = "INSERT into laptop (producer,CPU,screen , screenResolution, RAM, amountHardDrive, color, "
				+ "weight, videoCard, guarantee, price , image, model) " + "VALUES "
				+ "((select producer.id from producer where producer.producer = ?),"
				+ "(select CPU.id from CPU where CPU.CPU = ?)," + "?,"
				+ "(select screenResolution.id from screenResolution where screenResolution.screenRes = ?)," + "?,"
				+ "?," + "?, ?," + "(select videoCard.id from videoCard where videoCard.video = ?), "
				+ "?, ?, ?, ?)";

		Connection connection = null;
		PreparedStatement prStatement = null;

		try {
			connection = DbManager.getConnection();
			prStatement = connection.prepareStatement(sql);

			prStatement.setString(1, producer);
			prStatement.setString(2, CPU);
			prStatement.setString(3, screen);
			prStatement.setString(4, screenResol);
			prStatement.setString(5, RAM);
			prStatement.setString(6, amountHardDrive);
			prStatement.setString(7, color);
			prStatement.setInt(8, weight);
			prStatement.setString(9, videoCard);
			prStatement.setInt(10, guarantee);
			prStatement.setInt(11, price);
			prStatement.setString(12, "NULL");
			prStatement.setString(13, model);

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

	public boolean setImage(String imageName) {

		String sql = "UPDATE laptop SET laptop.image = ? WHERE laptop.id = ?";

		Connection connection = null;
		PreparedStatement prStatement = null;

		try {
			connection = DbManager.getConnection();
			prStatement = connection.prepareStatement(sql);

			prStatement.setString(1, imageName);
			prStatement.setString(2, String.valueOf(findMaxIdLaptop()));

			int r = prStatement.executeUpdate();

			if (r > 0) {
				return true;
			}
		} catch (SQLException s) {
			LOG.error("SQL ERROR!");
		} finally {
			DbManager.close(prStatement);
			DbManager.close(connection);
		}
		return false;
	}

	/** Нахождение максималного id
	 * @return
	 */
	public int findMaxIdLaptop() {
		int id = 0;
		String sql = "SELECT MAX(laptop.id) FROM laptop";

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

	/** Обновление
	 * @param id
	 * @param producer
	 * @param CPU
	 * @param screen
	 * @param screenResol
	 * @param RAM
	 * @param amountHardDrive
	 * @param color
	 * @param weight
	 * @param videoCard
	 * @param guarantee
	 * @param price
	 * @param model
	 * @return
	 */
	public boolean update(int id, String producer, String CPU, String screen, String screenResol, String RAM,
			String amountHardDrive, String color, int weight, String videoCard, int guarantee, int price,
			String model) {

		String sql = "UPDATE `laptop` SET `producer` = ?, `CPU` = ?,"
				+ " `screen` = ?, `screenResolution` = ?, `RAM` = ?,"
				+ " `amountHardDrive` = ?, `color` = ?, `weight` = ?,"
				+ " `videoCard` = ? , `guarantee` = ?, `price` = ?, `model` = ?" + "  WHERE `laptop`.`id` = ?";

		Connection connection = null;
		PreparedStatement prStatement = null;

		try {
			connection = DbManager.getConnection();
			prStatement = connection.prepareStatement(sql);

			prStatement.setString(1, String.valueOf(getIdProducer(producer)));
			prStatement.setString(2, String.valueOf(getIdCPU(CPU)));
			prStatement.setString(3, screen);
			prStatement.setString(4, String.valueOf(getIdScreenRes(screenResol)));
			prStatement.setString(5, RAM);
			prStatement.setString(6, amountHardDrive);
			prStatement.setString(7, color);
			prStatement.setInt(8, weight);
			prStatement.setString(9, String.valueOf(getIdVideo(videoCard)));
			prStatement.setInt(10, guarantee);
			prStatement.setInt(11, price);
			prStatement.setString(12, model);
			prStatement.setInt(13, id);

			return prStatement.execute();
		} catch (SQLException s) {
			LOG.error("SQL ERROR!");
		} finally {
			DbManager.close(prStatement);
			DbManager.close(connection);
		}
		return false;
	}

	private int getIdProducer(String producer) {

		int id = 0;
		String sql = "SELECT producer.id FROM producer WHERE producer.producer = '" + producer + "'";

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

	private int getIdCPU(String CPU) {

		int id = 0;
		String sql = "SELECT CPU.id FROM CPU WHERE CPU.CPU = '" + CPU + "'";

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

	private int getIdScreenRes(String screenRes) {

		int id = 0;
		String sql = "SELECT screenResolution.id FROM screenResolution WHERE screenResolution.screenRes = '" + screenRes
				+ "'";

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

	private int getIdVideo(String video) {

		int id = 0;
		String sql = "SELECT videoCard.id FROM videoCard WHERE videoCard.video = '" + video + "'";

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
}
