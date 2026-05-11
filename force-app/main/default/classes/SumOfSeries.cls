public class SumOfSeries {
    public static  void Series(Integer n){
        Integer sum=0;
        for (Integer i=1;i<=n;i++){
            sum+=i*i;
            
        }
        System.debug('sum '+sum);
    }

}