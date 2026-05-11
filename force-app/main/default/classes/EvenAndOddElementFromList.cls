public class EvenAndOddElementFromList {
    public static void evenOdd(){
        List<Integer> mainList=new List<Integer>{2,5,3,6,8,0,12,15,67};
        List<Integer> even=new List<Integer>();
		List<Integer> odd=new List<Integer>();
        Integer sumOfeven=0;
        Integer sumOfodd=0;
        for (Integer n:mainList){
            if(Math.mod(n,2)==0){
                even.add(n);
                sumOfeven+=n;
                
            }
            if(Math.mod(n,2)!=0){
                odd.add(n);
                sumOfodd+=n;
                
            }
            
        }
        System.debug('even element list' +even);
        System.debug('odd element list' +odd);
        System.debug('even sum ' +sumOfeven);
        System.debug('odd sum ' +sumOfodd);

        
    }

}