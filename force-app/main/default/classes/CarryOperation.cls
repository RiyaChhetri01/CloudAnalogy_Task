public class CarryOperation {
    public static void GivivngCarry(Integer num1,Integer num2){
       
        Integer carry = 0;
        Integer count = 0;
    
        
        while(num1 > 0 || num2 > 0){
            
            Integer lastDigitnNum1 = Math.mod(num1,10);
            Integer lastDigitNum2  = Math.mod(num2,10);
            Integer sum = lastDigitnNum1 + lastDigitNum2 + carry;
            if(sum >= 10){
                carry = 1;
                count++;
   
            }
            
            num1= num1 / 10;
            num2= num2 / 10;
    
        }
        System.debug(count);
        
        
        
    }

}