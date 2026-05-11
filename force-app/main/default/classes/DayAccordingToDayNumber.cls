public class DayAccordingToDayNumber {
    public static void DayName(Integer day){
    String[] DayName=new String[]{'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'};
        Boolean found=false;
        for (Integer i=0;i<DayName.size();i++){
            if(day==i+1){
                System.debug(DayName[i]);
                 found=true;
                 break;
               
                
            }
            
        }
        if(!found){System.debug('invalid day number');}
        
        }
}