public class Company{
    public String companyName;
    public string ceo;
    public Integer employmentCount;
    public Long revenue;
    
    //List of all the customer
    private List<Client> customer=new List<Client>();
    
    //add new customers
    public void addNewCustomer(String clientname,String website,String email,Long phonenumber){
        Client newCustomer=new Client(clientname,website,email,phonenumber);
        //todo:add customer
    	customer.add(newCustomer);
    
    
    }
    public void getAllCustomer(){
        //todo:print all customer
        for (Client newCustomer:customer){
            System.debug('Customer name '+newCustomer.clientname+ ' ,Website:' +newCustomer.website+ ', Email:' +newCustomer.email+ ', Phone '+ newCustomer.phonenumber );
        }
        
    
    }
    //private inner class to store the customer information
    private class Client{
        public String clientname;
        public String website;
        public String email;
        public Long phonenumber;
        
        Client(String clientname,String website,String email,Long phonenumber){
            this.clientname=clientname;
            this.website= website;
            this.email=email;
            this.phonenumber=phonenumber;
             
        }
    }
    
}