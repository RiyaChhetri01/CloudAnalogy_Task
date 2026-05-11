import { LightningElement, track } from 'lwc';
import loginUser from '@salesforce/apex/LoginController.loginUser';
import basePath from '@salesforce/community/basePath'; 
import { NavigationMixin } from 'lightning/navigation';

export default class PortalLogin extends NavigationMixin(LightningElement) {
    username = '';
    password = '';
    @track errorMessage = '';

    handleInputChange(event) {
        const field = event.target.dataset.id;
        if (field === 'username') this.username = event.target.value;
        if (field === 'password') this.password = event.target.value;
    }

    handleLogin() {
        this.errorMessage = '';

        if (!this.username || !this.password) {
            this.errorMessage = 'Please enter both username and password.';
            return;
        }

        loginUser({ 
            username: this.username, 
            password: this.password, 
            startUrl: '/' 
        })
        .then((result) => {

        window.location.href = result;

    })
            .catch((error) => {
           
            this.errorMessage = error.body.message;
            console.error('Login Error:', error);
        });
    }
    goToRegister() {
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Register'  
            }
        });
    }
    handleForgotPassword() {
    
     window.location.href = basePath + '/forgotpassword';}
}