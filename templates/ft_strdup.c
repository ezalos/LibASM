/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strdup.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ldevelle <ldevelle@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/11/12 17:11:48 by ldevelle          #+#    #+#             */
/*   Updated: 2020/11/17 10:57:39 by ezalos           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <sys/types.h>

size_t		ft_strlen(const char *s);

char	*ft_strdup(const char *src)
{
	char	*dest;
	int		i;
	int		size;

	size = ft_strlen(src);
	if (!(dest = (char*)malloc(sizeof(char) * (size + 1))))
		return (NULL);
	dest[size] = '\0';
	i = -1;
	while (++i < size)
		dest[i] = src[i];
	return (dest);
}
