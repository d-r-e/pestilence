NAME=pestilence
SRC=src/pestilence.s
OBJ=src/pestilence.o
NASM=nasm
DEPS= nasm binutils strace
$(NAME): $(OBJ)
	mkdir -p /tmp/test
	mkdir -p /tmp/test2
	ld $(OBJ) -o $(NAME)

$(OBJ): $(SRC)
	$(NASM) -felf64 -g $(SRC)
	
clean:
	rm -f $(OBJ)
	rm -f /tmp/test/*
	rm -f /tmp/test2/*

fclean: clean
	rm -f $(NAME)

re: fclean all

all: $(NAME)
gdb: clean echo
	gdb $(NAME)
x: $(NAME)
	./$(NAME)
s: $(NAME)
	mkdir -p /tmp/test
	cp /bin/echo /tmp/test/echo
	cp /bin/dir /tmp/test/
	strace ./$(NAME)
	strings /tmp/test/echo | grep --color=always "darodrig"
	cp /bin/dir /tmp/test/
	/tmp/test/echo -e "\033[0;33mP3ST1L3NC3\033[0m"
	strings /tmp/test/dir | grep --color=always "darodrig"
ss: s
	binwalk -W /tmp/test/echo /bin/echo | less
echo: $(NAME)
	rm -f  /tmp/test/*
	cp /bin/echo /tmp/test/echo
	strace ./$(NAME)

sd: s
	binwalk -W /tmp/test/dir /bin/dir | less

test: cicd

cicd: $(NAME)
	mkdir -p /tmp/test
	mkdir -p /tmp/test2/
	cp /bin/echo /tmp/test/echo
	./$(NAME)
	strings /tmp/test/echo | grep "darodrig"
	cp /bin/dir /tmp/test2/
	/tmp/test/echo
	strings /tmp/test2/dir | grep "darodrig"
add: test fclean 
	git add $(SRC) Makefile README.md

commit: add
	git commit -m "pestilence"
push: commit
	git pull
	git push
deps:
	sudo apt-get install -yq $(DEPS)

PHONY: add commit push test clean fclean all