public class exchangeOfNumber {
    public static void exchange(Double a,Double b){
        System.debug('before number:a'+a +',b:'+b);
        Double temp=a;
        a=b;
        b=temp;
        System.debug('after number :a'+a+',b:'+b);
        
    }

}