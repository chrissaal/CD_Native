import { createStackNavigator} from '@react-navigation/stack';
import { NavigationContainer, NavigationContainerRef } from '@react-navigation/native';
import HomeScreen from './HomeScreen';
import React from 'react';
import WebViewScreen from './WebViewScreen'


const Stack = createStackNavigator();
const AppNavigator= () => { 
    return (
        <NavigationContainer>
            <Stack.Navigator>
                <Stack.Screen name = 'HomeScreen' component = {HomeScreen}/>
                <Stack.Screen name = 'OptionsScreen' component = {OptionsScreen}/>
                {/* <Stack.Screen name = 'WebViewScreen' component = {WebViewScreen}/> */}
            </Stack.Navigator>
        </NavigationContainer>
    )
}

export default AppNavigator;