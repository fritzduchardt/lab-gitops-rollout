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

# Query data
```bash
curl -X POST http://localhost:8082/v1/graphql \
  -H "Content-Type: application/json" \
  -d '{"query":"{ Get { ObsidianFile(nearText: { concepts: [\"romans\"], certainty: 0.7  }) { name content _additional { distance } } } }"}'
```

# Delete collection
```bash
curl -X DELETE "http://localhost:8082/v1/schema/ObsidianFile"
```

# List all items in collection
```bash
curl -X POST "http://localhost:8082/v1/graphql" \
-H "Content-Type: application/json" \
-d '{
  "query": "{ Get { ObsidianFile { _additional { id } path } } }"
}'
```
