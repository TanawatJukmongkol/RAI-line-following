# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tjukmong <tjukmong@student.42bangkok.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/27 23:18:09 by tjukmong          #+#    #+#              #
#    Updated: 2023/10/27 02:35:52 by Tanawat J.       ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		= Arduino.a
INCLUDE_OBJ	= -I/usr/avr/include \
				-I../../variants/standard
INCLUDE_SRC	= -L/usr/avr/lib

CHIP		= atmega328p
PORT		= /dev/ttyACM0
BAUDRATE	= 115200
F_CPU		= 16000000UL

DEFINES		= -DBAUD=${BAUDRATE} -DF_CPU=${F_CPU}

CC			= avr-g++
CFLAGS		= -g -Wall -Werror -Wextra

SRC_DIR		= ./
BUILD_DIR	= ./build

SRC			= hooks.c WInterrupts.c wiring_analog.c wiring.c wiring_digital.c wiring_pulse.c wiring_shift.c \
				abi.cpp HardwareSerial0.cpp HardwareSerial2.cpp HardwareSerial.cpp PluggableUSB.cpp Stream.cpp Tone.cpp WMath.cpp \
				CDC.cpp HardwareSerial1.cpp HardwareSerial3.cpp IPAddress.cpp new.cpp Print.cpp USBCore.cpp WString.cpp \
				main.cpp
OBJ_C		= ${SRC:.c=.o}
OBJ			= ${OBJ_C:.cpp=.o}
HEX			= ${addprefix ${NAME},.hex}

OBJ_PATH	= ${addprefix ${BUILD_DIR}/,${OBJ}}

all: init bin # flash serial

init:
	mkdir -p ${BUILD_DIR}

${BUILD_DIR}/%.o: ${SRC_DIR}/%.c
	$(CC) ${INCLUDE_OBJ} -Os ${DEFINES} -mmcu=${CHIP} -c -o $@ $^

${BUILD_DIR}/%.o: ${SRC_DIR}/%.cpp
	$(CC) ${INCLUDE_OBJ} -Os ${DEFINES} -mmcu=${CHIP} -c -o $@ $^

bin: ${BUILD_DIR} ${NAME}

${NAME}: ${OBJ_PATH}
	avr-ar -rcs ${NAME} ${OBJ_PATH}
# $(CC) -mmcu=${CHIP} ${OBJ_PATH} ${INCLUDE_SRC} ${DEFINES} -o ${NAME}
# avr-objcopy -O ihex -R .eeprom ${NAME} ${HEX}

flash: ${HEX}
	avrdude -F -V -c arduino -p $(shell echo "${CHIP}" | tr '[:lower:]' '[:upper:]') -P ${PORT} -b ${BAUDRATE} -U flash:w:${HEX}

serial:
	picocom -b ${BAUDRATE} ${PORT}

clean:
	rm -rf ${BUILD_DIR}

fclean: clean
	rm -f ${HEX}
	rm -f ${NAME}

re: fclean all

.PHONY: all bin flash serial clean fclean re
