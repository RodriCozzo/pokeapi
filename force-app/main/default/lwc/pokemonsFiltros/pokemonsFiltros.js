import { LightningElement, wire, track } from "lwc";
import GetPokemonsFilter from "@salesforce/apex/PokeController.getPokemonsFilter";
import GetPokemonsList from "@salesforce/apex/PokeController.getPokemonsList";
import GetPokemonsGen from "@salesforce/apex/PokeController.getPokemonsGen";


export default class PokemonsFiltros extends LightningElement {
    // searchText = "";
    // value; 

    // @track data = [];
    
    // @wire(GetPokemonsFilter, { searchText: "$searchText" })
    // pokemons;

    // handleInputChange( event ){
    //     const searchTextAux = event.target.value;
    //      console.log("Texto recibido : " + searchTextAux);
    //     if (searchTextAux.length >= 3 || searchTextAux === ""){
    //     this.searchText = searchTextAux;
    //     }
    // }

    // // @wire(getPokemonsGen, { searchGen: '$searchGen' }) searchGen;    
    
    
    
            
    // connectedCallback(){
    //     GetPokemonsList().then(data =>{
    //         this.data = data;
    //     }).catch(error => {
    //         console.log('error');
    //     })
    // }
    // //EVENTO GENERACION
    // handleChangeGen(event) {
    //     this.generacion = event.detail.value;
    //     console.log('this.value:' + this.generacion);

    //     GetPokemonsGen({searchGen : this.generacion, searchTipo : this.tipo }).then(data => {
    //         this.data = data;
    //         console.log('this.data:' + JSON.stringify(this.data));
    //     }).catch(error => {
    //         console.log('error');
    //     })
        
    // }


    // handleChangeTipo(event) {

    //     this.tipo = event.detail.value;
    //     console.log('this.tipo:' + this.tipo);
    
     
    //     GetPokemonsGen({searchGen : this.generacion, searchTipo : this.tipo }).then(data => {
    //         this.data = data;
    //         console.log('this.data:' + JSON.stringify(this.data));
    //     }).catch(error => {
    //         console.log('error');
    //     })
        
    // }
    
    // get options() {
    //     return [
    //         { label: 'Generación 1', value: '1' },
    //         { label: 'Generación 2', value: '2' },
    //         { label: 'Generación 3', value: '3' },
    //         { label: 'Generación 4', value: '4' },
    //         { label: 'Generación 5', value: '5' },
    //         { label: 'Generación 6', value: '6' },
    //         { label: 'Generación 7', value: '7' },
    //         { label: 'Generación 8', value: '8' },
    //     ];
    // }
    // get optionsTipos() {
    //     return [
    //         { label: 'Normal', value: 'Normal' },
    //         { label: 'Lucha', value: 'Fighting' },
    //         { label: 'Flying', value: 'Flying' },
    //         { label: 'Poison', value: 'Poison' },
    //         { label: 'Ground', value: 'Ground' },
    //         { label: 'Rock', value: 'Rock' },
    //         { label: 'Bug', value: 'Bug' },
    //         { label: 'Ghost', value: 'Ghost' },
    //         { label: 'Steel', value: 'Steel' },
    //         { label: 'Fire', value: 'Fire' },
    //         { label: 'Water', value: 'Water' },
    //         { label: 'Grass', value: 'Grass' },
    //         { label: 'Electric', value: 'Electric' },
    //         { label: 'Psychic', value: 'Psychic' },
    //         { label: 'Ice', value: 'Ice' },
    //         { label: 'Dragon', value: 'Dragon' },
    //         { label: 'Dark', value: 'Dark' },
    //         { label: 'Fairy', value: 'Fairy' },
    //     ];
    // }
}

