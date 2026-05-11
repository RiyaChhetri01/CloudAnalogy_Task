public class TermsOfSeries {
    public static     Long factorial(Integer num){
        Long fact=1;
        for (Integer i=1;i<=num;i++){
            fact*=i;
            
        }
        return fact;
    }
    public static void calSeries(Integer n){
        Decimal sum=0;
        for (Integer i=1;i<=n;i++){
            Long fact=factorial(i+1);
            sum+=(Decimal)i/fact;
        }
        System.debug('sum '+sum);
    }

}