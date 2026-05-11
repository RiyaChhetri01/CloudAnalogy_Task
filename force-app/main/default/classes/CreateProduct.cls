public class CreateProduct {
    public static void createProduct(){
        List<Product2> pp=new List<Product2>();
        for(Integer i=1;i<=10;i++){
            Product2 prod=new Product2();
                prod.Name='TestAccount'+i;
                prod.ProductCode='PD'+i;
                prod.Description='It Is a TestAccount'+i;
                prod.Family='Software';
                
                pp.add(prod);
                
            
           
        }
         insert pp;
    }
    

}