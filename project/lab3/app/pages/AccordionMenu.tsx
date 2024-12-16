import React, { useState } from 'react';
import { View, Text, TouchableOpacity, Animated, StyleSheet, TouchableWithoutFeedback } from 'react-native';

interface AccordionMenuProps { // Define the props for the AccordionMenu.
    children?: React.ReactNode;
    menuItems?: string[];
    onSelect: (item: string) => void;
}

const AccordionMenu: React.FC<AccordionMenuProps> = ({ children, menuItems = [], onSelect }) => {

    const [isMenuVisible, setIsMenuVisible] = useState(false); // Menu visibility state
    const slideAnim = React.useRef(new Animated.Value(-250)).current; // Animation state

    const toggleMenu = () => {
        if (isMenuVisible) { // If the menu is visible, slide it out of view
            Animated.timing(slideAnim, {
                toValue: -250,
                duration: 300,
                useNativeDriver: true,
            }).start(() => setIsMenuVisible(false));
        } else { // If the menu is not visible, slide it into view
            setIsMenuVisible(true);
            Animated.timing(slideAnim, {
                toValue: 0,
                duration: 300,
                useNativeDriver: true,
            }).start();
        }
    };

    return (
        <View style={{ flex: 1 }}>
        
            <View style={{ flex: 1 }}>{children}</View>

            <TouchableOpacity onPress={toggleMenu} style={styles.hamburgerButton}>
                <Text style={styles.hamburgerIcon}>☰</Text>
            </TouchableOpacity>

            {isMenuVisible && ( // If the menu is visible, render the overlay
                <TouchableWithoutFeedback onPress={toggleMenu}>
                    <View style={styles.overlay} />
                </TouchableWithoutFeedback>
            )}

            <Animated.View style={[styles.menuContainer, { transform: [{ translateX: slideAnim }] }]}>
                {menuItems.map((item, index) => (
                    <TouchableOpacity key={index} style={styles.menuItem} onPress={() => onSelect(item)}>
                        <Text style={styles.menuText}>{item}</Text>
                    </TouchableOpacity>
                ))}
            </Animated.View>
        </View>
    );
};

const styles = StyleSheet.create({
    hamburgerButton: {
        position: 'absolute',
        top: 10,
        left: 10,
        zIndex: 10,
        padding: 10,
    },
    hamburgerIcon: {
        fontSize: 32,
    },
    overlay: {
        position: 'absolute',
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        backgroundColor: 'rgba(0, 0, 0, 0.5)', 
        zIndex: 15,
    },
    menuContainer: {
        position: 'absolute',
        top: 0,
        left: 0,
        width: 250,
        height: '100%',
        backgroundColor: '#333',
        padding: 20,
        zIndex: 20, 
    },
    menuItem: {
        paddingVertical: 15,
        borderBottomWidth: 1,
        borderBottomColor: '#444',
    },
    menuText: {
        color: '#fff',
        fontSize: 18,
    },
});

export default AccordionMenu;
