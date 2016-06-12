# tagging-api

# Generic Tagging JSON API

We will be building a Generic Tagging JSON API that can store, retrieve, delete and report on the usage of a "tag" across different entities. This is a guide for the endpoints, if you think you have a better route or would like to modify the naming/schema feel free.

### Create an Entry

```
POST /entities

- Entity Type, e.g. 'Product', 'Article'
- Entity Identifier, e.g. '1234', '582b5530-6cdb-11e4-9803-0800200c9a66'
- Tags, e.g. ['Large', 'Pink', 'Bike']

If the entity already exists it should replace it and all tags, not append to it
```

**Example:**

```
curl -H "Content-Type: application/json" -H 'Authorization: Token token="1d9f3251b1591a5d9529c88655950370"' -d '{"entity": {"entity_type": "Product", "entity_id": "bike5"}, "tags": ["Small", "Blue", "Bike"]}' -X POST 'http://localhost:3000/api/entities'
```

### Retrieve an Entry

```
GET /entities/:entity_type/:entity_id

- should return a JSON representation of the entity and the tags it has assigned
```

**Examples:**

```
retrieves all entities:
curl http://api.tagger.com/api/entities -H 'Authorization: Token token="1d9f3251b1591a5d9529c88655950370"'

retrieves a specific entity:
curl -X GET 'http://localhost:3000/api/entities?entity_type=Product&entity_id=bike2' -H 'Authorization: Token token="1d9f3251b1591a5d9529c88655950370"'
``` 

### Remove an Entry

```
DELETE /entities/:entity_type/:entity_id

Completely removes the entity and tags
```

**Example:**

```
curl -X DELETE 'http://localhost:3000/api/entities?entity_type=Product&entity_id=bike5' -H 'Authorization: Token token="1d9f3251b1591a5d9529c88655950370"'
```

### Retrieve Stats about all Tags

```
GET /tags/stats

Retrives statistics about all tags

e.g. [{tag: 'Bike', count: 5}, {tag: 'Pink', count: 3}]
```

**Example:**

```
curl -X GET 'http://localhost:3000/api/tags/stats' -H 'Authorization: Token token="1d9f3251b1591a5d9529c88655950370"'
```

### Retrieve Stats about a specific Entity

```
GET /entities/stats/:entity_type/:entity_id

Retrives statistics about a specific tagged entity
```

**Example:**

```curl -X GET 'http://localhost:3000/api/entities/stats?entity_type=Product&entity_id=bike5' -H 'Authorization: Token token="1d9f3251b1591a5d9529c88655950370"'
```

### What we're looking for:

* It runs!
* We can see that all of the tests pass.
* You followed directions and used your best judgement to ensure a correct solution.
* You explained your reasoning in readme.md
* The code is understandable and easy to read.
* You followed standards and conventions relating to Ruby and Rails development.
* You've written the code as though it will be released to production.


**Once you are done, add [@damienradford](https://github.com/damienradford)**
