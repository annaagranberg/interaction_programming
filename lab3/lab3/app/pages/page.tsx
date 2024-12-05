import React from 'react';
import { Text, View, Button } from 'react-native';

const Page1 = ({ navigation }: { navigation: any }) => {
  return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <Text>Page 1</Text>
        <Button title="Go back" onPress={() => navigation.goBack()} />
      </View>
    );
  }

export default Page1;