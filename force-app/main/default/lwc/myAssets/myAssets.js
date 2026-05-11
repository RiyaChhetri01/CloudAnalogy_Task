import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import getProductAssets from '@salesforce/apex/AssetController.getProductAssets';
import getServiceAssets from '@salesforce/apex/AssetController.getServiceAssets';
import updateWarranty from '@salesforce/apex/AssetController.updateWarranty';
import createCaseFromAsset from '@salesforce/apex/AssetController.createCaseFromAsset';

import { refreshApex } from '@salesforce/apex';

const productColumns = [
    { label: 'Asset Name', fieldName: 'Name', type: 'text' },
    { label: 'Status', fieldName: 'customStatus', type: 'text' },
   
    { label: 'Warranty Date', fieldName: 'Warranty_End_Date__c', type: 'date' },
    {
        type: 'button',
        typeAttributes: {
            label: 'Create Case',
            name: 'create_case',
            variant: 'brand',
            disabled: { fieldName: 'isCreateCaseDisabled' }
        }
    },
    {
        type: 'button',
        typeAttributes: {
            label: 'Extend Warranty',
            name: 'extend_warranty',
            variant: 'neutral',
            disabled: { fieldName: 'isRenewDisabled' }
        }
    }
];

const serviceColumns = [
    { label: 'Asset Name', fieldName: 'Name', type: 'text' },
    { label: 'Status', fieldName: 'customStatus', type: 'text' },
  
    { label: 'Warranty End Date', fieldName: 'Warranty_End_Date__c', type: 'date' },
    {
        type: 'button',
        typeAttributes: {
            label: 'Create Case',
            name: 'create_case',
            variant: 'brand',
            disabled: { fieldName: 'isCreateCaseDisabled' }
        }
    },
    {
        type: 'button',
        typeAttributes: {
            label: 'Service Renew',
            name: 'service_renew',
            variant: 'neutral',
            disabled: { fieldName: 'isRenewDisabled' }
        }
    }
];

export default class MyAssets extends NavigationMixin(LightningElement) {

    planOptions = [
    { label: '3 Months Plan', value: '3', price: 500 },
    { label: '6 Months Plan', value: '6', price: 900 },
    { label: '12 Months Plan', value: '12', price: 1500 },
    { label: '24 Months Plan', value: '24', price: 2500 }
];

   selectedPlanValue;
   get selectedPlan() {

    for (let i = 0; i < this.planOptions.length; i++) {

        if (this.planOptions[i].value === this.selectedPlanValue) {
            return this.planOptions[i];
        }
    }

    return null;
}
    get calculatePlan(){
        if(!this.selectedPlan)
            return null;
        const today=new Date();
        const newDate=new Date(today);
        newDate.setMonth(
            newDate.getMonth() + parseInt(this.selectedPlan.value)
        );
        return newDate.toLocaleDateString();
    }
    isLoading = true;
    products = [];
    services = [];

    productColumns = productColumns;
    serviceColumns = serviceColumns;

    selectedAssetId;

    showWarrantyModal = false;
    showCaseModal = false;
    showSuccessModal = false;

    isLoading = false;
    isMobile = false;

    newWarrantyDate;

    caseSubject = '';
    caseStatus = 'New';
    caseDescription = '';

    createdCaseId;
    createdCaseNumber;

    wiredProductsResult;
    wiredServicesResult;
    handleDurationChange(event) {
        this.selectedPlanValue = event.detail.value;
    }
    connectedCallback() {
        this.checkScreen();
        window.addEventListener('resize', this.handleResize);
    }

    disconnectedCallback() {
        window.removeEventListener('resize', this.handleResize);
    }

    handleResize = () => {
        this.checkScreen();
    }

    checkScreen() {
        this.isMobile = window.innerWidth <= 768;
    }
    


    processAssets(data) {
        const today = new Date();

        return data.map(row => {
            const warrantyDate = row.Warranty_End_Date__c
                ? new Date(row.Warranty_End_Date__c)
                : null;

            let customStatus = '';
            let isCreateCaseDisabled = true;
            let isRenewDisabled = true;

            if (!warrantyDate) {
                customStatus = 'No Warranty';
                isRenewDisabled = false;
            }
            else if (warrantyDate < today) {
                customStatus = 'Expired';
                isRenewDisabled = false;
            }
            else {
                customStatus = 'Active';
                isCreateCaseDisabled = false;
            }

            return {
                ...row,
                customStatus,
                isCreateCaseDisabled,
                isRenewDisabled,
                statusClass: `status-badge ${
                    customStatus === 'Active' ? 'status-active' :
                    customStatus === 'Expired' ? 'status-expired' :
                    'status-nowarranty'
                }`
            };
        });
    }

    
    @wire(getProductAssets)
    wiredProducts(result) {
    this.wiredProductsResult = result;

    if (result.data) {
        this.products = this.processAssets(result.data);
        this.isLoading = false;
    } 
    else if (result.error) {
        console.error(result.error);
        this.products = [];
        this.isLoading = false;
    }
}

