import { ApolloClient, InMemoryCache, HttpLink } from '@apollo/client';

const client = new ApolloClient({
  link: new HttpLink({
    uri: 'https://api.github.com/graphql', 
    headers: {
      Authorization: `Bearer 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`, 
    },
  }),
  cache: new InMemoryCache(),
});


export default client;