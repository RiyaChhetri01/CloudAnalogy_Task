public class CheckPlaindrome {
    public static Boolean checknumberplaindrome(Integer num){
        Integer val=num;
        Integer reverse=0;
        if(num<0){
            return null;
        }
        while(num>0){
            Integer digit=Math.mod(num,10);
            reverse=reverse*10+digit;
            num=num/10;
        }
        return reverse==val;
    }

}