import { LightningElement, api } from 'lwc';

export default class PdfPreviewModal extends LightningElement {
    
    @api accountData = {};
    @api contactData = [];//data coming from parent
    @api opportunityData = [];

    
    contactColumns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email', type: 'email' }
    ];

    oppColumns = [
        { label: 'Opp Name', fieldName: 'Name' },
        { label: 'Stage', fieldName: 'StageName' },
        { label: 'Amount', fieldName: 'Amount', type: 'currency' }
    ];
}