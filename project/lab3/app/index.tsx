import React from 'react';
import { View, StyleSheet } from 'react-native';
import ImageComponent from './pages/ImageView';

const TestPage = () => {
    return (
        <View style={styles.container}>
            <ImageComponent
                orientation="portrait" // landscape, portrait, square
                smallSize="large" // small, medium, large 
                thumbnails="below" // above, below
                largeImage="yes" // no, yes
                typeLargeImage="rounded" // circle, square, rounded
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
