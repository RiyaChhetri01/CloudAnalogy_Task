import { LightningElement,wire } from 'lwc';
import getFAQs from '@salesforce/apex/KnowledgeController.getFAQs';
export default class FaqHover extends LightningElement {
    faqs = [];
    error;

    @wire(getFAQs)
    wiredFAQs({ data, error }) {
        if (data) {
            this.faqs = data;
        } else if (error) {
            console.error(error);
            this.error = 'Error loading FAQs';
        }
    }
}