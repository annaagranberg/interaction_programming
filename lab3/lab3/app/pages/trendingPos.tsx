import React, { useState } from 'react';
import { View, Text, FlatList, StyleSheet, TouchableOpacity, ActivityIndicator, TextInput } from 'react-native';
import { useQuery, gql } from '@apollo/client';
import DropdownComponent from './dropDown';
import { useNavigation } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { StackNavigationProp } from '@react-navigation/stack';
import Icon from 'react-native-vector-icons/FontAwesome';

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
          licenseInfo {
            name
          }
        watchers {
            totalCount
        }
        }
      }
    }
  }
}
`;


const TrendingRepos = () => {

    type RootStackParamList = {
        TrendingRepos: undefined;
        RepoDetails: { repo: any };
    };

    const Stack = createStackNavigator<RootStackParamList>();

    type TrendingReposScreenProp = StackNavigationProp<RootStackParamList, 'TrendingRepos'>;
    const navigation = useNavigation<TrendingReposScreenProp>();

    const [selectedLanguage, setSelectedLanguage] = useState<string>('language:C++ sort:stars');
    const [selectedYear, setSelectedYear] = useState<string>('2024');

    const handleYearChange = (year: string) => {
        setSelectedYear(year);
    };

    const handleLanguageChange = (language: string) => {
        setSelectedLanguage(language);
    };

    const { loading, error, data } = useQuery(GET_TRENDING_REPOS, {
        variables: {
            selectedLanguage: `${selectedLanguage} created:>=${selectedYear}-01-01 created:<=${selectedYear}-12-31`,
        },
        fetchPolicy: 'network-only',
    });


    if (loading) return <ActivityIndicator size="large" color="black" />;
    if (error) return <Text>Error: {error.message}</Text>;

    return (
        <View>
            <View style={styles.filterRow}>
                <DropdownComponent onValueChange={handleYearChange} datasetChoice={1} />
                <DropdownComponent onValueChange={handleLanguageChange} datasetChoice={2} />
            </View>
            <FlatList
                data={data?.search?.edges || []}
                keyExtractor={(item) => item.node.name}
                renderItem={({ item }) => (
                    <View style={styles.card}>
                        <View style={styles.cardContent}>
                            <Text style={styles.title}> {item.node.name}</Text>
                            <View style={styles.infoRow}>
                                <Icon name="star" size={20} color="#FFD700" />
                                <Text style={styles.text}>{item.node.stargazerCount}</Text>
                            </View>

                            <View style={styles.infoRow}>
                                <Icon name="code-fork" size={20} color="black" />
                                <Text style={styles.text}>{item.node.forks.totalCount}</Text>
                            </View>
                            <Text style={styles.text}><Text style={styles.textBold}>Primary Language:</Text> {item.node.primaryLanguage?.name || "N/A"}</Text>
                            <TouchableOpacity
                                style={styles.readMore}
                                onPress={() =>
                                    navigation.navigate('RepoDetails', {
                                        repo: item.node,
                                    })
                                }
                            >
                                <Text style={styles.readMoreText}>Read more</Text>
                            </TouchableOpacity>
                        </View>
                    </View>
                )}
                contentContainerStyle={{ paddingBottom: 300 }}
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
    infoRow: {
        flexDirection: 'row',
        alignItems: 'center',
        marginBottom: 10,
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
    textInput: {
        height: 40,
        borderColor: 'gray',
        borderWidth: 1,
        margin: 10,
        padding: 10,
    },
    title: {
        color: 'black',
        fontSize: 20,
        fontFamily: 'sans-serif',
        marginBottom: 5,
        fontWeight: 'bold',
    },
    filterRow: {
        flexDirection: 'row',
        alignItems: 'center',
        marginBottom: 10,
        justifyContent: 'space-around',
    },
});

export default TrendingRepos;
