import React, { useState } from 'react';
import { View, Text, FlatList, StyleSheet, TouchableOpacity, ActivityIndicator } from 'react-native';
import { useQuery, gql } from '@apollo/client';
import DropdownComponent from './dropDown';

// GraphQL query with a variable for the language
const GET_TRENDING_REPOS = gql`
  query GetTrendingRepos($selectedLanguage: String!) {
    search(query: $selectedLanguage, type: REPOSITORY, first: 10) {
      edges {
        node {
          ... on Repository {
            name
            owner {
              login
            }
            stargazerCount
            createdAt
            forks {
              totalCount
            }
            primaryLanguage {
              name
            }
          }
        }
      }
    }
  }
`;

const TrendingRepos = () => {

    const [selectedLanguage, setSelectedLanguage] = useState<string>('language:C++ sort:stars');

    const handleLanguageChange = (language: string) => {
        setSelectedLanguage(language);
    };

    const { loading, error, data } = useQuery(GET_TRENDING_REPOS, {
        variables: { selectedLanguage },
        fetchPolicy: 'network-only', // Forces a network request for every variable change
    });
    

    if (loading) return <ActivityIndicator size="large" color="black" />;
    if (error) return <Text>Error: {error.message}</Text>;

    return (
        <View>
            <DropdownComponent onValueChange={handleLanguageChange} />
            <FlatList
                data={data?.search?.edges || []}
                keyExtractor={(item) => item.node.name}
                renderItem={({ item }) => (
                    <View style={styles.card}>
                        <View style={styles.cardContent}>
                            <Text style={styles.text}><Text style={styles.textBold}>Name:</Text> {item.node.name}</Text>
                            <Text style={styles.text}><Text style={styles.textBold}>Owner:</Text> {item.node.owner.login}</Text>
                            <Text style={styles.text}><Text style={styles.textBold}>Stars:</Text> {item.node.stargazerCount}</Text>
                            <Text style={styles.text}><Text style={styles.textBold}>Created At:</Text> {item.node.createdAt}</Text>
                            <Text style={styles.text}><Text style={styles.textBold}>Forks:</Text> {item.node.forks.totalCount}</Text>
                            <Text style={styles.text}><Text style={styles.textBold}>Primary Language:</Text> {item.node.primaryLanguage?.name || "N/A"}</Text>
                            <View style={styles.readMore}>
                                <TouchableOpacity onPress={() => console.log('Button pressed')}>
                                    <Text style={styles.readMoreText}>Read more</Text>
                                </TouchableOpacity>
                            </View>
                        </View>
                    </View>
                )}
            />
        </View>
    );
};

const styles = StyleSheet.create({
    picker: {
        height: 50,
        width: '100%',
        borderColor: 'gray',
        borderWidth: 1,
        marginBottom: 10,
    },
    card: {
        width: 370,
        height: 190,
        backgroundColor: 'white',
        borderRadius: 20,
        padding: 5,
        margin: 10,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.25,
        shadowRadius: 3.5,
    },
    cardContent: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'flex-start',
        margin: 10,
    },
    text: {
        color: 'black',
        fontSize: 15,
        fontFamily: 'sans-serif',
        margin: 5,
    },
    textBold: {
        color: 'black',
        fontSize: 15,
        fontFamily: 'sans-serif',
        margin: 5,
        fontWeight: 'bold',
    },
    readMore: {
        width: '30%',
        height: '23%',
        backgroundColor: 'black',
        borderRadius: 10,
        position: 'absolute',
        bottom: 0,
        right: 0,
        justifyContent: 'center',
        alignItems: 'center',
    },
    readMoreText: {
        color: 'white',
        fontSize: 15,
        fontFamily: 'sans-serif',
    },
});

export default TrendingRepos;
