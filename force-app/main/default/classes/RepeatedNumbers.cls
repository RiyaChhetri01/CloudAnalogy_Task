public class RepeatedNumbers {

    public static void findRepeated(){

        List<Integer> numbers = new List<Integer>{10, 20, 10, 30, 20, 10, 40};

        
        Map<Integer, Integer> freqMap = new Map<Integer, Integer>();

        
        for(Integer n : numbers){

            if(freqMap.containsKey(n)){
                freqMap.put(n, freqMap.get(n) + 1);
              }
            else{
                freqMap.put(n, 1);
            }
        }

       
        for(Integer key : freqMap.keySet()){

            if(freqMap.get(key) > 1){
                System.debug(key + ' =' + freqMap.get(key) + ' times');
            }
        }
    }
}