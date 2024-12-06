import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import TrendingRepos from './pages/trendingPos';
import RepoDetails from './pages/RepoDetails';
import { ApolloProvider } from '@apollo/client';
import client from './pages/ApolloClient';

export type RootStackParamList = {
  TrendingRepos: undefined; 
  RepoDetails: { repo: Repository };
};

export interface Repository {
  name: string;
  owner: { login: string };
  stargazerCount: number;
  createdAt: string;
  forks: { totalCount: number };
  primaryLanguage?: { name: string };
  licenseInfo?: { name: string };
  watchers: { totalCount: number };
}

const Stack = createStackNavigator<RootStackParamList>();

const App = () => {
  return (
    <ApolloProvider client={client}>
      <NavigationContainer>
        <Stack.Navigator>
          <Stack.Screen name="TrendingRepos" component={TrendingRepos} options={{ title: 'Trending Repos' }} />
          <Stack.Screen name="RepoDetails" component={RepoDetails} options={{ title: 'Repository Details' }} />
        </Stack.Navigator>
      </NavigationContainer>
    </ApolloProvider>
  );
};

export default App;
