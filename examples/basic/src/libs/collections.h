#ifndef COLLECTIONS_H
#define COLLECTIONS_H

typedef struct HashNode {
    void* value;
    HashNode* next;
} HashNode;

typedef struct {
    int length;
    HashNode* table;
    void (*add)(struct HashTable* self, char* key, void* value);
    void (*remove)(struct HashTable* self, char* key);
    void* (*get)(struct HashTable* self, char* key, void* default);
    void* (*free)(struct HashTable* self)
} HashTable;

HashTable* new_hashtable();

#endif