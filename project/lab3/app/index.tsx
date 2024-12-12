import React from 'react';
import { View, StyleSheet } from 'react-native';
import ImageComponent from './pages/ImageView';

const TestPage = () => {
    return (
        <View style={styles.container}>
            <ImageComponent
                orientation="portrait"
                smallSize="large"
                thumbnails="below"
                largeImage="yes"
            />
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
    },
});

export default TestPage;
