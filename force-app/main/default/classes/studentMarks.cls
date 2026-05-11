public class studentMarks {
    public static void calcultemarks(Integer Rollnumber,Double Hindi,Double English,Double Maths){
        Double total= Hindi+English+ Maths;
        Double Avg=total/3;
        if(Avg>60){
            System.debug('Grade A');
        }
        else if(Avg<60 && Avg >=50){
            System.debug('Grade B');
        }
        else if (Avg<50 && Avg >=40){
            System.debug('Grade C');
            
        }
        else{
            System.debug('Fail');
        }
    }

}