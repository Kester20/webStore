package ua.nure.noormal.webStore.hash;

import static org.junit.Assert.*;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

import org.junit.Test;

import hashPassword.Password;

public class PasswordTest {

	private Password pass;
	
	@Test
	public void test() throws NoSuchAlgorithmException, UnsupportedEncodingException {
		
		pass = new Password();
		pass.hash("admin");
		
	}

}
