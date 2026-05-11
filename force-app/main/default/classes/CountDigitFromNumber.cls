public class CountDigitFromNumber {
    public static Integer CountDigitOccurance(Integer numbers, Integer digit){

        Integer count = 0;

        String numStr = String.valueOf(numbers);
        String digitStr = String.valueOf(digit);

        for(Integer i = 0; i < numStr.length(); i++){

            if(numStr.substring(i, i+1) == digitStr){
                count++;
            }
        }

        return count;
    }

}