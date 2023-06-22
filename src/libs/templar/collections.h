#ifndef COLLECTIONS_H
#define COLLECTIONS_H

typedef struct HashNode {
    void* value;
    struct HashNode* next;
} HashNode;


// Forward declaration
struct HashTable;

typedef struct HashTable {
    int length;
    struct HashNode* table;
    void (*htadd)(struct HashTable* self, char* key, void* value);
    void (*htremove)(struct HashTable* self, char* key);
    void* (*htget)(struct HashTable* self, char* key, void* default_value);
    void (*htfree)(struct HashTable* self);
} HashTable;

HashTable* new_hashtable();

#endif