import { LightningElement, wire } from 'lwc';
import { CurrentPageReference,NavigationMixin  } from 'lightning/navigation';
import getCaseDetails from '@salesforce/apex/AssetController.getCaseDetails';


export default class CaseDetailPage extends NavigationMixin(LightningElement) {

    caseNumber;  
    caseRecord;
    errorMessage;
    isLoading = true;

    @wire(CurrentPageReference)
    getStateParameters(pageRef) {
    if (pageRef && pageRef.state) {
        this.caseNumber = pageRef.state.c__caseNumber;

        console.log('CaseNumber:', this.caseNumber);
    }
}

    @wire(getCaseDetails, { caseNumber: '$caseNumber' })
    wiredCase({ data, error }) {

        if (!this.caseNumber) return; 

        if (data) {
            console.log('Case Data:', data);
            this.caseRecord = data;
        } 
        else if (error) {
            console.error(error);
            this.errorMessage = 'Failed to load case details';
        }

        this.isLoading = false;
    }

    goBack() {
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/my-cases'
            }
        });
    }
}