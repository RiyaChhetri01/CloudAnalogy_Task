public class AdditionOfAllListElement {
    public static void addingElement(){
        Integer sumOfElement=0;
        List<Integer> ls=new List<Integer>{1,2,3,4,5,6,8,9};
            for (Integer i :ls){
                sumOfElement+=i;
            }
        System.debug(sumOfElement);
    }

}