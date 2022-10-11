import { LightningElement, track, wire } from 'lwc';

import GetPokemonsList from "@salesforce/apex/PokeController.getPokemonsList";
import GetPokemonsGen from "@salesforce/apex/PokeController.getPokemonsGen";


export default class PokemonsList extends LightningElement {
    @track pokemons;
    
    name = "";
    generacion = "";
    tipo ="";
    

    @track data = [];
    
    //Reemplaza al Wire
    connectedCallback(){
        GetPokemonsList().then(data =>{
            this.data = data;
        }).catch(error => {
            console.log('error');
        })
    }
    
    //Evento de búsqueda por nombre
    handleInputChange( event ){
        this.name = event.target.value;
        console.log("Texto recibido : " + this.name);
        
        this.taerPokemons();
    }
    
    
    //EVENTO GENERACION
    handleChangeGen(event) {
        this.generacion = event.detail.value;
        console.log('this.value:' + this.generacion);

        this.taerPokemons();        
    }


    handleChangeTipo(event) {

        this.tipo = event.detail.value;
        console.log('this.tipo:' + this.tipo);
    
        this.taerPokemons(); 
    }
    
    taerPokemons(){
        GetPokemonsGen({ searchText : this.name, searchGen : this.generacion, searchTipo : this.tipo}).then(data => {
            this.data = data;
            console.log('this.data:' + JSON.stringify(this.data));
            }).catch(error => {
                console.log('error');
            })
    }
    get options() {
        return [
            { label: 'Generación 1', value: '1' },
            { label: 'Generación 2', value: '2' },
            { label: 'Generación 3', value: '3' },
            { label: 'Generación 4', value: '4' },
            { label: 'Generación 5', value: '5' },
            { label: 'Generación 6', value: '6' },
            { label: 'Generación 7', value: '7' },
            { label: 'Generación 8', value: '8' },
        ];
    }
    get optionsTipos() {
        return [
            { label: 'Normal', value: 'Normal' },
            { label: 'Lucha', value: 'Fighting' },
            { label: 'Volador', value: 'Flying' },
            { label: 'Veneno', value: 'Poison' },
            { label: 'Tierra', value: 'Ground' },
            { label: 'Roca', value: 'Rock' },
            { label: 'Bicho', value: 'Bug' },
            { label: 'Fantasma', value: 'Ghost' },
            { label: 'Acero', value: 'Steel' },
            { label: 'Fuego', value: 'Fire' },
            { label: 'Agua', value: 'Water' },
            { label: 'Hierba', value: 'Grass' },
            { label: 'Eléctrico', value: 'Electric' },
            { label: 'Psíquico', value: 'Psychic' },
            { label: 'Hielo', value: 'Ice' },
            { label: 'Dragon', value: 'Dragon' },
            { label: 'Oscuro', value: 'Dark' },
            { label: 'Hada', value: 'Fairy' },
        ];
    }    
}