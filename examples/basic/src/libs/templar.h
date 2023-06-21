#ifndef TEMPLAR_H
#define TEMPLAR_H
#include <stdbool.h>

/*
 * @brief Determine if a string has all unique characters.
 *
 * This function takes a string and returns 'true' if the
 * string contains only unique characters. 'false' otherwise.
 * Utilizes 'stdbool'.
 * 
 * @param string The string to validate.
 * @return true or false, does the string
 * have only uniqe, non-repeating characters?
 */
bool is_unique(char* string);
#endif