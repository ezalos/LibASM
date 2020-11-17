#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern size_t	ft_strlen(const char *s);

#define NUMBER_OF_STRING 13
#define MAX_STRING_SIZE 40
char arr_strlen[NUMBER_OF_STRING][MAX_STRING_SIZE] =
{
	"Hello World!\n",
	"1",
	"12",
	"123",
	"1234",
	"12345",
	"123456",
	"1234567",
	"\0",
	"array of c string",
	"is fun to use",
	"make sure to properly",
	"tell the array size"
};

void			test_strlen(void)
{
	size_t		mine;
	size_t		them;
	int			i;

	i = 0;
	while (i < NUMBER_OF_STRING)
	{
		if ((them = strlen(arr_strlen[i])) != (mine = ft_strlen(arr_strlen[i])))
			printf("Error   %d, me %zu != %zu it. |%s|\n", i, mine, them, arr_strlen[i]);
		else
			printf("Success %d!\n", i);
	}
}

int				main(int ac, char** av)
{
	(void)ac;
	(void)av;
	test_strlen();
}
