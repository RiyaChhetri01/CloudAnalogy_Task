public class MultipleClass {

    public static void insertClass(){

        // Create Account List
        List<Account> acc = new List<Account>();

        Account acc1 = new Account(Name = 'Riya Chhetri');
        Account acc2 = new Account(Name = 'Isha Sharma');

        acc.add(acc1);
        acc.add(acc2);

        insert acc;

        // Create Contact List related to Accounts
        List<Contact> conList = new List<Contact>{
            new Contact(FirstName = 'Riya', LastName = 'Chhetri', AccountId = acc[0].Id),
            new Contact(FirstName = 'Isha', LastName = 'Sharma', AccountId = acc[1].Id)
        };

        insert conList;
    }

}