public class Passwordgenerator {
    public static String generatePassword(Integer K) {

        if(K <= 0){
            return '';
        }

        if(K == 1){
            return '1';
        }

        String password = '';

        for(Integer i = 1; i <= K-2; i++){
            password += '1';
        }

 
        password += '2';

        password += String.valueOf(K);

        return password;
    }

}