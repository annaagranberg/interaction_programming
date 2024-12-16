import React, { useState } from 'react';
import { View, StyleSheet } from 'react-native';
import ImageComponent from './pages/ImageView';
import AccordionMenu from './pages/AccordionMenu';
import { ImagesData } from '../assets/test/data/imgdb';

const TestPage = () => {
    const [selectedMenu, setSelectedMenu] = useState('Bilder 1');

    const getImageProps = (menuItem: string) => {
        switch (menuItem) {
            case 'Bilder 1':
                return {
                    imagesData: ImagesData.slice(0, 5), 
                    orientation: 'portrait' as 'portrait', 
                    smallSize: 'medium' as 'medium', 
                    thumbnails: 'above' as 'above', 
                    largeImage: 'yes' as 'yes', 
                    typeLargeImage: 'rounded' as 'rounded',  
                };
            case 'Bilder 2':
                return {
                    imagesData: ImagesData.slice(5), 
                    orientation: 'square' as 'square',  
                    smallSize: 'large' as 'large', 
                    thumbnails: 'below' as 'below', 
                    largeImage: 'yes' as 'yes', 
                    typeLargeImage: 'square' as 'square',
                };
            default:
                return {
                    imagesData: ImagesData,
                    orientation: 'portrait' as 'portrait',
                    smallSize: 'large' as 'large',  
                    thumbnails: 'below' as 'below',  
                    largeImage: 'yes' as 'yes',  
                };
        }
    };

    return (
        <View style={styles.container}>
            <AccordionMenu
                menuItems={['Bilder 1', 'Bilder 2']}
                onSelect={setSelectedMenu}
            >
                <ImageComponent {...getImageProps(selectedMenu)} />
            </AccordionMenu>
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
