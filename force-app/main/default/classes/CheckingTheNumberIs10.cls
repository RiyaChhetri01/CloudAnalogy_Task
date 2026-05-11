public class CheckingTheNumberIs10 {
    public static void checkingTen(Integer num){
        if(num==10){
            System.debug('Number is '+num);
        }
        else if(num>10){
            System.debug(num+' is greater than 10 ');
        }
        else{
            System.debug(num+ 'is smaller than 10 ');
        }
        
        
    }

}