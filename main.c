#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <error.h>


extern size_t	ft_strlen(const char *s);
extern int		ft_strcmp(const char *s1, const char *s2);
extern int		ft_strcpy(const char *dest, const char *src);
extern char		*ft_strdup(const char *src);
extern char		*ft_strdup(const char *src);
extern void 	ft_free(void *mem);
extern ssize_t	ft_write(int fd, const void *buf, size_t count);
extern ssize_t	ft_read(int fd, const void *buf, size_t count);


#define NUMBER_OF_STRING	14
#define MAX_STRING_SIZE 	40
#define MAX_STRING_LEN		21

char test_str[NUMBER_OF_STRING][MAX_STRING_SIZE] =
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
	"make sure to properly\0",
	"tell the array size\0"
};

void			test_strlen(void)
{
	size_t		mine;
	size_t		them;
	int			i;
	int			good = 0;
	int			total = 0;

	printf("%s\n", __func__);
	i = 0;
	while (i < NUMBER_OF_STRING)
	{
		if ((them = strlen(test_str[i])) != (mine = ft_strlen(test_str[i])))
			printf("Error   %d, me %zu != %zu it. |%s|\n", i, mine, them, test_str[i]);
		else
		{
			// printf("Success %d!\n", i);
			good++;
		}
		i++;
		total++;
	}
	printf("\tGood: %d/%d\n", good, total);
	printf("\n");
}

void			test_strcmp(void)
{
	int			mine;
	int			them;
	int			i;
	int			j;
	int			good = 0;
	int			total = 0;

	printf("%s\n", __func__);
	i = 0;
	while (i < NUMBER_OF_STRING)
	{
		j = 0;
		while (j < NUMBER_OF_STRING)
		{
			if ((them = strcmp(test_str[i], test_str[j])) != (mine = ft_strcmp(test_str[i], test_str[j])))
				printf("Error   %d-%d, me %d != %d it. \n\t|%s|\n\t|%s|\n", i, j, mine, them, test_str[i], test_str[j]);
			else
			{
				// printf("Success %d-%d!  ret: %d, \n", i, j, them);
				good++;
			}
			j++;
			total++;
		}
		i++;
	}
	printf("\tGood: %d/%d\n", good, total);
	printf("\n");
}

void			test_strcpy(void)
{
	char		*mem;
	int			them;
	int			i;
	int			good = 0;
	int			total = 0;

	printf("%s\n", __func__);
	i = 0;
	while (i < NUMBER_OF_STRING)
	{
		mem = malloc(strlen(test_str[i]));
		ft_strcpy(mem, test_str[i]);
		if ((them = strcmp(mem, test_str[i])) != 0)
			printf("Error   %d, cmp: %d.\n\t|%s|\n\t|%s|\n", i, them, test_str[i], mem);
		else
		{
			// printf("Success %d\n", i);
			good++;
		}
		free(mem);
		i++;
		total++;
	}
	printf("\tGood: %d/%d\n", good, total);
	printf("\n");
}

void			test_strdup(void)
{
	char		*mem;
	int			them;
	int			i;
	int			good = 0;
	int			total = 0;

	printf("%s\n", __func__);
	i = 0;
	while (i < NUMBER_OF_STRING)
	{
		mem = ft_strdup(test_str[i]);
		if ((them = strcmp(mem, test_str[i])) != 0)
			printf("Error   %d, cmp: %d.\n\t|%s|\n\t|%s|\n", i, them, test_str[i], mem);
		else
		{
			// printf("Success %d\n", i);
			// printf("\t |%s|\n", mem);
			good++;
		}
		// free(mem);
		i++;
		total++;
	}
	printf("\tGood: %d/%d\n", good, total);
	printf("\n");
}

