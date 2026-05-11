public class StableNnumber {
    public static Boolean isStable(Integer num){
        Map<String,Integer>table = new Map<String,Integer>();
        String num_s = String.valueOf(num);
        
        for(Integer i = 0; i<num_s.length(); i++){
            String ch = num_s.substring(i,i+1);
            
            if(table.containsKey(ch)){
                table.put(ch, table.get(ch)+1);
                
            }else{
                table.put(ch,1);
            }
        }
        
        Integer top_c = table.values()[0];
        
        for(Integer x : table.values())
        {
            if(top_c != x)
            {return false;}
        }
        
        return true;
        
    }
    public static void MapTo(){
        
         List<Integer> totalNumber=new List<Integer>{12, 1313, 122, 678, 898};
             Integer stable=0;Integer un = 0;
         
             for(Integer num : totalNumber){
                 if(isStable(num)){
                     stable += num;
                 }else{
                     un += num;
                 }
             }  
        System.debug('The Password is ' + (stable+un));
        
    }
        
}