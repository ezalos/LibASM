#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern size_t	ft_strlen(const char *s);
extern int		ft_strcmp(const char *s1, const char *s2);

#define NUMBER_OF_STRING 14
#define MAX_STRING_SIZE 40
char arr_strlen[NUMBER_OF_STRING][MAX_STRING_SIZE] =
{
	"1234567890",
	"Hello World!\n",
	"1",
	"12",
	"123",
	"1234",
	"12345",
	"1234\16856",
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

	printf("%s\n", __func__);
	i = 0;
	while (i < NUMBER_OF_STRING)
	{
		if ((them = strlen(arr_strlen[i])) != (mine = ft_strlen(arr_strlen[i])))
			printf("Error   %d, me %zu != %zu it. |%s|\n", i, mine, them, arr_strlen[i]);
		else
			printf("Success %d!\n", i);
		i++;
	}
	printf("\n");
}

void			test_strcmp(void)
{
	int			mine;
	int			them;
	int			i;
	int			j;

	printf("%s\n", __func__);
	i = 0;
	while (i < NUMBER_OF_STRING)
	{
		j = 0;
		while (j < NUMBER_OF_STRING)
		{
			if ((them = strcmp(arr_strlen[i], arr_strlen[j])) != (mine = ft_strcmp(arr_strlen[i], arr_strlen[j])))
				printf("Error   %d-%d, me %d != %d it. \n\t|%s|\n\t|%s|\n", i, j, mine, them, arr_strlen[i], arr_strlen[j]);
			else
				printf("Success %d-%d!  ret: %d, \n", i, j, them);
			j++;
		}
		i++;
	}
	printf("\n");
}

int				main(int ac, char** av)
{
	(void)ac;
	(void)av;
	// test_strlen();
	// test_strcmp();
}
