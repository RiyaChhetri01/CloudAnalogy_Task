public class AddinglastdigitTwoNumber {
    public static void addingnumber(Integer num1,Integer num2){
        Integer temp1=Math.mod(num1,10);
        Integer temp2=Math.mod(num2,10);
        Integer sumOftwo=temp1+temp2;
        System.debug(sumOftwo);
        
    }
    

}