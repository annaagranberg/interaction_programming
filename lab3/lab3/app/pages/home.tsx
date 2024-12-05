import React from 'react';
import { Text, View, Button } from 'react-native';
import { ApolloProvider } from '@apollo/client';
import client from './ApolloClient';

import TrendingRepos from './trendingPos';

const Home = ({ navigation }: { navigation: any }) => {
  return (
    <ApolloProvider client={client}>
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        {/* <Button title="Go to Page 1" onPress={() => navigation.navigate('Page1')} />
        <Button title="Go to Page 2" onPress={() => navigation.navigate('Page2')} /> */}
        <TrendingRepos />
      </View>
    </ApolloProvider>
  );
}
export default Home;