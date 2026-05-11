public class CalcubeAndSquare {
    public static List<Double> cube(Double num){
        Double cube=num*num*num;
        Double square=num*num;
        return new List<Double>{cube,square};
    }

}