# Create Collection
```bash
curl -X POST http://localhost:8082/v1/schema \
  -H "Content-Type: application/json" \
  -d '{
    "class": "PatternFile",
    "description": "File with fabric pattern",
    "vectorizer": "text2vec-openai",
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

# Delete collection
```bash
curl -X DELETE "http://localhost:8082/v1/schema/PatternFile"
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
    "class": "PatternFile",
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
  -d '{"query":"{ Get { PatternFile(limit: 1, nearText: { concepts: [\"Make me new hard exercise\"], distance: 0.8  }) { path content _additional { distance } } } }"}' | jq
```

# Query data hybrid
```bash
curl -X POST http://localhost:8082/v1/graphql \
  -H "Content-Type: application/json" \
  -d '{"query":"{ Get { PatternFile(limit: 1, hybrid: {query: \"In weaviate explain the difference between neartext and hybrid search\", alpha: 0.9}) { path content _additional { distance }} } }"}' | jq
```

# Query data by path
```bash
echo '{
  "query": "{
    Get {
      PatternFile(where: {
        path: [\"path\"],
        operator: Equal,
        valueText: \"FritzSync/private/Health/Doctor Protocol.md\"
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


# Delete document
```bash
curl 'http://localhost:8082/v1/objects/457b6cca-7fe3-456a-98fc-268436a7e4d4?consistency_level=&tenant=' \
  --request DELETE
```

# List all items in collection
```bash
curl -X POST "http://localhost:8082/v1/graphql" \
-H "Content-Type: application/json" \
-d '{
  "query": "{ Get { PatternFile { _additional { id } path } } }"
}'
```
