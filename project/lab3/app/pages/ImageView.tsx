import React, { useState } from 'react';
import { View, Image, ScrollView, TouchableOpacity, StyleSheet, Dimensions } from 'react-native';
import { ImagesData } from '../../assets/test/data/imgdb';

const { width } = Dimensions.get('window');

interface ImageComponentProps {
    orientation?: 'landscape' | 'portrait' | 'square';
    smallSize?: 'small' | 'medium' | 'large';
    thumbnails?: 'above' | 'below';
    largeImage?: 'no' | 'yes'; 
    typeLargeImage?: 'circle' | 'square' | 'rounded';
}

const ImageComponent: React.FC<ImageComponentProps> = ({
    orientation = 'portrait',
    smallSize = 'medium',
    thumbnails = 'below',
    largeImage = 'no',
    typeLargeImage = 'square',
}) => {
    const [viewImage, setViewImage] = useState(ImagesData[0].img);

    const aspectRatios: Record<string, number> = { landscape: 0.4, portrait: 0.8, square: 1 };
    const sizeStyles: Record<string, number> = { small: 50, medium: 100, large: 150 };

    const stylesLargeImage: Record<string, number> = { 
        circle: 100,  
        square: 0,    
        rounded: 10,  
    };

    const aspectRatio = aspectRatios[orientation];
    const smallSizeStyle = sizeStyles[smallSize];

    const renderThumbnails = () => (
        <ScrollView horizontal style={styles.total} showsHorizontalScrollIndicator={false}>
            {ImagesData.map((image) => (
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

    if (largeImage === 'no') {
        return <View style={styles.wrapper}>{renderThumbnails()}</View>;
    }

    return (
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
