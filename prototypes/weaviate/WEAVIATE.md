# Create Collection
```bash
curl -X POST http://localhost:8082/v1/schema \
  -H "Content-Type: application/json" \
  -d '{
    "class": "ObsidianFile",
    "description": "Obsidian vault in vector db",
    "vectorizer": "text2vec-transformers",
    "moduleConfig": {
      "text2vec-transformers": {
        "vectorizeClassName": true
      }
    },
    "properties": [
      {
        "name": "path",
        "dataType": ["text"],
        "description": "The file path"
      },
      {
        "name": "content",
        "dataType": ["text"],
        "description": "The file content"
      }
    ]
  }'

```

# List all collections
```bash
curl -X GET http://localhost:8082/v1/schema \
  -H "Content-Type: application/json" | jq
```

# Add data
```bash
curl -X POST http://localhost:8082/v1/objects \
  -H "Content-Type: application/json" \
  -d '{
    "class": "ObsidianFile",
    "properties": {
      "path": "example.txt",
      "content": "Lets talk over a coffee"
    }
  }'
```

# Query data nearText
```bash
curl -X POST http://localhost:8082/v1/graphql \
  -H "Content-Type: application/json" \
  -d '{"query":"{ Get { ObsidianFile(nearText: { concepts: [\"Recipe for salmon peppers\"], certainty: 0.7  }) { path content _additional { distance } } } }"}' | jq
```

# Query data by path
```bash
echo '{
  "query": "{
    Get {
      ObsidianFile(where: {
        path: [\"path\"],
        operator: Equal,
        valueText: \"FritzSync/private/FritzSync/private/Health/Sleep Journal.md \"
      }) {
        _additional { id }
      }
    }
  }"
}' | curl \
  -X POST \
  -H 'Content-Type: application/json' \
  -d @- \
  http://localhost:8082/v1/graphql
```

# Query data hybrid
```bash
curl -X POST http://localhost:8082/v1/graphql \
  -H "Content-Type: application/json" \
  -d '{"query":"{ Get { ObsidianFile(limit: 1, hybrid: {query: \"slept 7h. Feel rested\", alpha: 0.5}) { path content } } }"}' | jq

```
# Delete collection
```bash
curl -X DELETE "http://localhost:8082/v1/schema/ObsidianFile"
```

# Delete document
```bash
curl 'http://localhost:8082/v1/objects/ObsidianFile/1a564530-ae14-46c0-931f-8aff4e99dd69?consistency_level=&tenant=' \
  --request DELETE
```

# List all items in collection
```bash
curl -X POST "http://localhost:8082/v1/graphql" \
-H "Content-Type: application/json" \
-d '{
  "query": "{ Get { ObsidianFile { _additional { id } path } } }"
}'
```
