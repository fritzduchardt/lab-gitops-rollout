# Best practice: store your credentials in environment variables
# export WEAVIATE_URL="YOUR_INSTANCE_URL"  # Your Weaviate instance URL
# export WEAVIATE_API_KEY="YOUR_API_KEY"   # Your Weaviate instance API key

curl -X POST \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $WEAVIATE_API_KEY" \
-d '{
  "class": "Question",
  "vectorizer": "text2vec-weaviate",
  "moduleConfig": {
    "text2vec-weaviate": {},
    "generative-cohere": {}
  }
}' \
"$WEAVIATE_URL/v1/schema"
