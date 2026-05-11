public class AccountOpportunityReport {
    
    
    public static void getTopPerformingAccounts() {
        
        Date startDate = Date.today().addDays(-30);
        Date endDate = Date.today();

        
        List<AggregateResult> results = [
            SELECT AccountId, COUNT(Id) wonCount
            FROM Opportunity
            WHERE StageName = 'Closed Won'
            AND CloseDate >= :startDate
            AND CloseDate <= :endDate
            AND AccountId != null
            GROUP BY AccountId
            HAVING COUNT(Id) > 10
        ];

 
        Set<Id> accountIds = new Set<Id>();
        for (AggregateResult ar : results) {
            accountIds.add((Id)ar.get('AccountId'));
        }

       
        if (!accountIds.isEmpty()) {
            List<Account> accList = [SELECT Name FROM Account WHERE Id IN :accountIds];
            for (Account acc : accList) {
                System.debug('Qualified Account: ' + acc.Name);
            }
        } else {
            System.debug('No accounts found meeting the criteria.');
        }
    }
}