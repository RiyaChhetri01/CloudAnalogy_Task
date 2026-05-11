public class Armstrongnumber {
    
    public static Boolean isArmstrong(Integer i) {
        
        Integer num = i;
        Integer numOrg = i;
        Integer power = 0;
        Integer sum = 0;
        
        
        while (i > 0) {
            power++;
            i = i / 10;
        }
        
        
        while (num > 0) {
            Integer ld = Math.mod(num, 10);
            sum += (Integer)Math.pow(ld, power);
            num = num / 10;
        }
        
        return sum == numOrg;
    }
}