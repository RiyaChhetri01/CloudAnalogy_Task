public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String postalCode){
        List<Contact> contactList=[SELECT Id, Name FROM Contact WHERE LastName=:lastName
                                  AND MailingPostalCode=:postalCode];
        return contactList;
            
    }

}