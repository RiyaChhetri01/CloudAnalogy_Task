public class PrimeNumberBetween2AndN {
    public static Boolean getPrimeNum(Integer n){
        if(n<=1){
            return false;
        }
        else{
            for (Integer i=2;i<=Math.sqrt(n);i++){
                if(Math.mod(n,i)==0){
                    return false;
                }
            }
        }
        return true;
    }
    public static void checkPrime(Integer num){
        for (Integer i=2;i<=num;i++){
            if(getPrimeNum(i)){
                System.debug(i);
            }
        }
        
    }

}