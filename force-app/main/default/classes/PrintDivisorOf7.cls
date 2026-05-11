public class PrintDivisorOf7 {
    public static void sevenDivisor(){
        for(Integer i=1;i<=100;i++){
            if(Math.mod(i,7)==0){
                System.debug(i + 'is divisble by seven');
            }
            
        }
        
    }

}