void	test_write()
{
	size_t		i;
	const char	*off_file = "off_file.txt";
	const char	*my_file = "my_file.txt";
	int			off_fd;
	int			my_fd;
	char		*off_buff;
	char		*my_buff;
	ssize_t		off_ret;
	ssize_t		my_ret;
	int			errno_1;
	int			errno_2;
	int			success;
	off_buff = (char*)malloc(sizeof(*off_buff) * MAX_STRING_LEN);
	my_buff = (char*)malloc(sizeof(*my_buff) * MAX_STRING_LEN);
	i = 0;
	printf("------- Tests on ft_write --------\n\n");
	while (i < NUMBER_OF_STRING)
	{
		off_fd = open(off_file, O_RDWR | O_CREAT, S_IRWXU);
		my_fd = open(my_file, O_RDWR | O_CREAT, S_IRWXU);
		off_ret = write(off_fd, test_str[i], strlen(test_str[i]));
		my_ret = ft_write(my_fd, test_str[i], strlen(test_str[i]));
		close(off_fd);
		close(my_fd);
		off_fd = open(off_file, O_RDONLY);
		my_fd = open(my_file, O_RDONLY);
		bzero(off_buff, MAX_STRING_LEN);
		bzero(my_buff, MAX_STRING_LEN);
		read(off_fd, off_buff, strlen(test_str[i]));//Put max size
		read(my_fd, my_buff, strlen(test_str[i]));
		close(off_fd);
		close(my_fd);
		printf("TEST %2zu: ", i);
		if (off_ret != my_ret)
		{
			printf("\033[31m");
			printf("FAILURE\n");
			printf("\033[39m");
			printf("Returns are different:\n");
			printf("Official ret = %zd\n", off_ret);
			printf("My ret       = %zd\n", my_ret);
		}
		else
		{
			if (strcmp(off_buff, my_buff) != 0)
			{
				printf("\033[31m");
				printf("FAILURE\n");
				printf("\033[39m");
				printf("Buffers are different:\n");
				printf("Official buff = \"%s\"\n", off_buff);
				printf("My buff       = \"%s\"\n", my_buff);
			}
			else
			{
				printf("\033[32m");
				printf("SUCCESS\n");
				printf("\033[39m");
			}
		}
		i++;
	}
	// printf("Yo\n");
	success = 1;
	my_ret = ft_write(8, "ddsf", 4);
	errno_1 = errno;
	off_ret = write(8, "dsds", 4);
	errno_2 = errno;
	printf("TEST %2zu: ", i);
	if (off_ret != my_ret)
	{
		printf("\033[31m");
		printf("FAILURE\n");
		printf("\033[39m");
		printf("Returns are different:\n");
		printf("Official ret = %zd\n", off_ret);
		printf("My ret       = %zd\n", my_ret);
		success = 0;
	}
	if (errno_1 != errno_2)
	{
		printf("\033[31m");
		if (success)
			printf("FAILURE\n");
		printf("\033[39m");
		printf("Errno are different:\n");
		printf("Errno after ft_write = %d\n", errno_1);
		printf("Errno after write    = %d\n", errno_2);
		success = 0;
	}
	if (success)
	{
		printf("\033[32m");
		printf("SUCCESS\n");
		printf("\033[39m");
	}
	// printf("Yo\n");
	remove(off_file);
	// printf("plait\n");
	remove(my_file);
}

#define READ_LEN	100
void			test_read(void)
{
	char		buff[READ_LEN];
	ssize_t		ret;
	int			fd;

	printf("%s\n", __func__);
	errno = 0;
	fd = 10;
	memset(buff, 0, READ_LEN);
	ret = ft_read(fd, buff, READ_LEN);
	printf("ret: %ld/%d: \"%s\"\n", ret, errno, buff);
	errno = 0;
	ret = read(fd, buff, READ_LEN);
	printf("ret: %ld/%d: \"%s\"\n", ret, errno, buff);
}

int				main(int ac, char** av)
{
	(void)ac;
	(void)av;
	test_strlen();
	test_strcmp();
	test_strcpy();
	test_strdup();
	test_write();
	test_read();
}
