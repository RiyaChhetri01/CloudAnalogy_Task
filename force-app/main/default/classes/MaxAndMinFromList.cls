public class MaxAndMinFromList {
    public static void MinMax(){
        List<Integer> ls=new List<Integer>{1,3,5,7,8,2};
            Integer min=ls[0];
            Integer max=ls[0];
        
        for(Integer n:ls){
            if(n<min){
                
              min=n;
            }
            if(n>max){
                max=n;
            }
        }
        System.debug('min '+min);
        System.debug('max '+max);
        
    }

}