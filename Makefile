# This makefile will do the following:
# For make all, it will compile only .c files in the SRC_DIR and LIB_DIR, 
# excluding files in the TEST_DIR. The output of compilation will be logged into build.log in LOG_DIR. 

# For make test, it will compile all the test files, run them, and log their
# outputs in separate log files named <test_name>_run.log. Any errors encountered during
# the compilation of test files will also be logged into separate log files named <test_name>_compilation.log.

# For make clean, it will delete the output binary and all .o files in the SRC_DIR.
# The make test_clean command will remove all compiled test binaries.

# variables
CC = gcc
CFLAGS = -g $(shell find ./src/libs -type d -exec echo -n "-I"{}" " \;)

SRC_DIR = ./src
LIB_DIR = ./src/libs
TEST_DIR = ./src/tests
LOG_DIR = ./src/logs

SRCS = $(shell find $(SRC_DIR) -name '*.c' ! -path "$(TEST_DIR)/*")
LIBS = $(shell find $(LIB_DIR) -name '*.c')
TESTS = $(shell find $(TEST_DIR) -name 'test_*.c')

OBJS = $(SRCS:.c=.o) $(LIBS:.c=.o)
TEST_BINS = $(TESTS:.c=.out)
OUTPUT = build-$(shell date +"%Y-%m-%d_%H-%M-%S").out

.PHONY: all
all: $(OUTPUT)

$(OUTPUT): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@ 2>$(LOG_DIR)/build.log

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@ 2>>$(LOG_DIR)/build.log

.PHONY: clean
clean:
	rm -f build-*.out
	find $(SRC_DIR) -name '*.o' -type f -delete
	find $(LOG_DIR) -name '*.log' -type f -delete

.PHONY: test
test: $(TEST_BINS)
	@for test in $^ ; do \
		echo "Running $$test"; \
		$$test || echo "ERROR $$test. Check logs for details."; \
	done

$(TEST_DIR)/%.out: $(TEST_DIR)/%.c
	$(eval LIBS_TO_INCLUDE=$(shell ./parse_includes.sh $< $(LIB_DIR)))
	@echo "Libraries to include: " $(LIBS_TO_INCLUDE)
	-$(CC) $(CFLAGS) $< $(LIBS_TO_INCLUDE) -o $@ 2>$(LOG_DIR)/$$(basename $@).log

.PHONY: test_clean
test_clean:
	rm -f $(TEST_BINS)
	find $(SRC_DIR) -name '*.o' -type f -delete
	find $(LOG_DIR) -name 'test_*.log' -type f -delete
