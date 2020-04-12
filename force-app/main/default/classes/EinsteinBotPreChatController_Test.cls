/*
 * Author: Shantanu Srivastava (Neuraflash)
 * Date: 01/11/2018
 * Description: Test Class for EinsteinBotPreChatController
 */
@isTest
private class EinsteinBotPreChatController_Test {

    @isTest
    static void it_should_get_logged_in_user() {
        EinsteinBotPreChatController.LoggedInUserDetails loggedInUser = EinsteinBotPreChatController.getLoggedInUser();

        System.assertEquals(UserInfo.getUserId(), loggedInUser.userId);
    }

    @isTest
    static void it_should_get_contact() {
        Contact contact = new Contact(
            FirstName = 'Rick',
            LastName = 'Sanchez',
            Email = 'rick.sanchez@email.com'
        );
        insert contact;

        Contact returnedContact = EinsteinBotPreChatController.getContact('rick.sanchez@email.com');

        System.assertEquals(contact.LastName, returnedContact.LastName);
    }

    @isTest
    static void it_should_return_null_if_no_contact_exists() {
        Contact returnedContact = EinsteinBotPreChatController.getContact('rick.sanchez@email.com');

        System.assertEquals(null, returnedContact.LastName);
    }
}