import { LightningElement } from 'lwc';
import WeatherApp from '@salesforce/apex/WeatherApiWork.WeatherApp';
export default class WeatherApi extends LightningElement {
    city='';
    handleChange(event){
        this.city=event.target.value;
    }
    handleGetWeather(){
        WeatherApp({city:this.city})
        .then(result=>{
            this.weatherData = result;
        }).catch(error=>{
            this.error = error;
        });


    }
}