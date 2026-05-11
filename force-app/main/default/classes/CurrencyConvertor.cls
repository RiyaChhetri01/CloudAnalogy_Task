public class CurrencyConvertor {

    @AuraEnabled(cacheable=true)
    public static Map<String, Decimal> getCurrencyRates(){

        Http http = new Http();
        HttpRequest req = new HttpRequest();

        req.setEndpoint('https://v6.exchangerate-api.com/v6/08c55ed77f81725cbc123546/latest/USD');
        req.setMethod('GET');

        HttpResponse res = http.send(req);

        
        Map<String, Object> responseMap =
            (Map<String, Object>) JSON.deserializeUntyped(res.getBody());

        Map<String, Object> rates =
            (Map<String, Object>) responseMap.get('conversion_rates');

        Map<String, Decimal> result = new Map<String, Decimal>();

        for(String key : rates.keySet()){
            result.put(key, Decimal.valueOf(String.valueOf(rates.get(key))));
        }

        return result;
    }
}