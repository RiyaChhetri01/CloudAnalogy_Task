import { LightningElement, api, wire } from 'lwc';
import AccOpp from '@salesforce/apex/BrainStormingApex.AccOpp';

export default class OpportunityRecordCard extends LightningElement {
    @api recordId; 
    opportunities = [];

    @wire(AccOpp, { accountId: '$recordId' })
    wiredOpps({ error, data }) {
        if (data) {
            this.opportunities = data.map(opp => {
                let rank = 'Low';
                if (opp.Amount >= 1000) {
                    rank = 'High';
                } else if (opp.Amount >= 500) {
                    rank = 'Medium';
                } 
                
                
                return { ...opp, rank }; 
            });
        } else if (error) {
            console.error(error);
        }
    }
}
