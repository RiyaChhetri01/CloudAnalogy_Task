public class demotest2 {
    public static void binaryEdition() {
        String a = '100101';
        String b = '0101101';
        
        
        Integer num1 = binaryToDecimal(a);
        Integer num2 = binaryToDecimal(b);
        
      
        Integer sum = num1 + num2;
        
        //  back to Binary String manually
        String result = decimalToBinary(sum);
        
        System.debug('Binary Result: ' + result);
    }

    // Helper: Binary String to Decimal
    private static Integer binaryToDecimal(String binary) {
        Integer val = 0;
        String reverseBinary = binary.reverse(); // Start from the right (2^0)
        for (Integer i = 0; i < reverseBinary.length(); i++) {
            if (reverseBinary.substring(i, i+1) == '1') {
                val += (Integer)Math.pow(2, i);
            }
        }
        return val;
    }

    // Helper: Decimal to Binary String
    private static String decimalToBinary(Integer num) {
        if (num == 0) return '0';
        String binary = '';
        while (num > 0) {
            binary = String.valueOf(Math.mod(num, 2)) + binary;
            num /= 2;
        }
        return binary;
    }
}