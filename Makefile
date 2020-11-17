# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ezalos <ezalos@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/20 16:46:57 by ezalos            #+#    #+#              #
#    Updated: 2020/11/17 10:58:03 by ezalos           ###   ########.fr        #
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

SRCS_DIR	= srcs/
TMPL_DIR	= templates/
HEAD_DIR	= includes/
OBJS_DIR	= objs/
OBJS_RBT_DIR	= objs/rbt/
$(shell mkdir -p $(OBJS_DIR))
SRCS		= $(wildcard $(SRCS_DIR)*.S)
TMPL		= $(wildcard $(TMPL_DIR)*.c)
EXEM		= $(TMPL:%.c=%.S)
OBJS		= $(SRCS:$(SRCS_DIR)%.S=$(OBJS_DIR)%.o)

##########################
##						##
##		  BASIC			##
##						##
##########################

all: $(NAME)

$(NAME): $(OBJS)
	$(AR) $(NAME) $(OBJS)

$(OBJS_DIR)%.o: $(SRCS_DIR)%.S Makefile
	$(NS) $< -o $@

$(TESTOR): $(NAME)
	$(CC) $(CFLAGS) main.c $(OBJS) -o $(TESTOR) -L. -lASM

$(TMPL_DIR)%.S: $(TMPL_DIR)%.c Makefile
	$(CC) -S -masm=intel $< -o $@

templates: $(EXEM)


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
