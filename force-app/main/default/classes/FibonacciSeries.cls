public class FibonacciSeries {
    public static void checkFibonacci(Integer n){
        
        Integer a=0;
        Integer b=1;
        System.debug(a);
        System.debug(b);
        
        for(Integer i=2;i<n;i++){
            Integer next=a+b;
            System.debug(next);
            
            a=b;
            b=next;
        }
    }

}