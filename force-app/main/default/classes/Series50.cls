public class Series50 {
    public static Long factorial(Integer n){
        Long fact = 1;
        for(Integer i = 1; i <= n; i++){
            fact *= i;
        }
        return fact;
    }
     public static Long power(Integer n){
        Long result = 1;
        for(Integer i = 1; i <= n; i++){
            result *= n;
        }
        return result;
    }
    public static void calculate(Integer n){

        Decimal sum = 0;

        for(Integer i = 1; i <= n; i++){

            Long numPower = power(i);
            Long fact = factorial(i);

            sum += (Decimal)numPower / fact;
        }

        System.debug('Sum = ' + sum);
    }

}