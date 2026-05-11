import { LightningElement } from 'lwc';
import sendOTP from '@salesforce/apex/registerUser.sendOTP';
import registerAfterOTP from '@salesforce/apex/registerUser.registerAfterOTP';
import { NavigationMixin } from 'lightning/navigation';

export default class RegisterPage extends NavigationMixin(LightningElement) {
    name;
    email;
    password;
    userOtp;
    displayedOtp; 
    showOtp = false;
    timeLeft = 0;
    otpTimer;

    handleName(e) { this.name = e.target.value; }
    handleEmail(e) { this.email = e.target.value; }
    handlePassword(e) { this.password = e.target.value; }
    handleOtp(e) { this.userOtp = e.target.value; }

    async handleSendOtp() {
        if (!this.name || !this.email || !this.password) {
            alert('Please fill all fields');
            return;
        }

        try {
            
            this.displayedOtp = await sendOTP({ 
                name: this.name, 
                email: this.email 
            });

            this.showOtp = true;
            this.startOtpTimer();
            alert('OTP Generated successfully');
        } catch (error) {

            this.showOtp = false;
            console.error(error);
            alert(error.body.message);
        }
    }

    async register() {
        try {
            if (!this.validatePassword()) return;

            const userId = await registerAfterOTP({
                name: this.name,
                email: this.email,
                password: this.password,
                userEnteredOtp: this.userOtp
            });
            
             if (userId) {
                clearInterval(this.otpTimer);
                this.otpTimer = null;
                this.showOtp = false;
                alert('Registration successful');
                this[NavigationMixin.Navigate]({
                    type: 'comm__namedPage',
                    attributes: {
                        name: 'Home'   
                    }
                });
}
        } catch (error) {

        console.error(error);

        let message = 'went wrong';
            if (error?.body?.message) {
                message = error.body.message;
            } 
            else if (error?.message) {
                message = error.message;
            }
            if (
                message.includes('Script-thrown exception') || message.includes('portal user already exists')
            ) {
                message = 'User already exists';
            }
            this.showOtp = false;
            alert(message);
    }
    }

    validatePassword() {
        const regex = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[\W]).{8,}$/;
        return regex.test(this.password);
    }
    startOtpTimer() {

    if (this.otpTimer) {
        clearInterval(this.otpTimer);
    }

    this.timeLeft = 60;

    this.otpTimer = setInterval(() => {
        this.timeLeft--;

        if (this.timeLeft <= 0) {
            clearInterval(this.otpTimer);
            this.otpTimer = null;

            this.showOtp = false;
            this.userOtp = null;

            alert('OTP expired. Please resend OTP.');
        }
    }, 1000);

}
   
}