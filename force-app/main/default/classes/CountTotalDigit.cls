public class CountTotalDigit {
    public static Integer countDigit(Integer num){
        Integer count=0;
        while (num>0){
            Integer digit=Math.mod(num,10);
            count+=1;
            num=num/10;
        }
        return count;
    }

}