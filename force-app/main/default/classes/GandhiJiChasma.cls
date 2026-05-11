public class GandhiJiChasma {
    public static void getTotal(){
        Decimal Totalprice=0;
        List<OpportunityLineItem> oppList=[Select TotalPrice,Opportunity.StageName,Product2.Name From 
                                           OpportunityLineItem Where Product2.Name='Gandhiji Chasma' AND Opportunity.StageName='Closed Won'];
        for(OpportunityLineItem opp:oppList){
            Totalprice+=opp.TotalPrice;
            
        }
        System.debug('total price: ' +Totalprice);
    }

}