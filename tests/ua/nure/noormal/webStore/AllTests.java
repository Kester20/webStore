package ua.nure.noormal.webStore;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

import ua.nure.noormal.webStore.hash.PasswordTest;
import ua.nure.noormal.webStore.mail.MailTest;
import ua.nure.noormal.webStore.addImageLaptop.AddImageLaptopTest;
import ua.nure.noormal.webStore.addLaptop.AddLaptopTest;
import ua.nure.noormal.webStore.admin.AdminTest;
import ua.nure.noormal.webStore.cart.CartTest;
import ua.nure.noormal.webStore.checkboxes.CheckboxesTest;
import ua.nure.noormal.webStore.client.ClientTest;
import ua.nure.noormal.webStore.order.OrderTest;


@RunWith(Suite.class)
@SuiteClasses({MailTest.class, PasswordTest.class, AddLaptopTest.class,AddImageLaptopTest.class, AdminTest.class, CartTest.class, CheckboxesTest.class, ClientTest.class, OrderTest.class})
public class AllTests { 	
}
