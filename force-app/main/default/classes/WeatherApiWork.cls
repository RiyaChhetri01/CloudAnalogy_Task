public class WeatherApiWork {
    @AuraEnabled
    public static String WeatherApp(String  city){
        HttpRequest req=new HttpRequest();
        req.setEndpoint('callout:WeatherApi/current.json?q='+city);
        req.setMethod('GET');
        HttpResponse res=new HttpResponse();
        Http ht=new Http();
        res=ht.send(req);
        System.debug(res);
        return res.getBody();
    }
}