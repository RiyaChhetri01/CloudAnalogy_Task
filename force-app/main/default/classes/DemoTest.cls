public class DemoTest {
    public static Boolean PrintPrime(Integer n){
        Integer count=0;
        for(Integer i =2; i<=Math.sqrt(n);i++){
            if(math.mod(n,i)==0){
                return false;
            }}
        return true;
        
            
        
    }
    public static void isPrime(Integer a){
        Integer sum=0;
        for(Integer i=2;i<=a;i++){
            if(PrintPrime(i)){
                sum +=i;
            }
        }
        System.debug(sum);
    }
        

}