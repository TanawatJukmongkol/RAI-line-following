# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tjukmong <tjukmong@student.42bangkok.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/10/27 03:49:12 by Tanawat J.        #+#    #+#              #
#    Updated: 2023/11/08 20:57:20 by Tanawat J.       ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		= hello_world
INCLUDE_OBJ	= -I/usr/avr/include \
				-I./lib/Servo/src \
				-I./lib/arduino/variants/standard \
				-I./lib/arduino/cores/arduino
INCLUDE_SRC	= -L/usr/avr/lib \
				./lib/Servo/src/Servo.a \
				./lib/arduino/cores/arduino/Arduino.a

CHIP		= atmega328p
PORT		= /dev/ttyACM0
BAUDRATE	= 115200
F_CPU		= 16000000UL
# BAUDRATE	= 9600
# F_CPU		= 1000000L

DEFINES		= -DBAUD=${BAUDRATE} -DF_CPU=${F_CPU}

CC			= avr-g++
CFLAGS		= -g -Wall -Werror -Wextra

SRC_DIR		= ./src
BUILD_DIR	= ./build

SRC			= main.c
EXTENSION	= c
OBJ			= ${SRC:.${EXTENSION}=.o}
HEX			= ${addprefix ${NAME},.hex}

OBJ_PATH	= ${addprefix ${BUILD_DIR}/,${OBJ}}

all: ${NAME}

init:
	make -C ./lib/arduino/cores/arduino
	make -C ./lib/Servo/src
	mkdir -p ${BUILD_DIR}

${BUILD_DIR}/%.o: ${SRC_DIR}/%.${EXTENSION}
	$(CC) ${INCLUDE_OBJ} -Os ${DEFINES} -mmcu=${CHIP} -c -o $@ $^

bin: init ${BUILD_DIR}

${NAME}: bin flash serial

${HEX}: ${OBJ_PATH}
	$(CC) -mmcu=${CHIP} ${OBJ_PATH} ${INCLUDE_SRC} ${DEFINES} -o ${NAME}
	avr-objcopy -O ihex -R .eeprom ${NAME} ${HEX}

flash: ${HEX}
	avrdude -F -V -c arduino -p $(shell echo "${CHIP}" | tr '[:lower:]' '[:upper:]') -P ${PORT} -b ${BAUDRATE} -U flash:w:${HEX}

serial:
	picocom -b ${BAUDRATE} ${PORT}

clean:
	rm -rf ${BUILD_DIR}

fclean: clean
	make fclean -C ./lib/arduino/cores/arduino
	make fclean -C ./lib/Servo/src
	rm -f ${HEX}
	rm -f ${NAME}

re: fclean all

.PHONY: all bin flash serial clean fclean re
