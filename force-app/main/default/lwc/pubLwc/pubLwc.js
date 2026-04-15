import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import COUNTING_UPDATED_CHANNEL from '@salesforce/messageChannel/counting_updated__c';

export default class PubLwc extends LightningElement {
  @wire(MessageContext)
  messageContext; // reference to MessageContext

  handleIncrement() {
    const payload = {
      operator: 'add',
      constant: 1
    };
    publish(this.messageContext, COUNTING_UPDATED_CHANNEL, payload);
  }

  handleDecrement() {
    const payload = {
      operator: 'subtract',
      constant: 1
    };
    publish(this.messageContext, COUNTING_UPDATED_CHANNEL, payload);
  }

  handleMultiply() {
    const payload = {
      operator: 'multiply',
      constant: 1
    };
    publish(this.messageContext, COUNTING_UPDATED_CHANNEL, payload);
  }
}
