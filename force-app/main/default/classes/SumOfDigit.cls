public class SumOfDigit {
    public static Integer sumDigit(Integer num){
        Integer sum=0;
        while (num>0){
            Integer digit=Math.mod(num,10);
        	sum=sum+digit;
        	num=num/10;
        }
        return sum;
        
        
        
    }

}