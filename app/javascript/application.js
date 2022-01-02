// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "@themesberg/flowbite"
import "controllers"
import { ApolloClient, HttpLink, InMemoryCache, gql } from "@apollo/client"

console.log("Hello from the console!");

const railsCsrfToken = document
  .querySelector("meta[name=csrf-token]")
  ?.getAttribute("content")

const client = new ApolloClient({
  cache: new InMemoryCache(),
  link: new HttpLink({
    uri: "http://localhost:3000/graphql",
    headers: {
      "X-CSRF-Token": railsCsrfToken,
    },
  }),
});

const TEST_QUERY = gql`
	query Test {
		teams {
			id
		}
	}
`

client
	.query({ query: TEST_QUERY })
	.then(result => console.log("GraphQL result: ", result.data))