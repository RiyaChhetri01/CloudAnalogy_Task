public class CurrencyQueuable implements Queueable,Database.AllowsCallouts {

    private List<Opportunity> oppList;

    public CurrencyQueuable(List<Opportunity> oppList){
        this.oppList = oppList;
    }

    public void execute(QueueableContext context){

        Map<String, Decimal> rates = CurrencyConvertor.getCurrencyRates();
        System.debug(rates);

        List<Opportunity> updateList = new List<Opportunity>();

        for(Opportunity opp : oppList){

            if(opp.Cuurency_Type__c != null &&
               opp.Amount != null &&
               rates.containsKey(opp.Cuurency_Type__c)){

                Decimal rate = rates.get(opp.Cuurency_Type__c);

                Opportunity updatedOpp = new Opportunity(
                    Id = opp.Id,
                    Converted_Amount__c = opp.Amount * rate
                );

                updateList.add(updatedOpp);
            }
        }

        if(!updateList.isEmpty()){
            update updateList;
        }
    }
}