package dao;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import dbManager.DbManager;
import hashPassword.Password;

public class ClientDao {

	private static final Logger LOG = Logger.getLogger(ClientDao.class);

	public ClientDao() {
	}

	/** Регистрация
	 * @param name
	 * @param login
	 * @param email
	 * @param town
	 * @param street
	 * @param house
	 * @param phone
	 * @param pass
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 */
	public boolean addClient(String name, String login, String email, String town, String street, String house,
			long phone, String pass) throws NoSuchAlgorithmException, UnsupportedEncodingException {

		pass = new String(Password.hash(pass));
		String sql = "INSERT into client (login, password, email, name, town, street, house, phone)  VALUES (" + "'"
				+ login + "', '" + pass + "', '" + email + "', '" + name + "', '" + town + "', '" + street + "'," + " '"
				+ house + "', '" + phone + "');";

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

	/** Получение логина
	 * @param login
	 * @return
	 */
	public boolean getLogin(String login)  {

		String sql = "SELECT login FROM client WHERE login = '" + login + "'";

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

	/** Получение id по логину
	 * @param login
	 * @return
	 */
	public int getIdClient(String login)  {

		int id = 0;
		String sql = "SELECT id FROM client WHERE login = '" + login + "'";

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

	/** Вход
	 * @param login
	 * @param password
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 */
	public boolean logIn(String login, String password)
			throws  NoSuchAlgorithmException, UnsupportedEncodingException {

		if (getLogin(login)) {

			password = new String(Password.hash(password));
			String sql = "SELECT password FROM client WHERE password = '" + password + "'";

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
		} 
		return false;
	}

	/** Обновление персональных данных 
	 * @param value
	 * @param variable
	 * @param id
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public boolean updateValue(String value, String variable, int id)
			throws  UnsupportedEncodingException {

		String sql = "UPDATE client SET " + variable + " = '" + value + "' WHERE id = " + id;

		Connection connection = null;
		Statement statement = null;
		
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

	/**
	 * @param id
	 * @return
	 */
	public String getMail(int id)  {

		String mail = null;
		String sql = "SELECT email FROM client WHERE id = " + id;
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			connection = DbManager.getConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);

			if (resultSet.next()) {
				mail = resultSet.getString(1);
			}
		} catch (SQLException s) {
			LOG.error("SQL ERROR!");
		} finally {
			DbManager.close(resultSet);
			DbManager.close(statement);
			DbManager.close(connection);
		}
		return mail;
	}
}
