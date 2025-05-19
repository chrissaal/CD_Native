import React, { useEffect } from 'react';
import { View, UIManager, Button, StyleSheet, Alert, findNodeHandle, requireNativeComponent } from 'react-native';

const OptionsScreen = ({ route, navigation }) => {
  const { token } = route.params;
  const ref = React.useRef(null);
  const CampusDigitalView = requireNativeComponent('CampusDigitalView');

  useEffect(() => {
    callFunctionOnEnter();
    }, []);

    const callFunctionOnEnter = () => {
        const viewId = findNodeHandle(ref.current);
        if (viewId === null) {
            console.log("No hay viewId");
            return
          }

        UIManager.dispatchViewManagerCommand(
            viewId,
            UIManager.getViewManagerConfig('CampusDigitalView').Commands.initServicesSDK,
            [token],
        );
    };

  const showBanner = (viewId) => {
    if (viewId === null) {
        console.log("No hay viewId");
        return
      }

      UIManager.dispatchViewManagerCommand(
        viewId,
        UIManager.getViewManagerConfig('CampusDigitalView').Commands.showBannerIos,
        [token],
      );
      
  };

  const showMenu = (viewId) => {
    if (viewId === null) {
        return
      }
      UIManager.dispatchViewManagerCommand(
        viewId,
        UIManager.getViewManagerConfig('CampusDigitalView').Commands.showMenuIos,
        [],
      );
  };

  return (
    <View style={styles.container}>
      <CampusDigitalView style={{ flex: 1 }} ref={ref} />
      <Button title="Mostrar Banner" onPress={() => showBanner(findNodeHandle(ref.current))} />
      <Button title="Mostrar Menu" onPress={() => showMenu(findNodeHandle(ref.current))} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    paddingBottom: 16,
  },
});

export default OptionsScreen;