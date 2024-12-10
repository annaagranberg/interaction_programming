import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../index';

type RepoDetailsRouteProp = RouteProp<RootStackParamList, 'RepoDetails'>;

const formatDate = (isoString: string) => {
    const date = new Date(isoString);
    return date.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
    });
};

const RepoDetails = ({ route }: { route: RepoDetailsRouteProp }) => {
    const { repo } = route.params;

    return (
        <View style={styles.container}>
            <View style={styles.container2}>
                <Text style={styles.title}>
                    {repo.name} by {repo.owner.login}
                </Text>
            </View>
            <Text style={styles.text}>
                <Text style={styles.bold}>Stars:</Text> {repo.stargazerCount}
            </Text>
            <Text style={styles.text}>
                <Text style={styles.bold}>Created At:</Text> {formatDate(repo.createdAt)}
            </Text>
            <Text style={styles.text}>
                <Text style={styles.bold}>Forks:</Text> {repo.forks.totalCount}
            </Text>
            <Text style={styles.text}>
                <Text style={styles.bold}>Primary Language:</Text> {repo.primaryLanguage?.name || 'N/A'}
            </Text>
            <Text> 
                <Text style={styles.bold}>License:</Text> {repo.licenseInfo?.name || 'N/A'}
            </Text>
            <Text> 
                <Text style={styles.bold}>Watchers:</Text> {repo.watchers.totalCount}
            </Text>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 20,
        backgroundColor: 'white',
    },
    text: {
        fontSize: 18,
        marginBottom: 10,
        color: 'black',
    },
    bold: {
        fontWeight: 'bold',
    },
    container2: {
        marginBottom: 20,
        alignItems: 'center',  
        justifyContent: 'center', 
    },
    title: {
        fontSize: 24,
        fontWeight: 'bold',
        textAlign: 'center', 
    },
});

export default RepoDetails;
