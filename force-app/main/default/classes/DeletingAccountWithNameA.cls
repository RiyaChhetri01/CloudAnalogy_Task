public class DeletingAccountWithNameA {
    public static void deleteRecord(){
        List<Contact> conList=[Select Id,Name ,Account.Name From Contact Where Account.Name LIKE 'A%'];
        for(Contact cnn:conList){
            System.debug('id: '+cnn.Id+' name:'+cnn.Name +'Account Name '+cnn.Account.name);
        }
        delete conList;
    }

}