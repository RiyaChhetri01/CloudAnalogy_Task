public class EvenOrOdd {
    public static Integer isThisEvenOrOdd(Integer num1){
        if(Math.mod(num1,2)== 0){
            return 2;
        }
        else{
            return 1;
        }
    }
}