package mail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;

public class Mail {
	
	private static final Logger LOG = Logger.getLogger(Mail.class);
	
	public static void send(String mail, String action){ 
		
		String to = mail;
		String subject = null;
		String text = null;
		if (action.equals("info")) {
			subject = "Письмо о изменении песональных данных на сайте webStore";
			text = "Ваши данные были изменены.";
		}else{
			subject = "Письмо о регистрации на сайте webStore";
			text = "Вы были успешно зарегистрированы!";
		}
		
		
		Properties pr = new Properties();
		pr.put("mail.smtp.host", "smtp.yandex.ru");
		pr.put("mail.smtp.socketFactory.port", 465);
		pr.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		pr.put("mail.smtp.auth", true);
		pr.put("mail.smtp.port", 465);
		
		Session s = Session.getDefaultInstance(pr,
				
				new javax.mail.Authenticator(){
			
			protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication("arsalan.noormal@yandex.ru", "vinchester1357");
			}
		});
		
		try{
			
			Message mess = new MimeMessage(s);
			mess.setFrom(new InternetAddress("arsalan.noormal@yandex.ru"));
			mess.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			mess.setSubject(subject);
			mess.setText(text);
			
			Transport.send(mess);
		}catch(Exception e){
			LOG.error("Mail is not send");
		}
	} 
}
