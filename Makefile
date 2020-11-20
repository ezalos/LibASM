# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ezalos <ezalos@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/20 16:46:57 by ezalos            #+#    #+#              #
#    Updated: 2020/11/20 16:02:45 by ezalos           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		= libASM.a
TESTOR		= lib_testor.out

CC			= gcc
AR			= ar -rcs
NS			= nasm -f elf64

CFLAGS		= -Wall -Werror -Wextra

#For developping purposes:
# CFLAGS 		+= -fsanitize=address,undefined -g3
# CFLAGS 		+= -g

ASM_EXT		= .asm

SRCS_DIR	= srcs/
TUTO_DIR	= tutos/
TMPL_DIR	= templates/
HEAD_DIR	= includes/
OBJS_DIR	= objs/
$(shell mkdir -p $(OBJS_DIR))
SRCS		= $(wildcard $(SRCS_DIR)*$(ASM_EXT))
TMPL		= $(wildcard $(TMPL_DIR)*.c)
TUTO		= $(wildcard $(TUTO_DIR)*$(ASM_EXT))
EXEM		= $(TMPL:%.c=%$(ASM_EXT))
OBJS		= $(SRCS:$(SRCS_DIR)%$(ASM_EXT)=$(OBJS_DIR)%.o)
TUTOBJ		= $(TUTO:%$(ASM_EXT)=%.o)
TUTOUT		= $(TUTO:%$(ASM_EXT)=%)

##########################
##						##
##		  BASIC			##
##						##
##########################

all: $(NAME)

$(NAME): $(OBJS)
	$(AR) $(NAME) $(OBJS)

$(OBJS_DIR)%.o: $(SRCS_DIR)%$(ASM_EXT) Makefile
	$(NS) $< -o $@

$(TESTOR): $(NAME) main.c
	$(CC) $(CFLAGS) main.c $(OBJS) -o $(TESTOR) -L. -lASM

$(TMPL_DIR)%$(ASM_EXT): $(TMPL_DIR)%.c Makefile
	$(CC) -S -masm=intel  -no-pie -fno-pie $< -o $@

$(TUTO_DIR)%.o: $(TUTO_DIR)%$(ASM_EXT) Makefile
	$(NS) $< -o $@
	gcc -Wall -Wextra -Werror  -g -no-pie -o '$<.out' $@

templates: $(EXEM)

tuto: $(TUTOBJ)

clean:
	rm -rf $(OBJS)
	rm -rf $(OBJS_DIR)
	rm -rf $(EXEM)

fclean: clean
	rm -rf $(NAME) $(TESTOR)

re : fclean
	$(MAKE) all

##########################
##						##
##		  PERSO			##
##						##
##########################

SUPPORTED_COMMANDS := run tests
SUPPORTS_MAKE_ARGS := $(findstring $(firstword $(MAKECMDGOALS)), $(SUPPORTED_COMMANDS))
ifneq "$(SUPPORTS_MAKE_ARGS)" ""
  COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(COMMAND_ARGS):;@:)
endif

run: $(TESTOR)
	./$(TESTOR) $(COMMAND_ARGS)

ifeq ($(UNAME),Linux)
tests: $(NAME)
	sh .tmp/script_linux.sh $(COMMAND_ARGS)
else
tests: $(NAME)
	sh .tmp/script_macos.sh $(COMMAND_ARGS)
endif

prototypes:
	python3 .tmp/prototype_catcher.py srcs includes/prototypes_malloc.h malloc

REQUEST 		= 'read -p "Enter a commit message:	" pwd && echo $$pwd'
COMMIT_MESSAGE ?= $(shell bash -c $(REQUEST))
git :
		git add -A
		git status
		(echo -n "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ])
		git commit -m "$(COMMIT_MESSAGE)"
		git push

.PHONY: clean fclean
