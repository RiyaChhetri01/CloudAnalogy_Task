public class demo {
    public static void WhoIsGreater(Double num1,Double num2) {
        if(num1>num2){
            System.debug('num1'+num1+'is greater than '+num2);
            
        }
        else if(num2>num1){
            System.debug('num2'+num2+'is greater than '+num1);
        }
        
        else{
            System.debug('both are equal');
        }
        
        
        
        
    }
}