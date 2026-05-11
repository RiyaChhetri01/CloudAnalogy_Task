public class TensPlaceNumber {
    public static Integer getNumTenplace(Integer i){
        if(i<10){
            return -1;
        }
        if (i==null){
            return -1;
        }
      
        i=math.abs(i);
        
       
        return Math.mod(i/10,10);
        
    }

}