import React from 'react';
import { StyleSheet, View, Text, ImageBackground, TouchableOpacity } from 'react-native';

class tutorial extends React.Component{

    constructor(props){
        super(props);
        this.state={
            data:[]
        }
    }

    componentDidMount(){
      fetch('https://apigetrest.herokuapp.com/hotel/1/?format=json')
      .then((response) => response.json())
      .then((responseJson) => {
        this.setState({
          data: responseJson,
        })
      })
      .catch((error) => {
        alert(error);
      });

    }

    render(){
        return(
            <View>
                <ImageBackground source={{uri : this.state.data.maps_image}} style={{width:'100%', height:'100%'}}>
                    <View style={{backgroundColor:'rgba(0,0,0,0.5)', flex: 1}}>
                        <View style={{flex: 3, alignItems:'center', justifyContent: 'center'}}>
                            <Text style={styles.textHowWork}>Como funciona?</Text>
                            <Text style={styles.textExplain}>Nós utilizamos a localização do seu dispositivo para conectá-lo com os hóspedes do {this.state.data.nome}</Text>
                        </View>
                        <View style={{flex:1}}>

                        </View>
                        <View style={{flex: 3, alignItems:'center', justifyContent: 'center'}}>
                            <Text style={styles.textExplainInternet}>Além disso, você precisa de acesso à internet para participar da comunidade</Text>
                            <TouchableOpacity style={styles.letsStart}>
                                <Text style={styles.letsStartText}>TUDO CERTO. VAMOR COMEÇAR!</Text>
                            </TouchableOpacity>
                        </View>
                    </View>
                </ImageBackground>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    textHowWork:{
        fontSize:32,
        color: 'white'
    },
    textExplain:{
        fontSize:16,
        color: 'white',
        width: 360,
    },
    textExplainInternet:{
        fontSize:16,
        color: 'white',
        width: 330,
    },
    letsStart:{
        justifyContent: 'center',
        alignItems: 'center',
        marginTop:20,
        height:70,
        width:330,
        borderRadius: 90,
        backgroundColor: 'rgb(255, 234, 117)',
    },
    letsStartText:{
        color:'black',
        fontSize:17,
        fontWeight: 'bold',
    }
});

export default tutorial;