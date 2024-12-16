import React, { useState } from 'react';
import { View, Text, TouchableOpacity, Animated, StyleSheet, TouchableWithoutFeedback } from 'react-native';

interface AccordionMenuProps {
    children?: React.ReactNode;
    menuItems?: string[];
    onSelect: (item: string) => void;
}

const AccordionMenu: React.FC<AccordionMenuProps> = ({ children, menuItems = [], onSelect }) => {
    const [isMenuVisible, setIsMenuVisible] = useState(false);
    const slideAnim = React.useRef(new Animated.Value(-250)).current; // Menu slides in from the left

    const toggleMenu = () => {
        if (isMenuVisible) {
            Animated.timing(slideAnim, {
                toValue: -250,
                duration: 300,
                useNativeDriver: true,
            }).start(() => setIsMenuVisible(false));
        } else {
            setIsMenuVisible(true);
            Animated.timing(slideAnim, {
                toValue: 0,
                duration: 300,
                useNativeDriver: true,
            }).start();
        }
    };

    const closeMenu = () => {
        if (isMenuVisible) {
            Animated.timing(slideAnim, {
                toValue: -250,
                duration: 300,
                useNativeDriver: true,
            }).start(() => setIsMenuVisible(false));
        }
    };

    return (
        <View style={{ flex: 1 }}>
            {/* Main Content */}
            <View style={{ flex: 1 }}>{children}</View>

            {/* Hamburger Button */}
            <TouchableOpacity onPress={toggleMenu} style={styles.hamburgerButton}>
                <Text style={styles.hamburgerIcon}>☰</Text>
            </TouchableOpacity>

            {/* Transparent Overlay */}
            {isMenuVisible && (
                <TouchableWithoutFeedback onPress={closeMenu}>
                    <View style={styles.overlay} />
                </TouchableWithoutFeedback>
            )}

            {/* Animated Sliding Menu */}
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
        backgroundColor: 'rgba(0, 0, 0, 0.5)', // Slightly transparent background
        zIndex: 15, // Higher than main content, lower than menu
    },
    menuContainer: {
        position: 'absolute',
        top: 0,
        left: 0,
        width: 250,
        height: '100%',
        backgroundColor: '#333',
        padding: 20,
        zIndex: 20, // Ensures the menu is above the overlay
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
