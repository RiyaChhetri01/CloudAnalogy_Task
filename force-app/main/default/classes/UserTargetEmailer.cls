public class UserTargetEmailer {
    
    public static void sendVolumeAlerts() {

        Map<Id, Integer> userAccountCount = new Map<Id, Integer>();
        for (AggregateResult ar : [SELECT OwnerId, COUNT(Id) cnt FROM Account WHERE Phone != null GROUP BY OwnerId HAVING COUNT(Id) > 100]) {
            userAccountCount.put((Id)ar.get('OwnerId'), (Integer)ar.get('cnt'));
        }


        Set<Id> finalUserIds = new Set<Id>();
        for (AggregateResult ar : [SELECT OwnerId, COUNT(Id) cnt FROM Contact WHERE Email != null AND OwnerId IN :userAccountCount.keySet() GROUP BY OwnerId HAVING COUNT(Id) > 30]) {
            finalUserIds.add((Id)ar.get('OwnerId'));
        }

        if (finalUserIds.isEmpty()) return;


        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (User u : [SELECT Email, Name FROM User WHERE Id IN :finalUserIds AND IsActive = true]) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] { u.Email });
            mail.setSubject('High Volume Record Ownership Alert');
            mail.setPlainTextBody('Hello ' + u.Name + ',\n\nYou are receiving this because you own >100 Accounts with phones and >30 Contacts with emails.');
            emails.add(mail);
        }

        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
            System.debug('Sent ' + emails.size() + ' notification emails.');
        }
    }
}