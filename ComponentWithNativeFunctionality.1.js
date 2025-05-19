import { UIManager, findNodeHandle } from 'react-native';

class ComponentWithNativeFunctionality extends React.Component {
    const myRef = React.createRef();

    functionToCall = () => {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this.myRef.current),
            "nameOfFunctionToCallInNativeLand",
            [ /* additional arguments */]
        );
    };

    render() {
        return <NativeComponentView ref={this.myRef} />;
    }
}
