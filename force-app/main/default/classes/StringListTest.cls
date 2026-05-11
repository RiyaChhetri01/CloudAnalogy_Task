public class StringListTest {
    public static List<String> generateStringList(Integer n){
        List<String>myList=new List<String>();
        for (Integer i =0; i<n; i++){
            myList.add('Test ' +i);
            
        }
        return myList;
    }

}