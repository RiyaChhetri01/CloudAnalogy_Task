import { LightningElement, wire } from 'lwc';
import getCases from '@salesforce/apex/AssetController.getCases';
import escalateCase from '@salesforce/apex/AssetController.escalateCase';

const columns = [
    { label: 'Case Number', fieldName: 'CaseNumber' },
    { label: 'Subject', fieldName: 'Subject' },
    { label: 'Status', fieldName: 'Status' },
    { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' },
    { label: 'Priority', fieldName: 'Priority' },
    {
        label: 'Action',
        type: 'button',
        typeAttributes: {
            label: 'Escalate',
            name: 'escalate',
            variant: 'destructive',
            disabled: { fieldName: 'disableEscalate' }
        }
    }
];

export default class CaseList extends LightningElement {

    columns = columns;

    allCases = [];
    cases = [];

    pageSize = 14;
    currentPage = 1;
    totalPages = 1;

    isMobile = false;
    isLoading = true;

    // ------------------ RESPONSIVE ------------------
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

    // ------------------ DATA FETCH ------------------
    @wire(getCases)
    wiredCases({ data, error }) {
        if (data) {
            this.allCases = this.processCases(data);
            this.totalPages = Math.ceil(data.length / this.pageSize);
            this.updatePage();
        } else if (error) {
            console.error(error);
        }

        this.isLoading = false;
    }

    processCases(data) {
        const today = new Date();

        return data.map(item => {
            const lastModified = new Date(item.LastModifiedDate);
            const diffDays = (today - lastModified) / (1000 * 60 * 60 * 24);

            return {
                ...item,
                disableEscalate: diffDays <= 3 || item.Priority === 'High'
            };
        });
    }

    // ------------------ PAGINATION ------------------
    updatePage() {
        const start = (this.currentPage - 1) * this.pageSize;
        const end = this.currentPage * this.pageSize;
        this.cases = this.allCases.slice(start, end);
    }

    handleNext() {
        if (this.currentPage < this.totalPages) {
            this.currentPage++;
            this.updatePage();
        }
    }

    handlePrev() {
        if (this.currentPage > 1) {
            this.currentPage--;
            this.updatePage();
        }
    }

    // ------------------ ACTIONS ------------------
    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === 'escalate') {
            this.escalateCase(row);
        }
    }

    handleEscalateMobile(event) {
        const id = event.target.dataset.id;
        const row = this.allCases.find(c => c.Id === id);

        if (row) {
            this.escalateCase(row);
        }
    }

    escalateCase(row) {
        escalateCase({ caseId: row.Id })
            .then(updatedCase => {

                this.allCases = this.allCases.map(c => {
                    if (c.Id === updatedCase.Id) {

                        const lastModified = new Date(updatedCase.LastModifiedDate);
                        const today = new Date();
                        const diffDays = (today - lastModified) / (1000 * 60 * 60 * 24);

                        return {
                            ...updatedCase,
                            disableEscalate: diffDays <= 3 || updatedCase.Priority === 'High'
                        };
                    }
                    return c;
                });

                this.updatePage();
                this.cases = [...this.cases];

            })
            .catch(error => {
                console.error(error);
            });
    }

    // ------------------ GETTERS ------------------
    get hasCases() {
        return this.cases.length > 0;
    }

    get disablePrev() {
        return this.currentPage === 1;
    }

    get disableNext() {
        return this.currentPage === this.totalPages;
    }
}