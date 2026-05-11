import { LightningElement } from 'lwc';
import Account_Object from '@salesforce/schema/Account';
import Account_Name from '@salesforce/schema/Account.Name';
import Account_Phone from '@salesforce/schema/Account.Phone';
import Account_Website from '@salesforce/schema/Account.Website';

export default class SLDS extends LightningElement {
  recordId = "001WU00001oGzevYAC"; // better: use @api recordId
  objectApiName = Account_Object;

  nameField = Account_Name;
  phoneField = Account_Phone;
  websiteField = Account_Website;
}