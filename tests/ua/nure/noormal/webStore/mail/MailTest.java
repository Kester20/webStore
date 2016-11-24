package ua.nure.noormal.webStore.mail;

import static org.junit.Assert.*;

import org.junit.Test;

import mail.Mail;

public class MailTest  {

	private Mail mail;
	
	@Test
	public void test() {
		mail = new Mail();
		mail.send("q","info");
		mail.send("q","registr");
	}

}
