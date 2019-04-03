import React from 'react';
import { StyleSheet, View, Text, ImageBackground, TouchableOpacity } from 'react-native';
import { createBottomTabNavigator, createAppContainer } from 'react-navigation';

import chat from './chat'
import mural from './mural'
import achivement from './achivement'


class person extends React.Component{

  render() {
    return(
      <View style={{flex:1, backgroundColor:'rgb(45, 45, 45)'}}>
        <ImageBackground style={styles.picturePerson} source={{uri:'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'}}>
        </ImageBackground>
        <View style={{flex: 2}}>
          <Text style={{marginLeft:20, fontSize:32, color:'white'}}>Nome</Text>
          <View stlye={styles.directionText}>
            <Text style={styles.textDescription1}>Descriçãosoa</Text>
            <Text style={styles.textDescription2}>Cidade</Text>
            <Text style={styles.textDescription3}>UF</Text>
          </View>
        </View>
      </View>
    );
  }
}

const styles=StyleSheet.create({
  picturePerson:{
    flex: 3,
  },
  directionText:{
    flex: 3,
    flexDirection: 'row',
    alignItems: 'center',
  },
  textDescription1:{
    flex:1.3,
    color: 'white',
  },
  textDescription2:{
    flex:1.3,
    color: 'white',
  },
  textDescription3:{
    flex:0.6,
    color: 'white',
  }
});


const TabNavigator = createBottomTabNavigator({
    Perfil: person,
    Mural: mural,
    Chat: chat,
    Achivement: achivement,
  });

  export default createAppContainer(TabNavigator);