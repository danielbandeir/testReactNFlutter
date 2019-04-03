import React from 'react';
import {StyleSheet, Text, View, ImageBackground, TextInput, TouchableOpacity} from 'react-native';
import { createStackNavigator, createAppContainer, navigationOptions } from "react-navigation";
import tutorial from './src/components/tutorial'


class App extends React.Component {

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

  render() {
    return (
      <View>
        <ImageBackground source={{uri : this.state.data.background_image}} style={{width:'100%', height:'100%'}}>
          <View style={{backgroundColor:'rgba(0,0,0,0.5)', flex: 1}}>
            <View style={styles.initText}>
              <Text style={styles.hotelName}>{this.state.data.nome}</Text>
              <Text style={styles.description}>{this.state.data.description}</Text>
            </View>

            <View style={styles.loginInput}>
              <TextInput
                  style={styles.textLogin}
                  placeholder={'E-mail'}
                  underlineColorAndroid='white'
                  placeholderTextColor='white'/>
              <TextInput
                  style={styles.textLogin}
                  secureTextEntry={true}
                  placeholder={'Senha'}
                  underlineColorAndroid='white'
                  placeholderTextColor='white'/>
              <TouchableOpacity style={styles.loginButton} onPress={() => {this.props.navigation.navigate('Tutorial');}}>
                <Text style={styles.textEntrance}>Entrar</Text>
              </TouchableOpacity>
              <TouchableOpacity style={styles.loginButtonFacebook}>
                <Text style={styles.textEntranceFacebook}>ENTRAR COM FACEBOOK</Text>
              </TouchableOpacity>
            </View>
          </View>
        </ImageBackground>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  hotelName:{
    fontSize:70,
    letterSpacing:20,
    color: 'white',
  },
  initText:{
    alignItems:'center',
    marginTop:100,
  },
  description:{
    fontSize:15,
    color: 'white',
  },
  loginInput:{
    alignItems:'center',
    marginTop: 200,
  },
  textLogin:{
    width: 250,
  },
  loginButton:{
    justifyContent: 'center',
    alignItems: 'center',
    marginTop:20,
    height:50,
    width:300,
    borderRadius: 90,
    backgroundColor: 'white',
  },
  textEntrance:{
    color: 'black',
    letterSpacing: 5,
    fontSize: 19,
    fontWeight: 'bold',
  },  
  loginButtonFacebook:{
    justifyContent: 'center',
    alignItems: 'center',
    marginTop:20,
    height:50,
    width:300,
    borderRadius: 90,
    backgroundColor: 'rgb(60, 94, 150)',
  },
  textEntranceFacebook:{
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  }  
});


const AppNavigator = createStackNavigator({
  Home: {
    screen: App,
    navigationOptions: ()=>({
      header: null,
    }),
  },
  Tutorial: {
    screen: tutorial,
    navigationOptions: ()=>({
      header: null,
    }),
  },
    initialRouteName: "Home"
  }
);

export default createAppContainer(AppNavigator);