import React, { useState } from 'react';
import { View, UIManager, TextInput, Button, StyleSheet, Alert, findNodeHandle, requireNativeComponent } from 'react-native';


const HomeScreen = ({ navigation }) => {
  const [token, setToken] = useState('');

  const handleStart = (viewId) => {
    if (!token.trim()) {
      Alert.alert('Error', 'Por favor, ingresa un token válido.');
      return;
    }
    
    navigation.navigate('Options', { token });
  };

  const ref = React.useRef(null);

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.input}
        placeholder="Ingresa algo"
        value={token}
        onChangeText={setToken}
      />
      <Button title="Iniciar" onPress={() => handleStart(findNodeHandle(ref.current))} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    padding: 16,
  },
  input: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    marginBottom: 12,
    paddingHorizontal: 8,
  },
});

export default HomeScreen;