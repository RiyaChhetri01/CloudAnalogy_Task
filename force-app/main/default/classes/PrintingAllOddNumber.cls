public class PrintingAllOddNumber {
    public static void AllOddNum(Integer n){
        Integer i=1;
        while(i<=n){
            if(Math.mod(i,2)!=0){
                System.debug(i);
            }
            i++;
        }
        
    }

}