# Ask a Cuban

**How to access the API

JSON:

Login: https://ask-a-cuban.herokuapp.com/username="USERNAME"

    You are now logged in!
Logout: https://ask-a-cuban.herokuapp.com/logout

Items Index: https://ask-a-cuban.herokuapp.com/items.json

Items Create: https://ask-a-cuban.herokuapp.com/items/new

          {
          "id": 2,
          "user_id": 3,
          "title": "Product Hunt - Best way to find new products and services",
          "url": "https://producthunt.com",
          "content": null,
          "disabled": false,
          "comments_count": 0,
          "upvotes_count": 0,
          "downvotes_count": 0,
          "score": 0,
          "rank": 0,
          "created_at": "2016-03-05T16:01:56.446Z",
          "updated_at": "2016-03-05T16:01:56.446Z"
          }


Items Edit: https://ask-a-cuban.herokuapp.com/items/id/edit

Comment New: https://ask-a-cuban.herokuapp.com/items/id/item_comments/new

                {
                    "id": 3,
                    "user_id": 5,
                    "item_id": 2,
                    "content": "1st",
                    "created_at": "2016-03-05T16:40:24.594Z",
                    "updated_at": "2016-03-05T16:40:24.594Z"
                }

Comment Edit: https://ask-a-cuban.herokuapp.com/items/id/item_comments/edit

Comments: https://ask-a-cuban.herokuapp.com/items/id.json

Create User: https://ask-a-cuban.herokuapp.com/user/new

          {

            "username": "Bob Saget",
            "password": "12345",
            "password_confirmation": "12345",
            "about": "I like to take long walks on the beach"
        }







