import { LightningElement,track } from 'lwc';
import getAccountforCombobox from '@salesforce/apex/handlingClassMaing.getAccountforCombobox';
import getCon from '@salesforce/apex/HandlerForPdfMaker.getAccountFullData';
import AccOpp from '@salesforce/apex/HandlerForPdfMaker.getAccountFullData';

const col1=[{label:'AccountId',fieldName:'AccountId'},
    {label:'FirstName',fieldName:'FirstName'},
     {label:'LastName',fieldName:'LastName'},
    {label:'Phone',fieldName:'Phone'}
]
const col2=[{label:'AccountId',fieldName:'AccountId'},
    {label:'Opportunity Name',fieldName:'Name'},
     {label:'StageName',fieldName:'StageName'}
]
export default class ShowAccRelatedConAndOpp extends LightningElement {
    @track columns1=col1;
    @track columns2=col2;
    value='';
    accOptions=[];
    contacts=[];
    opportunities=[];
    get options(){
        return this.accOptions;
    }

    connectedCallback(){
       getAccountforCombobox()
       .then(result=>{
        let arr=[];
        for(var i=0;i<result.length;i++){
            arr.push({label:result[i].Name,value:result[i].Id})

        }
        this.accOptions=arr;
       })
       .catch(error=>{
        console.log(error);
       })
    }
    handleChange(event){
        this.value=event.detail.value;
    
    getCon({accountId:this.value})
    .then(result=>{
        this.contacts=result;

    })
    .catch(error=>{
        console.log(error);
    })

    AccOpp({accountId:this.value})
    .then(result=>{
        this.opportunities=result;
    })
    .catch(error=>{
        console.log(error);
    })


}
    get hasContacts(){
    return this.contacts && this.contacts.length>0;
}
    get hasOpportunity(){
        return this.opportunities && this.opportunities.length>0;
    }


        
    

    


}