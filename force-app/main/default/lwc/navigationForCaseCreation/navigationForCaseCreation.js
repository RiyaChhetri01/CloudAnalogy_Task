import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import basePath from '@salesforce/community/basePath';

export default class PortalNavbar extends NavigationMixin(LightningElement) {

    isMenuOpen = false;

    toggleMenu() {
        this.isMenuOpen = !this.isMenuOpen;
        console.log('Menu Open:', this.isMenuOpen); // debug
    }

    navigate(path) {
        const fullUrl = basePath + path;

        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: fullUrl
            }
        });

        this.isMenuOpen = false;
    }

    goHome() {
        this.navigate('/');
    }

    goAssets() {
        this.navigate('/my-assets');
    }

    goCases() {
        this.navigate('/my-cases');
    }

    goFaq() {
        this.navigate('/faq');
    }
}