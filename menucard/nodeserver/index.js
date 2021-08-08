// index.js

const { ApolloServer, gql } = require("apollo-server");

const menuItems = [
  {
    id: 1,
    name: "Pizza",
    category: "Meal",
    price: "4.5"
  },
  {
    id: 2,
    name: "Burger",
    category: "Meal",
    price: "3.2"
  },
]

const typeDefs = gql`

  """"
  Menu item represents a single menu item with a set of data
  """
  type MenuItem {
    id: ID!
    name: String!
    category: String!
    price: Float!
  }

  type Query {                 

    "Get menu Items"
    menuItems: [MenuItem]      
  }
`
const resolvers = {
  Query: {
    menuItems: () => menuItems
  }
}

const server = new ApolloServer({
  typeDefs,
  resolvers,
});

server.listen().then(({ url }) => {
  console.log(`🚀  Server ready at ${url}`);
});
