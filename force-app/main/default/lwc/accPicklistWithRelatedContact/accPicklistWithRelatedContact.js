import { LightningElement ,track } from 'lwc';
import getAccountforCombobox from '@salesforce/apex/handlingClassMaing.getAccountforCombobox';
import getCon from '@salesforce/apex/handlingClassMaing.getCon';
const columns=[{label:'Accountid',fieldName:'AccountId'},{label:'Name',fieldName:'firstName'},{label:'Name',fieldName:'LastName'},
    { label:'Phone',fieldName:'Phone'}
    ];

export default class AccPicklistWithRelatedContact extends LightningElement {
   
  @track columns=columns;
  value='';
  accOption=[];
  contacts=[]
  get options(){
    return this.accOption;
  }
  connectedCallback(){
    getAccountforCombobox()
    .then(result=>{
        let arr=[];
        for(var i=0;i<result.length;i++){
            arr.push({label:result[i].Name,value:result[i].Id});
        }
        this.accOption=arr
    })
    .catch(error=>{
        console.log(error)
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
        })}
        get hasContacts() {
        return this.contacts && this.contacts.length > 0;
    }

    
  }
