import React, { useState, useEffect } from 'react';
import { View, Image, ScrollView, TouchableOpacity, StyleSheet, Dimensions } from 'react-native';

const { width } = Dimensions.get('window');  // Screen width to dynamically size images.

interface ImageComponentProps { // Define the props for the ImageComponent.
    imagesData: { img: any; alt: string; key: string }[];
    orientation?: 'landscape' | 'portrait' | 'square';
    smallSize?: 'small' | 'medium' | 'large';
    thumbnails?: 'above' | 'below';
    largeImage?: 'no' | 'yes'; 
    typeLargeImage?: 'circle' | 'square' | 'rounded';
}

const ImageComponent: React.FC<ImageComponentProps> = ({ 
    imagesData,
    orientation = 'portrait',
    smallSize = 'medium',
    thumbnails = 'below',
    largeImage = 'no',
    typeLargeImage = 'square',
}) => {
    const [viewImage, setViewImage] = useState(imagesData[0].img);  // Initialize state for main imagee

    useEffect(() => {
        setViewImage(imagesData[0].img);  // Update the main image if the `imagesData` prop changes
    }, [imagesData]);

    const aspectRatios: Record<string, number> = { landscape: 0.4, portrait: 0.8, square: 1 }; // Formats for large image

    const sizeStyles: Record<string, number> = { small: 50, medium: 100, large: 150 }; // Sizes for small images
    // Define size mappings for thumbnail images.

    const stylesLargeImage: Record<string, number> = { // Border radius for images
        circle: 100, 
        square: 0,    
        rounded: 10,
    };

    const aspectRatio = aspectRatios[orientation]; // Select based on orientation prop

    const smallSizeStyle = sizeStyles[smallSize]; // Select based on smallSize prop

    // Render small images
    const renderThumbnails = () => (
        <ScrollView horizontal style={styles.total} showsHorizontalScrollIndicator={false}>
            {imagesData.map((image) => (
                <TouchableOpacity key={image.key} onPress={() => setViewImage(image.img)}>
                    <Image
                        source={image.img}
                        style={{
                            height: smallSizeStyle,
                            width: smallSizeStyle,
                            borderRadius: stylesLargeImage[typeLargeImage], 
                            ...styles.styledIMG,
                        }}
                    />
                </TouchableOpacity>
            ))}
        </ScrollView>
    );

    // Render main image
    const renderMainImage = () => (
        <View style={styles.viewImageWrapper}>
            <Image
                source={viewImage}
                style={{
                    height: width * aspectRatio,
                    borderRadius: stylesLargeImage[typeLargeImage], 
                    ...styles.largeImage,
                }}
            />
        </View>
    );

    if (largeImage === 'no') { // If the `largeImage` prop is 'no', only render thumbnails.
        return <View style={styles.wrapper}>{renderThumbnails()}</View>;
    }

    return ( // Otherwise, render both the main image and thumbnails.
        <View style={styles.wrapper}>
            {thumbnails === 'above' && renderThumbnails()}
            {renderMainImage()}
            {thumbnails === 'below' && renderThumbnails()}
        </View>
    );
};

const styles = StyleSheet.create({
    wrapper: {
        width: width,
        position: 'relative',
        paddingBottom: 30,
        marginTop: 20,
    },
    viewImageWrapper: {
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: '5%',
        width: '100%',
    },
    largeImage: {
        width: '100%',
        marginTop: -4,
        marginBottom: 2,
        padding: 20,
    },
    total: {
        flexDirection: 'row',
        width: '100%',
        marginTop: 50,
        marginBottom: 50,
    },
    styledIMG: {
        marginHorizontal: 10,
        resizeMode: 'cover',
    },
});

export default ImageComponent;
