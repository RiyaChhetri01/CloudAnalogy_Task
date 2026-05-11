public class Printfactorial {
    public static Long factorial(Integer n){
        Long fact=1;
        for(Integer i=1;i<=n;i++){
            fact=fact*i;
            
            
        }
        return fact;
    }

}