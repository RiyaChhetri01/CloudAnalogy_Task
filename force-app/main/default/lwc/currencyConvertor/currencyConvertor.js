import { LightningElement } from 'lwc';
import getCurrencyRates from '@salesforce/apex/CurrencyConvertor.getCurrencyRates';

export default class CurrencyConvertor extends LightningElement {

    data = [];
    filteredData = [];
    paginatedRows = [];

    pageSize = 10;
    currentPage = 1;
    totalPages = 1;

    searchKey = '';

    columns = [
        { label: 'Currency', fieldName: 'currency', type: 'text' },
        { label: 'Rate', fieldName: 'rate', type: 'number' }
    ];

    connectedCallback(){
        this.loadData();
    }

    loadData(){
        getCurrencyRates()
        .then(result => {

            let tempData = [];

            for(let key in result){
                tempData.push({
                    currency: key,
                    rate: result[key]
                });
            }

            tempData.sort((a,b) => a.currency.localeCompare(b.currency));

            this.data = tempData;
            this.filteredData = tempData;

            this.currentPage = 1;
            this.updatePagination();

        })
        .catch(error => {
            console.error(error);
        });
    }

    handleSearch(event){
        this.searchKey = event.target.value.toLowerCase().trim();

        if(!this.searchKey){
            this.filteredData = [...this.data];
        } else {
            this.filteredData = this.data.filter(row =>
                row.currency &&
                row.currency.toLowerCase().includes(this.searchKey)
            );
        }

        this.currentPage = 1;
        this.updatePagination();
    }

    updatePagination(){
        this.totalPages = Math.ceil(this.filteredData.length / this.pageSize) || 1;

        let start = (this.currentPage - 1) * this.pageSize;
        let end = start + this.pageSize;

        this.paginatedRows = this.filteredData.slice(start, end);
    }

    handlePrevious(){
        if(this.currentPage > 1){
            this.currentPage--;
            this.updatePagination();
        }
    }

    handleNext(){
        if(this.currentPage < this.totalPages){
            this.currentPage++;
            this.updatePagination();
        }
    }

    get disablePrevious(){
        return this.currentPage === 1;
    }

    get disableNext(){
        return this.currentPage === this.totalPages;
    }
}