public class EncodingArray {
    public static void encodeArray(){

        List<Integer> arr = new List<Integer>{10, 20, 30, 40};

        List<Integer> reversed = new List<Integer>();

        for(Integer i = arr.size() - 1; i >= 0; i--){
            reversed.add(arr[i]);
        }
        List<Integer> original = new List<Integer>();
        original.addAll(reversed);

        for(Integer i = 0; i < reversed.size() - 1; i++){
            reversed[i] = original[i] + original[i+1];
        }


        System.debug('Encoded Array: ' + reversed);
    }
}