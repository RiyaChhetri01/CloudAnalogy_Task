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
        
        const primaryBlue = [0, 16, 100]; 
        const labelGray = [242, 242, 242]; 
        const black = [0, 0, 0];

        // 1. Logo (Left) & Report Titles (Right)
        if (logo) {
            const logoBase64 = await this.loadImageAsBase64(logo);
            // Logo positioned at top left
            doc.addImage(logoBase64, 'PNG', 14, 10, 40, 20);
        }

        // 2. ACCOUNT INFORMATION 
        doc.autoTable({
            startY: 35,
            theme: 'plain',
            head: [['ACCOUNT INFORMATION']],
            headStyles: { fillColor: primaryBlue, textColor: [255, 255, 255], halign: 'center', fontStyle: 'bold' },
            margin: { bottom: 0 }
        });

        doc.autoTable({
            startY: doc.lastAutoTable.finalY,
            theme: 'grid',
            body: [
                ['Account Name', { content: this.accData.Name || 'N/A', colSpan: 3 }],
                ['Website', { content: this.accData.Website || 'N/A', colSpan: 3 }],
                ['Phone', this.accData.Phone || 'N/A', 'Industry', this.accData.Industry || 'N/A'],
                ['Owner', 'System Administrator', 'Prepared By', 'Riya Chhetri']
            ],
            styles: { fontSize: 9, cellPadding: 3, lineColor: black, lineWidth: 0.1 },
            columnStyles: { 
                0: { fillColor: labelGray, fontStyle: 'bold', width: 45 }, 
                2: { fillColor: labelGray, fontStyle: 'bold', width: 45 } 
            }
        });

        let currentY = doc.lastAutoTable.finalY + 10;

        // 3. CONTACTS SECTION (Individual Record Grids)
        if (this.contacts && this.contacts.length > 0) {
            this.contacts.forEach((con, index) => {
                // Section Header Bar
                doc.autoTable({
                    startY: currentY,
                    theme: 'plain',
                    head: [[`CONTACT ${index + 1} DETAILS`]],
                    headStyles: { fillColor: primaryBlue, textColor: [255, 255, 255], halign: 'center' }
                });

                // Detail Grid (Label | Value | Label | Value)
                doc.autoTable({
                    startY: doc.lastAutoTable.finalY,
                    theme: 'grid',
                    body: [
                        ['First Name', con.FirstName || 'N/A', 'Last Name', con.LastName || 'N/A'],
                        ['Email', { content: con.Email || 'N/A', colSpan: 3 }]
                    ],
                    styles: { fontSize: 9, lineColor: black },
                    columnStyles: { 
                        0: { fillColor: labelGray, fontStyle: 'bold', width: 45 }, 
                        2: { fillColor: labelGray, fontStyle: 'bold', width: 45 } 
                    }
                });

                currentY = doc.lastAutoTable.finalY + 10;
                // Page overflow protection
                if (currentY > 260) { doc.addPage(); currentY = 20; }
            });
        }

        // 4. OPPORTUNITIES SECTION
        if (this.opps && this.opps.length > 0) {
            this.opps.forEach((opp, index) => {
                doc.autoTable({
                    startY: currentY,
                    theme: 'plain',
                    head: [[`OPPORTUNITY ${index + 1} DETAILS`]],
                    headStyles: { fillColor: primaryBlue, textColor: [255, 255, 255], halign: 'center' }
                });

                doc.autoTable({
                    startY: doc.lastAutoTable.finalY,
                    theme: 'grid',
                    body: [
                        ['Opp Name', opp.Name || 'N/A', 'Stage', opp.StageName || 'N/A'],
                        ['Amount', `$${opp.Amount || 0}`, 'Close Date', opp.CloseDate || 'N/A']
                    ],
                    styles: { fontSize: 9, lineColor: black },
                    columnStyles: { 
                        0: { fillColor: labelGray, fontStyle: 'bold', width: 45 }, 
                        2: { fillColor: labelGray, fontStyle: 'bold', width: 45 } 
                    }
                });

                currentY = doc.lastAutoTable.finalY + 10;
                if (currentY > 260) { doc.addPage(); currentY = 20; }
            });
        }

        // Final Save
        doc.save(`${this.accData.Name || 'Account'}_Report.pdf`);
        this.closeModal();

    } catch (error) {
        console.error('PDF Error:', error);
        alert('Could not generate PDF: ' + error.message);
    }
}
}