@isTest
public class ContactManagementSystemControllerTest {

    @isTest
    static void testCreateContacts() {
        // Arrange
        List<Contact> contacts = new List<Contact>{
            new Contact(FirstName = 'Test', LastName = 'User', Email = 'test.user@example.com', Phone = '1234567890')
        };

        // Act
        Test.startTest();
        ContactManagementSystemController.cContacts(contacts);
        Test.stopTest();

        // Assert
        Contact createdContact = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE Email = 'test.user@example.com'];
        System.assertEquals('Test', createdContact.FirstName);
        System.assertEquals('User', createdContact.LastName);
        System.assertEquals('test.user@example.com', createdContact.Email);
    }

    @isTest
    static void testRetrieveContacts() {
        // Arrange
        Contact contact = new Contact(FirstName = 'Test', LastName = 'Retrieve', Email = 'retrieve.test@example.com', Phone = '9876543210');
        insert contact;

        // Act
        Test.startTest();
        List<Contact> retrievedContacts = ContactManagementSystemController.rContacts();
        Test.stopTest();

        // Assert
        System.assert(retrievedContacts.size() > 0, 'Contacts should be retrieved');
        System.assert(retrievedContacts[0].Email != null, 'Contacts should have Email populated');
    }

    @isTest
    static void testUpdateContacts() {
        // Arrange
        Contact contact = new Contact(FirstName = 'Update', LastName = 'Test', Email = 'update.test@example.com');
        insert contact;

        contact.LastName = 'Updated';
        List<Contact> contactsToUpdate = new List<Contact>{ contact };

        // Act
        Test.startTest();
        ContactManagementSystemController.uContacts(contactsToUpdate);
        Test.stopTest();

        // Assert
        Contact updatedContact = [SELECT LastName FROM Contact WHERE Id = :contact.Id];
        System.assertEquals('Updated', updatedContact.LastName, 'Contact LastName should be updated');
    }

    @isTest
    static void testDeleteContacts() {
        // Arrange
        Contact contact = new Contact(FirstName = 'Delete', LastName = 'Test', Email = 'delete.test@example.com');
        insert contact;

        List<Contact> contactsToDelete = new List<Contact>{ contact };

        // Act
        Test.startTest();
        ContactManagementSystemController.dContacts(contactsToDelete);
        Test.stopTest();

        // Assert
        Integer contactCount = [SELECT Count() FROM Contact WHERE Id = :contact.Id];
        System.assertEquals(0, contactCount, 'Contact should be deleted');
    }

    @isTest
    static void testSearchContacts() {
        // Arrange
        Contact contact = new Contact(FirstName = 'Search', LastName = 'Test', Email = 'search.test@example.com');
        insert contact;

        // Act
        Test.startTest();
        List<Contact> searchResults = ContactManagementSystemController.searchContacts('Search');
        Test.stopTest();

        // Assert
        System.assert(searchResults.size() > 0, 'Search should return results');
        System.assertEquals('Search', searchResults[0].FirstName, 'Search result should match FirstName');
    }

}