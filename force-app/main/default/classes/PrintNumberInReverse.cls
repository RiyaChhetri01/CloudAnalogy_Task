public class PrintNumberInReverse {
    public static Integer ReverseNum(Integer num){
        Integer reverse=0;
        
        if (num==null){
            return -1;
        }
        Integer sign=(num<0)?-1:1;
        Integer n=Math.abs(num);
        while(n>0){     
            Integer ld=Math.mod(n,10);
            reverse=reverse*10+ld;
            n=n/10;
          
            
         }
          return reverse*sign;
   
        
        
    }

}