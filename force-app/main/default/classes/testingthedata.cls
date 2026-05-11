@isTest
public class testingthedata  {
    @isTest
    static void testOLICount() {
        // Create Account
        Account acc = new Account(Name='Test Acc', total_opportunity_count__c = 5);
        insert acc;
        
        // Create Opportunity
        Opportunity opp = new Opportunity(Name='Test Opp', AccountId=acc.Id, StageName='Prospecting', CloseDate=Date.today());
        insert opp;
        
        // Get Standard Pricebook ID
        Id pricebookId = Test.getStandardPricebookId();
        
        // Create Product & PricebookEntry
        Product2 prod = new Product2(Name='Test Prod', IsActive=true);
        insert prod;
        
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id=pricebookId, Product2Id=prod.Id, UnitPrice=100, IsActive=true);
        insert pbe;
        
        // ACTION: Add the OLI
        OpportunityLineItem oli = new OpportunityLineItem(OpportunityId=opp.Id, PricebookEntryId=pbe.Id, Quantity=1, UnitPrice=100);
        
        Test.startTest();
        insert oli;
        Test.stopTest();
        
        // VERIFY: Check if the Account updated from 5 to 6
        Account updatedAcc = [SELECT total_opportunity_count__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(6, updatedAcc.total_opportunity_count__c);
    }
}