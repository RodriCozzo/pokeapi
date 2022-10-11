import { LightningElement, api } from 'lwc';
import { NavigationMixin  } from 'lightning/navigation';


export default class PokemonsTile extends NavigationMixin(LightningElement) { 
    @api pokemon;   
                            
    
    get titulo(){
        return `${this.pokemon.Name} N° ${this.pokemon.ExtId__c}`;
    }


    navigateToRecordViewPage(){
        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
                recordId: this.pokemon.Id,
                objectApiName: 'Pokemons__c',
                actionName: 'view'
            }
        });
    }

       
}
