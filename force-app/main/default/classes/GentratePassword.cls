public class GentratePassword {
    
    public static Boolean genetratePassword(Integer num){
        Integer old = num;
        Integer val = 0;
        
        while (num > 0){
            Integer LastDigit = Math.mod(num,10); 
            val=val*10;
            val = val+ LastDigit;
            num /= 10;
            
            
            
        }
        return (val == old);
    }
    public static void getSeriesNum(Integer numA,Integer numB){
        Integer sum=0;
        
        for(Integer i=numA; i<=numB; i++){
           
            if( genetratePassword(i) == true){
                   sum += i;
            }
             
            }
         System.debug(sum);
            
        }
       
    }