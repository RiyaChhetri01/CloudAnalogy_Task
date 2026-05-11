public class DeletingARecord {
    public static void del(){
     
        Account acc=[SELECT Id FROM Account WHERE name='Riya' LIMIT 1];
        delete acc;
        
    }

}