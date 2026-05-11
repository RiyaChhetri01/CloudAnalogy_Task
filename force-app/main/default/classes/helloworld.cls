public class helloworld{
    public String getDay(Integer daynumber){
        String whichday='';
        
        switch on daynumber{
            when 0{
                whichday='Monday';
            }
            when 1{
                whichday='Tuesday';
            }
            when 2{
                whichday='Wednesday';
            }
            when 3{
                whichday='Thursday';
            }
            when 4{
                whichday='Friday';
            }
            when 5{
                whichday='Saturday';
            }
            when 6{
                whichday='Sunday';
            }
            when else{
                whichday='Invalid day number';
            }
        }
      return whichday;
    }
    public static void getval(){
        list<account> acc=[select name,type from account where ownerid=:userinfo.getuserid()];
        for(Account ac:acc){
            system.debug(ac.name);
        }
    }
    
    }