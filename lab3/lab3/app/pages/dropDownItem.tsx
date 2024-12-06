import React, { useState } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { Dropdown } from 'react-native-element-dropdown';

const data = [
    { label: "C++", value: "language:C++ sort:stars" },
    { label: "JavaScript", value: "language:JavaScript sort:stars" },
    { label: "Python", value: "language:Python sort:stars" },
    { label: "Java", value: "language:Java sort:stars" },
    { label: "Go", value: "language:Go sort:stars" },
    { label: "Ruby", value: "language:Ruby sort:stars" },
    { label: "TypeScript", value: "language:TypeScript sort:stars" },
    { label: "C#", value: "language:C# sort:stars" },
    { label: "PHP", value: "language:PHP sort:stars" },
    { label: "Swift", value: "language:Swift sort:stars" },
    { label: "Kotlin", value: "language:Kotlin sort:stars" },
    { label: "Rust", value: "language:Rust sort:stars" },
    { label: "Dart", value: "language:Dart sort:stars" },
    { label: "Shell", value: "language:Shell sort:stars" },
    { label: "Objective-C", value: "language:Objective-C sort:stars" },
    { label: "Vue", value: "language:Vue sort:stars" },
    { label: "CSS", value: "language:CSS sort:stars" },
    { label: "HTML", value: "language:HTML sort:stars" },
    { label: "R", value: "language:R sort:stars" },
    { label: "Scala", value: "language:Scala sort:stars" },
    { label: "Perl", value: "language:Perl sort:stars" },
    { label: "Lua", value: "language:Lua sort:stars" },
    { label: "Assembly", value: "language:Assembly sort:stars" },
    { label: "PowerShell", value: "language:PowerShell sort:stars" },
    { label: "Elixir", value: "language:Elixir sort:stars" },
    { label: "Clojure", value: "language:Clojure sort:stars" },
    { label: "Haskell", value: "language:Haskell sort:stars" },
    { label: "Groovy", value: "language:Groovy sort:stars" },
];

const DropdownComponentItem = ({ onValueChange }: { onValueChange: (value: string) => void }) => {
    const [value, setValue] = useState<string>('');
    const [isFocus, setIsFocus] = useState(false);

    const handleValueChange = (item: { label: string; value: string }) => {
        setValue(item.value);
        onValueChange(item.value);
    };

    const renderLabel = () => {
        if (value || isFocus) {
            return (
                <Text style={[styles.label, isFocus && { color: 'blue' }]}>
                    Dropdown label
                </Text>
            );
        }
        return null;
    };

    return (
        <View style={styles.container}>
            {renderLabel()}
            <Dropdown
                style={[styles.dropdown, isFocus && { borderColor: 'black' }]}
                placeholderStyle={styles.placeholderStyle}
                selectedTextStyle={styles.selectedTextStyle}
                inputSearchStyle={styles.inputSearchStyle}
                iconStyle={styles.iconStyle}
                data={data}
                search
                maxHeight={300}
                labelField="label"
                valueField="value"
                placeholder={!isFocus ? 'Select language' : '...'}
                searchPlaceholder="Search..."
                value={value}
                onFocus={() => setIsFocus(false)}
                onBlur={() => setIsFocus(false)}
                onChange={handleValueChange}
            />
        </View>
    );
};

export default DropdownComponentItem;

const styles = StyleSheet.create({
    container: {
        backgroundColor: 'white',
        padding: 16,
    },
    dropdown: {
        height: 50,
        borderColor: 'black',
        borderWidth: 0.5,
        borderRadius: 8,
        paddingHorizontal: 8,
    },
    icon: {
        marginRight: 5,
    },
    label: {
        position: 'absolute',
        backgroundColor: 'white',
        left: 22,
        top: 8,
        zIndex: 999,
        paddingHorizontal: 8,
        fontSize: 14,
    },
    placeholderStyle: {
        fontSize: 16,
    },
    selectedTextStyle: {
        fontSize: 16,
    },
    iconStyle: {
        width: 20,
        height: 20,
    },
    inputSearchStyle: {
        height: 40,
        fontSize: 16,
    },
});