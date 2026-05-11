public class ConvertNumToText {
    public static void printNum(Integer n){
        String[] Word=new String[]{'ZERO','ONE','TWO','THREE','FOUR',
            'FIVE','SIX','SEVEN','EIGHT','NINE'};
                String result='';
                
        while(n>0){
            Integer lastdigit=Math.mod(n,10);
            result+=Word[lastdigit]+' ';
            n=n/10;
        }
        System.debug(result);
    }

}