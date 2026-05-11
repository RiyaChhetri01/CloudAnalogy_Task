public class ArrangeInOrder {

    public static void ArrangeAsec(Integer a,Integer b,Integer c){
        List<Integer> li = new List<Integer>{a,b,c};
        li.sort();
        System.debug('Asc order: ' + li);
    }

    public static void ArrangeDesc(Integer a,Integer b,Integer c){
        List<Integer> li = new List<Integer>{a,b,c};
        li.sort();
        System.debug('Desc order: ' + li[2] + ', ' + li[1] + ', ' + li[0]);
    }
}