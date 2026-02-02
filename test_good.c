/*
** EPITECH PROJECT, 2024
** EpicCheck
** File description:
** Example of a compliant C file
*/

#include <stdio.h>
#include <stdlib.h>

int add_numbers(int a, int b)
{
    int result = 0;

    result = a + b;
    return result;
}

int main(void)
{
    int sum = 0;

    sum = add_numbers(42, 24);
    printf("Sum: %d\n", sum);
    return 0;
}
