import React, { useState, useRef } from 'react';
import { View, Text, Image, ScrollView, TouchableOpacity, StyleSheet, Dimensions } from 'react-native';
import { ImagesData } from '../../assets/test/data/imgdb';

const { width, height } = Dimensions.get('window');

const ImageComponent = () => {
    const [scrollLeft1, setScrollLeft1] = useState(0);
    const [viewImage, setViewImage] = useState(ImagesData[0].img);
    const [viewImageAlt, setViewImageAlt] = useState(ImagesData[0].alt);

    const ref1 = useRef<ScrollView>(null);

    const handleScroll1 = (scrollOffset: number) => {
        if (ref1.current) {
            const newOffset = scrollLeft1 + scrollOffset;
            ref1.current.scrollTo({ x: newOffset, animated: true });
            setScrollLeft1(newOffset);
        }
    };

    return (
        <View style={styles.wrapper}>
            <TouchableOpacity style={styles.imageButton}> 
                <View style={styles.viewImageWrapper}>
                    <Image source={viewImage} style={styles.largeImage} />
                </View>
            </TouchableOpacity>

            <ScrollView
                horizontal
                ref={ref1}
                style={styles.total}
                showsHorizontalScrollIndicator={false}
                onScroll={(e) => setScrollLeft1(e.nativeEvent.contentOffset.x)}
                scrollEventThrottle={16}
            >
                {ImagesData.map((image) => (
                    <TouchableOpacity
                        key={image.key}
                        onPress={() => {
                            setViewImage(image.img); // Update view image
                            setViewImageAlt(image.alt); // Update alt text if needed
                        }}
                    >
                        <Image source={image.img} style={styles.styledIMG} />
                    </TouchableOpacity>
                ))}
            </ScrollView>
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
        height: height * 0.5,
        marginTop: -4,
        marginBottom: 2,
        borderRadius: 7,
        padding: 20,
    },
    total: {
        flexDirection: 'row',
        width: '100%',
        marginTop: 20,
    },
    styledIMG: {
        marginHorizontal: 10,
        borderRadius: 7,
        height: height * 0.1,
        width: height * 0.1,
        resizeMode: 'cover',
    },
    buttonWrapperLeft: {
        position: 'absolute',
        top: height * 0.4,
        left: 10,
        width: 40,
        height: 40,
        borderRadius: 20,
        backgroundColor: 'white',
        justifyContent: 'center',
        alignItems: 'center',
    },
    buttonWrapperRight: {
        position: 'absolute',
        top: height * 0.4,
        right: 10,
        width: 40,
        height: 40,
        borderRadius: 20,
        backgroundColor: 'white',
        justifyContent: 'center',
        alignItems: 'center',
    },
    arrowText: {
        fontSize: 20,
        color: 'black',
    },
    imageButton: {
        width: '100%',
        height: height * 0.5,
    },
});

export default ImageComponent;
