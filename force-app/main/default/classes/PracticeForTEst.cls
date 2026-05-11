public class PracticeForTEst {
    public static void main(){
        Set<String>emailset=new Set<String>();
        for(User u:[SELECT EMAIL FROM USER WHERE IsActive=true]){
            emailset.add(u.Email);
        }
        List<Contact> exstingcontact=[SELECT ID,Name,EMAIL FROM CONTACT WHERE EMAIL IN:emailset];
        System.debug('existingconfact' + exstingcontact.size());
        for(Contact cc:exstingcontact){
            System.debug('contactname'+ cc.Name +'Email :' +cc.Email);
        }
        
    }
    ///finging  user detail
    public static void userfinding(){
        User u=[SELECT ID,NAME,PHONE,EMAIL FROM USER WHERE ID =:userInfo.getUserId()];
        System.debug(u);
    }
    //finding
    public static void linkingAccountWithContact(){
        List<Account> acc=new List<Account>();
        for(Integer i=1;i<=10;i++){
            Account accNAme=new Account();
            accName.Name='uniqueName'+i;
            acc.add(accName);
        }
        if(!acc.isEmpty()){
            insert acc;
        }
        
        Map<Integer,Id> accMap=new Map<Integer,Id>();
        for (Integer i=0;i<acc.size();i++){
            accMap.put(i+1,acc[i].id);
        }
        List<Contact> con =new List<Contact>();
        for(Integer i=1;i<=10;i++){
            Contact cnn=new Contact();
            cnn.LastName='UniqueConname'+i;
            cnn.AccountId=accMap.get(i);
            con.add(cnn);
            
            
        }
        if (!con.isEmpty()){
            insert con;
        }
        
        
        }
    public static void deleteAccountrelatedtoContact(){
        List<Contact> cn=[SELECT ID,ACCOUNTID,ACCOUNT.NAME FROM CONTACT WHERE ACCOUNTID!=NULL AND Account.Name LIKE '%t%'];
        
        If(!cn.isEmpty()){
            Delete cn;
            System.debug('contact delete'+cn.size());
        }
        else{
            system.debug('no matching contact found');
        }
    }
    public static void updateOpportunity(){
        List<Opportunity> oppList=[SELECT NAME, CLOSEDATE From OPPORTUNITY Where CLOSEDATE>TODAY];
        List<Opportunity> oppname=new List<Opportunity>();
        FOR(OPPORTUNITY op:oppList){
            op.Name=op.Name+'F';
            oppname.add(op);
            
            
            
        }
        if(!oppname.isEmpty()){
            update oppname;
            System.debug(oppname.size());
            for(Opportunity onupdate:oppname){
                system.debug(onupdate.Name);
            }
            
            
        }
    }
    public static void customPriceBookMaking(){
        List<Product2> prod=new List<Product2>();
        for(Integer i=0;i<10;i++){
            prod.add(new Product2(Name='TestProductmzking', IsActive=true));
        }
        insert prod;
        //Standard pricebook
        Id stdpricebookid=[SELECT Id From Pricebook2 Where isStandard=true LIMIT 1].Id;
        //priceboookentry
        List<PriceBookEntry>pbe=new List<PriceBookEntry>();
        for(Product2 pb:prod){
            pbe.add(new PricebookEntry(
            Pricebook2Id=stdpricebookid,
            Product2Id=pb.Id,
            UnitPrice=100,
            IsActive=true
            
            ));
        }
        insert pbe;
        //custompricebook
        Pricebook2 customPbentry=new Pricebook2(Name='custompriceBoom' , IsActive=true);
        insert customPbentry;
        //priceBookentry
        List<PricebookEntry> custompbe=new List<PricebookEntry>();
        for(Product2 p:prod){
             custompbe.add(new PricebookEntry(
            Pricebook2Id=customPbentry.Id,
            Product2Id=p.Id,
            UnitPrice=100,
            IsActive=true
            ));
        }
        insert custompbe;
        
        
        
    }
    public static void caseMaking(){
        Account acc=new Account(Name='CloudAnalogy');
        insert acc;
        Contact cnn=new Contact(
        Firstname='CloudAnalogyContact',
        LastName=acc.Name,
        AccountId= acc.Id
        );
        insert cnn;
        
        List<Case> casemaking=new  List<Case>();
        for(Integer i=0;i<=5;i++){
            casemaking.add(new Case(
            AccountId=acc.Id,
                ContactId=cnn.Id,
                Status='New',
                Origin='Phone',
                Priority='Medium'
               
            
            ));
        }
        if(!casemaking.isEmpty()){
             insert casemaking;
        }
       
    }
    public static void documentCopy(){
        Account acc=[Select Id ,Name from account where  Name='sfdz'] ;
        List<Contact> conList=[Select Id,AccountId ,Name from Contact Where AccountId =:acc.Id ];
        List<ContentDocumentLink> Linkdoc=[Select ContentDocumentId from ContentDocumentLink Where LinkedEntityId=:acc.Id ];
        List<ContentDocumentLink> content=new List<ContentDocumentLink>();
        for(Contact cnn:conList){
            for(ContentDocumentLink linkfile:Linkdoc){
                ContentDocumentLink doclink=new ContentDocumentLink(
                ContentDocumentId= linkfile.ContentDocumentId,
                LinkedEntityId=cnn.Id,
                Visibility='AllUsers',
                ShareType='V');
                content.add(doclink);
                
            }
        }
        if(!content.isEmpty()){
            insert content;
            system.debug('successfully inserted' +Linkdoc.size());
        }
    }
     public static void getoliandopp(){
        set<id> oppid=new set<id>();
        List<OPPORTUNITY> OPPLIST=[SELECT ID,ACCOUNTID,NAME,
                                   STAGENAME FROM 
                                   OPPORTUNITY WHERE 
                                   ID IN(SELECT 
                                   OPPORTUNITYID FROM OPPORTUNITYLINEITEM WHERE QUANTITY>100) ];
        FOR(OPPORTUNITY OPP:OPPLIST){
            oppid.add(OPP.ACCOUNTID);
        }
        
        List<Account> accList=[SELECT ID,NAME,(SELECT Id,Name,STAGENAME FROM OPPORTUNITIES WHERE STAGENAME='CLOSED WON')FROM ACCOUNT WHERE ID IN:oppid];
        for (ACCOUNT ACC:accList){
            System.debug('Account name'+ ACC.NAME);
        }
    }
 
 
}