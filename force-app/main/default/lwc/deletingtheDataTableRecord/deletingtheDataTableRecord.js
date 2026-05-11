import { LightningElement ,track,wire} from 'lwc';
import getAccountfordatatable from '@salesforce/apex/handlingClassMaing.getAccountfordatatable';
import DelRec from '@salesforce/apex/handlingClassMaing.DelRec';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {refreshApex} from '@salesforce/apex';
const columns=[{label:'Account ID',fieldName:'Id'},{label:'Account Name',fieldName:'Name'}]
export default class DeletingtheDataTableRecord extends LightningElement {
columns=columns;
wiredResult;
data=[];
selectedIds=[];
@wire(getAccountfordatatable)
wireData(result){
    this.wiredResult=result;
    if(result.data){
        this.data=result.data;
    }
    else if(result.error){
        console.log(result.error);
    }
}
handleRowSelection(event){
    const selectedRowId= event.details.selectedRows;
    this.selectedIds=selectedRowId.map(row=>row.Id);
 
}
handleDelete(){
    if(this.selectedIds.length===0){
        this.ShowToast('error','please selected account','error');
        return;
    }
    DelRec({accountId:this.selectedIds})
    .then(()=>{
        this.ShowToast('Success','Record Deleted successfully','success');
        this.selectedIds=[];
        return refreshApex(this.wiredResult);

        
    })
    .catch(error=>(
        this.ShowToast('error','error in the data','error')
    ))

}
ShowToast(title,message,variant){
    this.dispatchEvent(new ShowToastEvent({titel:title,message:message,variant:variant}))
}

}