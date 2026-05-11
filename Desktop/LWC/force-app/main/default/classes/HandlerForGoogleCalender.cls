public class HandlerForGoogleCalender implements Queueable, Database.AllowsCallouts {

    private List<Id> eventIds;

    public HandlerForGoogleCalender(List<Id> eventIds){
        this.eventIds = eventIds;
    }

    public void execute(QueueableContext context){

        List<Event> events = [
            SELECT Id, Subject, StartDateTime, EndDateTime, Description, WhoId 
            FROM Event 
            WHERE Id IN :eventIds
        ];

        Set<Id> contactIds = new Set<Id>();
        for(Event e : events){
            if(e.WhoId != null){
                contactIds.add(e.WhoId);
            }
        }

        Map<Id, Contact> contactMap = new Map<Id, Contact>();
        if(!contactIds.isEmpty()){
            contactMap = new Map<Id, Contact>(
                [SELECT Id, Email, Name FROM Contact WHERE Id IN :contactIds]
            );
        }

        List<Event> updateList = new List<Event>();
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();

        for(Event e : events){

            try{
                String startTime = formatDateTime(e.StartDateTime);
                String endTime = (e.EndDateTime != null)
                    ? formatDateTime(e.EndDateTime)
                    : formatDateTime(e.StartDateTime.addHours(1));

                Map<String, Object> body = new Map<String, Object>{
                    'summary' => e.Subject,
                    'description' => e.Description,
                    'start' => new Map<String, String>{
                        'dateTime' => startTime,
                        'timeZone' => 'Asia/Kolkata'
                    },
                    'end' => new Map<String, String>{
                        'dateTime' => endTime,
                        'timeZone' => 'Asia/Kolkata'
                    }
                };

                HttpRequest req = new HttpRequest();
                req.setEndpoint('callout:GoogleCalendarCredentials/calendar/v3/calendars/primary/events');
                req.setMethod('POST');
                req.setHeader('Content-Type', 'application/json');
                req.setBody(JSON.serialize(body));

                HttpResponse res = new Http().send(req);

                System.debug('Response Code: ' + res.getStatusCode());

                
                if(e.WhoId != null 
                   && contactMap.containsKey(e.WhoId)
                   && contactMap.get(e.WhoId).Email != null){

                    String eventLink = URL.getOrgDomainUrl().toExternalForm() 
                        + '/lightning/r/Event/' + e.Id + '/view';

                    String emailBody =
                        'Hello ' + contactMap.get(e.WhoId).Name + ',\n\n' +
                        'Your event has been successfully created.\n\n' +
                        'Details:\n' +
                        'Subject: ' + e.Subject + '\n' +
                        'Event Link: ' + eventLink + '\n\n' +
                        'Thank you!';

                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                    mail.setToAddresses(new List<String>{
                        contactMap.get(e.WhoId).Email
                    });
                    mail.setSubject('Event Created Successfully');
                    mail.setPlainTextBody(emailBody);

                    emailsToSend.add(mail);
                }

                if(res.getStatusCode() == 200 || res.getStatusCode() == 201){
                    e.Status__c = 'Success';
                } else {
                    e.Status__c = 'Failed';
                }

            } catch(Exception ex){
                e.Status__c = 'Failed';
                System.debug('Error: ' + ex.getMessage());
            }

            updateList.add(e);
        }

        if(!emailsToSend.isEmpty()){
            Messaging.sendEmail(emailsToSend);
        }

        if(!updateList.isEmpty()){
            update updateList;
        }
    }

    private static String formatDateTime(DateTime dt){
        if(dt == null) return null;
        return dt.format('yyyy-MM-dd\'T\'HH:mm:ssXXX');
    }
}