    @wire(getServiceAssets)
    wiredServices(result) {
    this.wiredServicesResult = result;

    if (result.data) {
        this.services = this.processAssets(result.data);
        this.isLoading = false;
    } 
    else if (result.error) {
        console.error(result.error);
        this.services = [];
        this.isLoading = false;
    }
}

   
    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        this.selectedAssetId = row.Id;

        if (actionName === 'create_case') {
            this.handleCreateCaseDirect(row);
        }

        if (actionName === 'extend_warranty' || actionName === 'service_renew') {
            this.showWarrantyModal = true;
        }
    }

    handleCreateCase(event) {
        const assetId = event.target.dataset.id;

        const row = [...this.products, ...this.services]
            .find(item => item.Id === assetId);

        if (row) {
            this.handleCreateCaseDirect(row);
        }
    }

    handleCreateCaseDirect(row) {
        this.selectedAssetId = row.Id;
        this.caseSubject = 'Case for Asset: ' + row.Name;
        this.caseStatus = 'New';
        this.caseDescription = '';
        this.showCaseModal = true;
    }

    handleRenew(event) {
        this.selectedAssetId = event.target.dataset.id;
        this.showWarrantyModal = true;
    }

  
    closeWarrantyModal() {
    this.showWarrantyModal = false;
    this.selectedPlanValue = null; 
}

    handleDateChange(event) {
        this.newWarrantyDate = event.target.value;
    }
   

  
    closeCaseModal() {
        this.showCaseModal = false;
        this.caseSubject = '';
        this.caseStatus = 'New';
        this.caseDescription = '';
    }

    handleSubjectChange(event) {
        this.caseSubject = event.target.value;
    }

    handleStatusChange(event) {
        this.caseStatus = event.target.value;
    }

    handleDescriptionChange(event) {
        this.caseDescription = event.target.value;
    }

    saveCase() {

    if (!this.caseSubject) {
        alert('Subject is required');
        return;
    }

    this.isLoading = true;

    createCaseFromAsset({
        assetId: this.selectedAssetId,
        subject: this.caseSubject,
        status: this.caseStatus,
        description: this.caseDescription
    })
    .then(result => {

        this.createdCaseId = result.caseId;
        this.createdCaseNumber = result.caseNumber;

        this.showCaseModal = false;
        this.showSuccessModal = true;

    })
    .catch(error => console.error(error))
    .finally(() => {
        this.isLoading = false;
    });
}
    saveWarranty() {
    if (!this.selectedPlan) {
        alert('Please select a plan');
        return;
    }

    this.isLoading = true;

    const today = new Date();
    const newDate = new Date(today);

    newDate.setMonth(
        newDate.getMonth() + parseInt(this.selectedPlan.value)
    );

    updateWarranty({
        assetId: this.selectedAssetId,
        newDate: newDate.toISOString().split('T')[0]
    })}
    //.then(() => {
    //    this.showWarrantyModal = false;
       // this.selectedPlanValue = null;

    //})
    //.catch(error => console.error(error))
    //.finally(() => {
      //  this.isLoading = false;
    //});


    closeSuccessModal() {
        this.showSuccessModal = false;
    }

    goToCases() {
    if (!this.createdCaseNumber) return;

    this[NavigationMixin.Navigate]({
        type: 'comm__namedPage',
        attributes: {
            name: 'Case_Detail__c'   
        },
        state: {
             c__caseNumber: this.createdCaseNumber  
        }
    });
}     handleCreateAsset() {

    this[NavigationMixin.Navigate]({
        type: 'standard__objectPage',
        attributes: {
            objectApiName: 'Asset',
            actionName: 'new'
        }
    });

}

    get hasProducts() {
        return this.products.length > 0;
    }

    get hasServices() {
        return this.services.length > 0;
    }

    get statusOptions() {
        return [
            { label: 'New', value: 'New' },
            { label: 'Working', value: 'Working' },
            { label: 'Closed', value: 'Closed' }
        ];
    }
    get hasNoAssets() {
         return this.products.length === 0 &&  this.services.length === 0;
    }
    
}