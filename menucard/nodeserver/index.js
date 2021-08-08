// index.js

const { ApolloServer, gql } = require("apollo-server");

//  menuItem (id: ID!): MenuItem , create a param for both queries and mutations

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
    menuItem (id: Int!): MenuItem
  }
`


const resolvers = {
  Query: {
    menuItems: () => menuItems,
    menuItem:(_, { id })=> menuItems.find(({ id: _id }) => _id === id)
  }
}

const server = new ApolloServer({
  typeDefs,
  resolvers,
});

server.listen().then(({ url }) => {
  console.log(`🚀  Server ready at ${url}`);
});
