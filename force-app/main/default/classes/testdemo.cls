public class testdemo {
    public static void handlingcount(Set<Id> accId){
        Map<Id,Integer>accMap=new Map<Id,Integer>();
        for(AggregateResult agr:[SELECT ACCOUNTID,COUNT(ID) total FROM CONTACT WHERE ACCOUNTID IN:accId GROUP BY ACCOUNTID]){
            accMap.put((Id)agr.get('ACCOUNTID'),(INTEGER)agr.get('total'));
        }
        List<Account> accdemo=new List<Account>();
       
       for (Id accsId : accMap.keySet()) {
               accdemo.add(new Account( Id = accsId,total_count_contact__c = accMap.get(accsId)));
        }
        update accdemo;
        
    }

}