# variables
CC = gcc
CFLAGS = -g -I./src -I./src/libs

SRC_DIR = ./src
LIB_DIR = ./src/libs
TEST_DIR = ./src/tests

SRCS = $(wildcard $(SRC_DIR)/*.c)
LIBS = $(wildcard $(LIB_DIR)/*.c)
TESTS = $(wildcard $(TEST_DIR)/test_*.c)

OBJS = $(SRCS:.c=.o) $(LIBS:.c=.o)
TEST_BINS = $(TESTS:.c=)

OUTPUT = build-$(shell date +"%Y-%m-%d_%H-%M-%S").out

.PHONY: all
all: $(OUTPUT)

$(OUTPUT): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(OBJS) $(OUTPUT)

.PHONY: test
test: $(TEST_BINS)
	@for test in $^ ; do \
		echo "Running $$test"; \
		$$test || echo "ERROR $$test"; \
	done

$(TEST_DIR)/%: $(TEST_DIR)/%.c
	$(eval LIBS_TO_INCLUDE=$(shell ./parse_includes.sh $< $(LIB_DIR)))
	@echo "Libraries to include: " $(LIBS_TO_INCLUDE)
	-$(CC) $(CFLAGS) $< $(LIBS_TO_INCLUDE) -o $@


.PHONY: test_clean
test_clean:
	rm -f $(TEST_BINS)
