/*
 * Author: Shantanu Srivastava (Neuraflash)
 * Date: 18/10/2018
 */
public without sharing class EinsteinBotPreChatController {

 /**
   * @description	-	Rrturns logged in user name and email details
   * @return	-	name and email of the logged in user
   */
	@AuraEnabled
	public static LoggedInUserDetails getLoggedInUser() {
		try{
			System.debug('>> UserInfo.getUserType() : ' + UserInfo.getUserType());
			if(UserInfo.getUserType() == 'Guest') return new LoggedInUserDetails();

			Id userId = UserInfo.getUserId();
			System.debug('>> userId : ' + userId);
			User user = [SELECT Id, FirstName, LastName, Email, ContactId FROM User WHERE Id = :userId];
			System.debug('>> user : ' + user);
			Id userContactId = user.ContactId;
			//if no contact exists return details fetched from user record
			if(userContactId == null){
				LoggedInUserDetails userRecord = new LoggedInUserDetails(user.Id, user.FirstName, user.LastName, user.Email);
				return userRecord;
			}
			//if contact exists return details fetched from contact record for the user
			Contact contact = [SELECT Id, FirstName, LastName, Email, Logged_In_User_Id__c FROM Contact WHERE Id = :user.ContactId];
			LoggedInUserDetails userRecord = new LoggedInUserDetails(contact.Id, contact.FirstName, contact.LastName, contact.Email);

			return userRecord;
		}
		catch(Exception ex){
			system.debug('>> Exception while fetching user details : ' + ex);
			return new LoggedInUserDetails();
		}
	}

	@AuraEnabled
	public static Contact getContact(String email) {
		try {
			return [
				SELECT Id, FirstName, LastName
				FROM Contact
				WHERE Email = :email
				ORDER BY LastModifiedDate DESC
				LIMIT 1];
		} catch(Exception ex) {
			System.debug(ex.getMessage());
			return new Contact();
		}
	}

	public class LoggedInUserDetails {

		@auraEnabled public String userId{get;set;}
		@auraEnabled public String firstname{get;set;}
		@auraEnabled public String lastname{get;set;}
		@auraEnabled public String email{get;set;}

		public LoggedInUserDetails(){}

		public LoggedInUserDetails(String userId, String firstname, String lastname, String email){
			this.userId = userId;
			this.firstname = firstname;
			this.lastname = lastname;
			this.email = email;
		}
	}
}