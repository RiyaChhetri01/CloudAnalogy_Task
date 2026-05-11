import { LightningElement, api, wire } from 'lwc';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';
import { refreshApex } from '@salesforce/apex';
import GOOD_ICON from '@salesforce/resourceUrl/Tick';
import BAD_ICON from '@salesforce/resourceUrl/Cross';
import AVG_ICON from '@salesforce/resourceUrl/Minus';

export default class RelationshipMatrix extends LightningElement {
    @api recordId;
    records=[];
    contacts=[];
    users=[];
    matrixRows=[];
    selectedCell={};
    isModalOpen = false;
    wiredResult;

    goodIcon = GOOD_ICON;
    badIcon = BAD_ICON;
    avgIcon = AVG_ICON;

    @wire(getRelatedListRecords, {
        parentRecordId: '$recordId',
        relatedListId: 'Relationship_Matrices__r',
        fields: [
            'Relationship_Matrix__c.Contact__r.Name',
            'Relationship_Matrix__c.User__r.Name',
            'Relationship_Matrix__c.Health__c'
        ]
    })
    
    wiredData(result) {

        this.wiredResult = result;

        const { data, error } = result;

   
        if (data) {
            // console.log('DATA = ', JSON.stringify(data));
            this.records=data.records.map(row=>{//i have converted a raw datad into simple array from so that i get the idea of my data
                
                return {
                    id:row.id,
                    contact:row.fields.Contact__r.displayValue,
                    user:row.fields.User__r.displayValue,
                    health:row.fields.Health__c.value

                };
            });
            console.log('Simple record ',JSON.stringify(this.records));
            console.log('Records = ', this.records);
            this.contacts=[...new Set(this.records.map(item=>item.contact))];
            this.users=[...new Set(this.records.map(row=>row.user))];
            console.log('Contacts: ',this.contacts);
            console.log('Users: ',this.users);
            this.matrixRows=this.contacts.map(contact=>{//for each contact
                let cells=this.users.map(user=>{//innerloop for each user of contact
                    let match=this.records.find(item=>item.contact==contact && item.user==user);  //find matching records
                    return{
                        key:contact+user,
                        value:match?match.health:'-',
                        recordId:match?match.id:null,
                        image:
                        match?.health === 'Good' ? GOOD_ICON :
                        match?.health === 'Bad' ? BAD_ICON :
                        match?.health === 'Avg' ? AVG_ICON :
                        null
                      
    
                };
                
                        
                    
                }); 
                return{
                    contact:contact,
                    cells:cells

                };
                                               
                                                
            });//console.log('Matrix: ',JSON.stringify(this.matrixRow));

           

        } else if (error) {
            console.log('ERROR = ', JSON.stringify(error));
        }
    }
    handleCellClick(event) {

    let key = event.currentTarget.dataset.key;

    for (let i = 0; i < this.matrixRows.length; i++) {
        let row = this.matrixRows[i];
        for (let j = 0; j < row.cells.length; j++) {
            let cell = row.cells[j];
            if (cell.key === key) {

                this.selectedCell.key = cell.key;
                this.selectedCell.recordId = cell.recordId;
                this.selectedCell.value = cell.value;

                break;
            }
        }
    }

    this.isModalOpen = true;
}

    handleSelect(event) {
        let value = event.currentTarget.dataset.value;
        this.selectedCell.value = value;
    }

    closeModal() {
    this.isModalOpen = false;
}

    handleSuccess() {
        this.isModalOpen = false;
        refreshApex(this.wiredResult);
}

    
}
