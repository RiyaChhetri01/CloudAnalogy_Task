public class AccountWithOppLineItem {
  
    public static void OpplineItem(Id sourceOppId){
        

        Opportunity originalOpp = [SELECT Name, CloseDate, AccountId, StageName, Pricebook2Id, 
                                   (SELECT Product2Id, Quantity, UnitPrice, PricebookEntryId, ServiceDate, Description 
                                    FROM OpportunityLineItems) 
                                   FROM Opportunity 
                                   WHERE Id = :sourceOppId];
        
        Opportunity clonedOpp = originalOpp.clone(false, false, false, false);
        
        clonedOpp.Name = originalOpp.Name + ' Clone';
        clonedOpp.CloseDate = originalOpp.CloseDate.addDays(30);
        
       
        insert clonedOpp;
        
      
        List<OpportunityLineItem> clonedItems = new List<OpportunityLineItem>();
        
        for (OpportunityLineItem item : originalOpp.OpportunityLineItems) {
            // Clone the child item
            OpportunityLineItem newItem = item.clone(false, false, false, false);
          
           
            newItem.OpportunityId = clonedOpp.Id; 
            clonedItems.add(newItem);
        }
        
        // 5. Insert children
        if (!clonedItems.isEmpty()) {
            insert clonedItems;
        }
        
        System.debug('New Clone Created with ID: ' + clonedOpp.Id);
    }
}