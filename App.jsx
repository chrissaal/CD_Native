// In App.js in a new project
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import * as React from 'react';
import HomeScreen from './HomeScreen';
import OptionsScreen from './CampusDigitalServicesDemo';

const Stack = createNativeStackNavigator();

const App = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Options" component={OptionsScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default App;
