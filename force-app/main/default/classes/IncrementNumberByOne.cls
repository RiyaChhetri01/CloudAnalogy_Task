public class IncrementNumberByOne {
    public static void incrementElements(){

   
        List<Integer> numbers = new List<Integer>{5, 10, 15, 20};

        for(Integer i = 0; i < numbers.size(); i++){
            numbers[i] = numbers[i] + 1;
               }

        System.debug('Incremented List: ' + numbers);
    }

}