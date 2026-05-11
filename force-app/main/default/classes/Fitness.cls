public class Fitness{
    public static Decimal calculateBMI(Decimal weight,Decimal height){
        Decimal BMI=weight/(height*height);
        return BMI;
    }
    public static Decimal calculatePace(Decimal distance,Decimal minutes){
        Decimal hr=minutes/60;
        Decimal pace=distance/hr;
        return pace;
    }
 }