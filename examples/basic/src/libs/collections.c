#include <stddef.h>
#include <stdlib.h>
#include "collections.h"


/*
 *@brief fnv1a string hash function.
 * 
 * Explaination of this hash can be found here:
 * https://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function
 * Returns the fnv1a hash of the given string.
 *
 * @param str The key to be hashed.
 * @returns An fnv1a hash of the input string.
 */
static unsigned long _hash(const char* str) {
    unsigned long hash = 14695981039346656037UL;
    const unsigned char* s = (const unsigned char*)str;

    while (*s) {
        hash ^= *s++;
        hash *= 1099511628211UL;
    }

    return hash;
}

void _hash_table_add(struct HashTable* self, char* key, void* value){
    self->length++;
}

void _hash_table_remove(struct HashTable* self, char* key){
    self->length--;
}

void* _hash_table_get(struct HashTable* self, char* key, void* default){

}

void* _hash_table_free(struct HashTable* self){
    free(self);
}

HashTable* new_hashtable(){
    HashTable* new_table = malloc(sizeof(HashTable))
    new_table->length = 0;
    new_table->add = &_hash_table_add;
    new_table->remove = &_hash_table_remove;
    new_table->get = &_hash_table_get;
    new_table->free = &_hash_table_free;
    return new_table;
}