import { LightningElement, api, wire, track } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import jsPDFLibrary from '@salesforce/resourceUrl/jsPDFLibrary';
import autoTablePlugin from '@salesforce/resourceUrl/autoTablePlugin';
import getAccountHierarchy from '@salesforce/apex/HandlerForPdfMaker.getAccountHierarchy';
import logo from '@salesforce/resourceUrl/logo';

export default class GeneratePDFCmp extends LightningElement {
    @api recordId;
    @track isModalOpen = false;
    jsPDFInitialize = false;

    accData;
    contacts = [];
    opps = [];

    
    @wire(getAccountHierarchy, { accountId: '$recordId' })
    wiredData({ error, data }) {
        if (data) {
            this.accData = data?.account?.[0] || {};
            this.contacts = data?.contacts || [];
            this.opps = data?.opportunities || [];
        } else if (error) {
            console.error(error);
        }
    }

    renderedCallback() {
        if (this.jsPDFInitialize) return;

        Promise.all([
            loadScript(this, jsPDFLibrary),
            loadScript(this, autoTablePlugin)
        ])
        .then(() => {
            this.jsPDFInitialize = true;
            console.log('jsPDF loaded');
        })
        .catch(error => {
            console.error(error);
        });
    }

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    
    loadImageAsBase64(url) {
        return new Promise((resolve, reject) => {
            const img = new Image();
            img.crossOrigin = 'Anonymous';

            img.onload = function () {
                const canvas = document.createElement('canvas');
                canvas.width = img.width;
                canvas.height = img.height;

                const ctx = canvas.getContext('2d');
                ctx.drawImage(img, 0, 0);

                resolve(canvas.toDataURL('image/png'));
            };

            img.onerror = reject;
            img.src = url;
        });
    }

    async generatePDF() {
        try {
            if (!this.jsPDFInitialize) {
                alert('Libraries still loading...');
                return;
            }

            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();

            const pageWidth = doc.internal.pageSize.getWidth();

            const logoBase64 = await this.loadImageAsBase64(logo);

            doc.addImage(
                logoBase64,
                'PNG',
                pageWidth - 50,//x
                10,//y
                35,//width
                20//height
            );

            doc.setFontSize(16);
            doc.text('Account Report', 14, 15);

            doc.setFontSize(11);
            doc.text(`Name: ${this.accData.Name || 'N/A'}`, 14, 25);
            doc.text(`Account ID: ${this.accData.Id || 'N/A'}`, 14, 32);

            doc.setFontSize(12);
            doc.text('Contacts', 14, 45);

            const contactRows = this.contacts.map(c => [
                c.Name || 'N/A', c.Email || 'N/A', c.Phone || 'N/A'
            ]);

            doc.autoTable({
                startY: 50,
                head: [['Name', 'Email', 'Phone']],
                body: contactRows,
                theme: 'striped'
            });

            
            let finalY = doc.lastAutoTable.finalY || 80;

            doc.text('Opportunities', 14, finalY + 10);

            const oppRows = this.opps.map(o => [o.Name || 'N/A',  o.StageName || 'N/A', o.Amount || 0 ]);

            doc.autoTable({
                startY: finalY + 15,
                head: [['Opportunity Name', 'Stage', 'Amount']],
                body: oppRows,
                theme: 'striped'
            });

            
            doc.save(`${this.accData.Name || 'Account'}_Details.pdf`);

            this.closeModal();

        } catch (error) {
            console.error('PDF Error:', error);
        }
    }
}