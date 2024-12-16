import React, { useState } from 'react';
import { View, StyleSheet } from 'react-native';
import ImageComponent from './pages/ImageView';
import AccordionMenu from './pages/AccordionMenu';
import { ImagesData } from '../assets/test/data/imgdb';

const TestPage = () => {
    const [selectedMenu, setSelectedMenu] = useState('Bilder 1');

    // Define the dynamic props based on the selected menu item
    const getImageProps = (menuItem: string) => {
        switch (menuItem) {
            case 'Bilder 1':
                return {
                    imagesData: ImagesData.slice(0, 5),  // Example: First 5 images
                    orientation: 'portrait' as 'portrait',  // Explicitly cast the value
                    smallSize: 'large' as 'small',  // Explicit cast
                    thumbnails: 'below' as 'below',  // Explicit cast
                    largeImage: 'yes' as 'yes',  // Explicit cast
                };
            case 'Bilder 2':
                return {
                    imagesData: ImagesData.slice(5),  // Example: Last 5 images
                    orientation: 'square' as 'square',  // Explicitly cast the value
                    smallSize: 'large' as 'large',  // Explicit cast
                    thumbnails: 'below' as 'below',  // Explicit cast
                    largeImage: 'yes' as 'yes',  // Explicit cast
                };
            default:
                return {
                    imagesData: ImagesData,
                    orientation: 'portrait' as 'portrait',  // Ensure this is one of the allowed values
                    smallSize: 'large' as 'large',  // Correct smallSize
                    thumbnails: 'below' as 'below',  // Correct thumbnails
                    largeImage: 'yes' as 'yes',  // Correct largeImage
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
