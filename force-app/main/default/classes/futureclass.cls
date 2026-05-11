public class futureclass {
    @future
    public static void existingrecord(Set<Id> existinvalueDid){
        List<Lead> ldlist=([SELECT ID FROM LEAD WHERE ID IN:existinvalueDid]);
        for(Lead ld:ldlist){
            ld.LeadSource='Web';

        
        }
        update ldlist; }  
        
        @future
        public static void creatRec(){
            Lead anotherrec=new Lead(LastName='Test Lead',status='Open-Not Connected',Company='sdfc');
            insert anotherrec;
        

    }}