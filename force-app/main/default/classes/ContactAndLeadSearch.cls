public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String searchWord){
        List<List<sObject>> searchList=[Find :searchWord IN ALL FIELDS RETURNING Contact(FirstName, LastName),
                                       Lead(FirstName, LastName)];
        return searchList;
    }

}