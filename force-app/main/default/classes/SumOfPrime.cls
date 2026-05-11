public class SumOfPrime {
    public static boolean PrimeCheck(Integer num){
        if(num<=1){
            return false;
        }
        else{
            for(Integer i=2;i<=Math.sqrt(num);i++){
                if(Math.mod(num,i)==0){
                    return false;
                }
            }
            
        }
        return true;
    }
    public static void sumPrime(Integer n){
        Integer sum=0;
        for(Integer i=2;i<=n;i++){
            if(PrimeCheck(i)){
                System.debug(i);
                sum+=i;
                
            }
            
        }
        System.debug('sum will be'+sum);
    }

}