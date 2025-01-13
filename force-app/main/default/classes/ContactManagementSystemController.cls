public with sharing class ContactManagementSystemController {

    @AuraEnabled
    public static void cContacts(List<Contact> contacts) {
        validateContacts(contacts, 'insert'); 
        insert contacts;
    }

    @AuraEnabled(cacheable=true)
public static List<Contact> searchContacts(String searchTerm) {
    if (String.isBlank(searchTerm)) {
        return [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE Email != NULL];
    }
    String searchPattern = '%' + searchTerm + '%';
    return [SELECT Id, FirstName, LastName, Email, Phone 
            FROM Contact 
            WHERE (FirstName LIKE :searchPattern OR LastName LIKE :searchPattern) AND Email != NULL];
}

    @AuraEnabled
    public static void uContacts(List<Contact> contacts) {
        validateContacts(contacts, 'update'); 
        update contacts;
    }

    @AuraEnabled
    public static void dContacts(List<Contact> contacts) {
        if (contacts == null || contacts.isEmpty()) {
            throw new AuraHandledException('No contacts provided for deletion.');
        }
        delete contacts;
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> rContacts() {
        return [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE Email != NULL];
    }

    private static void validateContacts(List<Contact> contacts, String operation) {
        if (contacts == null || contacts.isEmpty()) {
            throw new AuraHandledException('No contacts provided for ' + operation + '.');
        }
        for (Contact c : contacts) {
            if (String.isBlank(c.Email)) {
                throw new AuraHandledException('Email is required for ' + operation + ' operation.');
            }
        }
    }
}
