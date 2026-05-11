import { LightningElement, api } from 'lwc';

export default class CreateDataOfPdfGenerator extends LightningElement {
    
    @api accountData = {};
    @api contactData = [];
    @api opportunityData = [];
}