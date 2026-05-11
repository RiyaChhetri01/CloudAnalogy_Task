public class wordReverser {
    public static String wordReverserEncode(String sentence) {

        List<String> words = sentence.split(' ');

        String result = '';

        for(Integer i = words.size() - 1; i >= 0; i--) {

            String word = words[i];
            Integer length = word.length();

            result += word + length;

            if(i != 0){
                result += ' ';
            }
        }

        return result;
    }

}