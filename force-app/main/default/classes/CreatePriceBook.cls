public class CreatePriceBook {
    public static void createPriceBook(){
        //create pricebook
        Pricebook2 pb=new Pricebook2(
            Name='Algo Pricebook',
            IsActive=true
        );
        insert pb;
        List<Product2> prod=new List<Product2>();
        for(Integer i=1;i<10;i++){
        	Product2 pp=new Product2();
            pp.Name='SampleProduct'+i;
            pp.ProductCode='P00'+i;
            pp.Family='Software'+i;
            pp.isActive=true;
            prod.add(pp);
    }
        insert prod;
        // Step 3: Get Standard Pricebook Id
        Id standardPricebookId = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1].Id;

        // Step 4: Create standard prices for all products
        List<PricebookEntry> standardPriceEntries = new List<PricebookEntry>();
        for (Product2 p : prod) {
            standardPriceEntries.add(new PricebookEntry(
                Pricebook2Id = standardPricebookId,
                Product2Id = p.Id,
                UnitPrice = 50, // standard price
                IsActive = true
            ));
        }
        insert standardPriceEntries;
        List<PricebookEntry> ppEntry=new List<PricebookEntry>();
       
        for(Integer i=0;i<prod.size();i++){
            PricebookEntry pbe=new PricebookEntry();
            pbe.Pricebook2Id=pb.Id;
            pbe.Product2Id=prod[i].Id;
            pbe.UnitPrice=100;
            pbe.IsActive=true;
            ppEntry.add(pbe);
        }
        insert ppEntry;
         
    }
}