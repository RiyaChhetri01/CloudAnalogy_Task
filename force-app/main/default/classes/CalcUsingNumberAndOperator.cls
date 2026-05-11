public class CalcUsingNumberAndOperator {
    public static void calc(Double a,Double b,String op){
        switch on op{
            when '+'{System.debug(a+b);}
            when '-'{System.debug(a-b);}
            when '*'{System.debug(a*b);}
            when '/'{
                if(b==0) System.debug('number cannot be divided by zero');
                else System.debug(a/b);
                    
            
            }
            when else{
                System.debug('invalid operator');
            }
        }
    }

}