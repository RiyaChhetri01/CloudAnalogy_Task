import { LightningElement, api } from 'lwc';
import savePdfApex from '@salesforce/apex/AccountPdfController.savePdf';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class PreviewPdfWithVsPage extends LightningElement {

    @api recordId;

    get vfUrl() {
        return this.recordId ? '/apex/VfDemoPage?id=' + this.recordId : '';
    }

    savePdf() {
        savePdfApex({ recordId: this.recordId })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'PDF Saved Successfully',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                console.error(error);
            });
    }
}