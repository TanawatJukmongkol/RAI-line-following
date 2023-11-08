/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: Tanawat J. <66011255@kmitl.ac.th>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/11/08 19:41:26 by Tanawat J.        #+#    #+#             */
/*   Updated: 2023/11/08 19:58:28 by Tanawat J.       ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "main.h"

int	__init__(void)
{
	Serial.begin(BAUD);
	return (0);
}

int	main(void)
{
	if (__init__())
		return (1);
	while (1)
	{
		Serial.println("Hello, world!");
	}
	return (0);
}
