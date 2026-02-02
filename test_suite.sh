#!/bin/bash

# EpicCheck Test Suite
# Tests all rules with sample files

set -e

EPICCHECK="./epiccheck"
TEST_DIR="./test_files"
PASSED=0
FAILED=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🧪 EpicCheck Test Suite"
echo "======================="
echo ""

# Create test directory
rm -rf "$TEST_DIR"
mkdir -p "$TEST_DIR"

# ============================================================================
# Helper functions
# ============================================================================

test_rule() {
    local test_name="$1"
    local expected_exit="$2"
    local file="$3"
    
    echo -n "Testing $test_name... "
    
    if python3 "$EPICCHECK" "$file" > /dev/null 2>&1; then
        actual_exit=0
    else
        actual_exit=$?
    fi
    
    if [ "$actual_exit" -eq "$expected_exit" ]; then
        echo -e "${GREEN}✓ PASS${NC}"
        ((PASSED++))
    else
        echo -e "${RED}✗ FAIL${NC} (expected exit $expected_exit, got $actual_exit)"
        ((FAILED++))
    fi
}

# ============================================================================
# Test 1: Good file (should pass)
# ============================================================================

cat > "$TEST_DIR/good.c" << 'EOF'
/*
** EPITECH PROJECT, 2024
** EpicCheck
** File description:
** A perfectly compliant file
*/

#include <stdio.h>

int main(void)
{
    printf("Hello, world!\n");
    return 0;
}
EOF

test_rule "C-ALL: Compliant file" 0 "$TEST_DIR/good.c"

# ============================================================================
# Test 2: Missing header (C-G1)
# ============================================================================

cat > "$TEST_DIR/no_header.c" << 'EOF'
#include <stdio.h>

int main(void)
{
    return 0;
}
EOF

test_rule "C-G1: Missing header" 84 "$TEST_DIR/no_header.c"

# ============================================================================
# Test 3: Windows line endings (C-G6)
# ============================================================================

printf "/*\r\n** EPITECH PROJECT, 2024\r\n*/\r\n\r\nint main(void)\r\n{\r\n    return 0;\r\n}\r\n" > "$TEST_DIR/windows_lines.c"

test_rule "C-G6: Windows line endings" 84 "$TEST_DIR/windows_lines.c"

# ============================================================================
# Test 4: Trailing spaces (C-G7)
# ============================================================================

cat > "$TEST_DIR/trailing_spaces.c" << 'EOF'
/*
** EPITECH PROJECT, 2024
** Test
** File description:
** Trailing spaces test
*/

int main(void)   
{
    return 0;
}
EOF

test_rule "C-G7: Trailing spaces" 84 "$TEST_DIR/trailing_spaces.c"

# ============================================================================
# Test 5: Line too long (C-F3)
# ============================================================================

cat > "$TEST_DIR/long_line.c" << 'EOF'
/*
** EPITECH PROJECT, 2024
** Test
** File description:
** Long line test
*/

int main(void)
{
    printf("This is a very very very very very very very very long line that exceeds the limit\n");
    return 0;
}
EOF

test_rule "C-F3: Line too long" 84 "$TEST_DIR/long_line.c"

# ============================================================================
# Test 6: Tabs instead of spaces (C-L2)
# ============================================================================

printf "/*\n** EPITECH PROJECT, 2024\n** Test\n** File description:\n** Tab test\n*/\n\nint main(void)\n{\n\treturn 0;\n}\n" > "$TEST_DIR/tabs.c"

test_rule "C-L2: Tabs in indentation" 84 "$TEST_DIR/tabs.c"

# ============================================================================
# Test 7: goto statement (C-C3)
# ============================================================================

cat > "$TEST_DIR/goto.c" << 'EOF'
/*
** EPITECH PROJECT, 2024
** Test
** File description:
** goto test
*/

int main(void)
{
    goto error;
    return 0;

error:
    return 84;
}
EOF

test_rule "C-C3: goto forbidden" 84 "$TEST_DIR/goto.c"

# ============================================================================
# Test 8: Missing space after comma (C-L3)
# ============================================================================

cat > "$TEST_DIR/no_space_comma.c" << 'EOF'
/*
** EPITECH PROJECT, 2024
** Test
** File description:
** Space after comma test
*/

int add(int a,int b)
{
    return a + b;
}

int main(void)
{
    return 0;
}
EOF

test_rule "C-L3: Missing space after comma" 84 "$TEST_DIR/no_space_comma.c"

# ============================================================================
# Test 9: Function too long (C-F4)
# ============================================================================

cat > "$TEST_DIR/long_function.c" << 'EOF'
/*
** EPITECH PROJECT, 2024
** Test
** File description:
** Long function test
*/

int too_long(void)
{
    int a = 1;
    int b = 2;
    int c = 3;
    int d = 4;
    int e = 5;
    int f = 6;
    int g = 7;
    int h = 8;
    int i = 9;
    int j = 10;
    int k = 11;
    int l = 12;
    int m = 13;
    int n = 14;
    int o = 15;
    int p = 16;
    int q = 17;
    int r = 18;
    int s = 19;
    int t = 20;
    int u = 21;
    return u;
}
EOF

test_rule "C-F4: Function too long" 84 "$TEST_DIR/long_function.c"

# ============================================================================
# Test 10: No final newline (C-A3)
# ============================================================================

printf "/*\n** EPITECH PROJECT, 2024\n** Test\n** File description:\n** No newline test\n*/\n\nint main(void)\n{\n    return 0;\n}" > "$TEST_DIR/no_newline.c"

test_rule "C-A3: No final newline" 84 "$TEST_DIR/no_newline.c"

# ============================================================================
# Test 11: Makefile with header
# ============================================================================

cat > "$TEST_DIR/Makefile_good" << 'EOF'
##
## EPITECH PROJECT, 2024
## EpicCheck
## File description:
## A compliant Makefile
##

NAME = my_program

all: $(NAME)

$(NAME):
	gcc -o $(NAME) main.c

clean:
	rm -f $(NAME)
EOF

test_rule "Makefile: Compliant" 0 "$TEST_DIR/Makefile_good"

# ============================================================================
# Test 12: Makefile without header
# ============================================================================

cat > "$TEST_DIR/Makefile_bad" << 'EOF'
NAME = my_program

all: $(NAME)
EOF

test_rule "Makefile: Missing header" 84 "$TEST_DIR/Makefile_bad"

# ============================================================================
# Summary
# ============================================================================

echo ""
echo "======================="
echo "Test Results:"
echo -e "${GREEN}✓ Passed: $PASSED${NC}"
echo -e "${RED}✗ Failed: $FAILED${NC}"
echo "======================="

# Cleanup (optional - comment out to inspect test files)
# rm -rf "$TEST_DIR"
echo ""
echo "Test files are in: $TEST_DIR"

if [ "$FAILED" -eq 0 ]; then
    echo -e "\n${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "\n${RED}Some tests failed!${NC}"
    exit 1
fi
