public class CreatOpportunity {
    public static void createOpp(){
        List<Opportunity> opp=new List<Opportunity>();
       
        for(Integer i=1;i<=20;i++){
        Opportunity op=new opportunity();
           op.Name='TestAccount'+i;
           op.CloseDate=Date.today().addDays(30);
           op.StageName='Closed Won';
            
        opp.add(op);   
        
            
               
        }
        insert opp;
    }

}