public class UpdateOpportunity {
    public static void updateRecord(){
        List<Opportunity> opp=[Select Id,Name,CloseDate From Opportunity Where CloseDate>Today];
        for (Opportunity op:opp){
            System.debug(op.CloseDate + op.Name);
            op.Name=op.Name+'F';
            System.debug('updatedName : '+op.Name);
        }
        update opp;
    }

}