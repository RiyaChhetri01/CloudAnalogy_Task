public class PerfectNumber {
    public static Boolean perfectNumber(Integer n){
        if (n<=1){
            return false;
        }
        Integer sum=0;
        for(Integer i=1;i<=n/2;i++){
            If(Math.mod(n,i)==0){
                sum+=i;
            }
        
            
        }
        return sum==n;
        
    }
        

}