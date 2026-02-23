"""
Accurate Pico-8 token counter.
Rules from https://pico-8.fandom.com/wiki/Tokens:

TOKENS (each counts as 1):
  - identifiers / variable names
  - keywords EXCEPT 'end' and 'local'
  - number literals
  - string literals (any size = 1 token)
  - operators: + - * / % ^ # & | ~ << >> == ~= < > <= >= .. ... = not and or
  - opening brackets: ( [ {
  - unary minus/complement only counts if NOT directly before a number literal
    (i.e. -3 = 1 token, but -x = 2 tokens)

NOT TOKENS (free):
  - end, local
  - closing brackets: ) ] }
  - comma ,  semicolon ;  period .  colon :  double-colon ::
  - comments (-- or //)
  - whitespace
"""

import re, os

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MAIN = os.path.join(BASE, "halloweenleo.p8")

INCLUDE_ORDER = [
    r"entities\entity.lua",
    r"entities\bats.lua",
    r"entities\leo.lua",
    r"scenes\l01s01.lua",
    r"scenes\gameover.lua",
    r"scripts\afterburner.lua",
    r"scripts\bullets.lua",
    r"scripts\clouds.lua",
    r"scripts\debugging.lua",
    r"scripts\starfield.lua",
    r"scripts\leo_gfx.lua",
    r"entities\gravestone.lua",
    r"tools\contains.lua",
    r"tools\tableconcat.lua",
    r"entities\pumpkin.lua",
    r"scripts\collision.lua",
    r"scripts\blink_enemy.lua",
    r"entities\explosions.lua",
    r"entities\orby.lua",
    r"entities\auditron.lua",
    r"entities\heart.lua",
    r"entities\egg.lua",
    r"entities\bunny.lua",
    r"entities\chick.lua",
    r"entities\ponzibunny.lua",
    r"scenes\l02s01.lua",
]

FREE_KEYWORDS = {"end", "local"}

KEYWORDS = {
    "and","break","do","else","elseif","false","for","function",
    "goto","if","in","nil","not","or","repeat","return","then",
    "true","until","while"
}

# single and multi-char operators that cost tokens
# note: . and : and , are free; .. counts as 1 token; ... counts as 1 token
OPERATORS = {
    "...", "..", "==", "~=", "<=", ">=", "<<", ">>",
    "+", "-", "*", "/", "%", "^", "#", "&", "|", "~",
    "<", ">", "=", "("  , "[", "{"
}

def strip_comments(line):
    """Remove -- and // comments, respecting strings."""
    result = []
    i = 0
    in_str = False
    sc = None
    while i < len(line):
        c = line[i]
        if in_str:
            result.append(c)
            if c == '\\':
                i += 1
                if i < len(line):
                    result.append(line[i])
            elif c == sc:
                in_str = False
        else:
            if c in ('"', "'"):
                in_str = True
                sc = c
                result.append(c)
            elif line[i:i+2] in ('--', '//'):
                break
            else:
                result.append(c)
        i += 1
    return ''.join(result)

def tokenise(src):
    """Yield (token_type, value) from Pico-8 Lua source.
    token_type: 'ident', 'number', 'string', 'op', 'free'
    """
    lines = src.split('\n')
    cleaned = '\n'.join(strip_comments(l) for l in lines)

    i = 0
    s = cleaned
    n = len(s)
    prev_token = None  # track for unary-minus-before-number rule

    while i < n:
        c = s[i]

        # whitespace
        if c in ' \t\n\r':
            i += 1
            continue

        # string literal
        if c in ('"', "'"):
            j = i + 1
            while j < n and s[j] != c:
                if s[j] == '\\':
                    j += 1
                j += 1
            yield ('string', s[i:j+1])
            prev_token = 'string'
            i = j + 1
            continue

        # number literal (hex, decimal, binary 0b...)
        if c.isdigit() or (c == '0' and i+1 < n and s[i+1] in ('x','b','X','B')):
            j = i
            while j < n and (s[j].isalnum() or s[j] in '.xXbBpP_'):
                j += 1
            yield ('number', s[i:j])
            prev_token = 'number'
            i = j
            continue

        # identifier or keyword
        if c.isalpha() or c == '_':
            j = i
            while j < n and (s[j].isalnum() or s[j] == '_'):
                j += 1
            word = s[i:j]
            if word in FREE_KEYWORDS:
                yield ('free', word)
            elif word in KEYWORDS:
                yield ('keyword', word)
            else:
                yield ('ident', word)
            prev_token = word
            i = j
            continue

        # multi-char operators first
        matched = False
        for op in ["...", "..", "==", "~=", "<=", ">=", "<<", ">>"]:
            if s[i:i+len(op)] == op:
                yield ('op', op)
                prev_token = op
                i += len(op)
                matched = True
                break
        if matched:
            continue

        # free punctuation: ) ] } , ; . :
        if c in ')]},;.:':
            yield ('free', c)
            prev_token = c
            i += 1
            continue

        # opening brackets - token
        if c in '([{':
            yield ('op', c)
            prev_token = c
            i += 1
            continue

        # minus: free if followed by digit and previous token makes it unary
        # (i.e. after = ( , [ { operator keyword — not after ident/number/)/])
        if c == '-':
            # peek ahead for digit
            j = i + 1
            while j < n and s[j] == ' ':
                j += 1
            next_is_num = j < n and (s[j].isdigit() or s[j] == '0')
            unary_context = prev_token in (None, '=', '(', '[', '{', ',', ';',
                                           'return', 'and', 'or', 'not', 'if',
                                           'elseif', 'while', 'until', 'then')
            if next_is_num and unary_context:
                # consume the whole negative number as 1 token
                j2 = j
                while j2 < n and (s[j2].isalnum() or s[j2] in '.xXbBpP_'):
                    j2 += 1
                yield ('number', s[i:j2])
                prev_token = 'number'
                i = j2
            else:
                yield ('op', '-')
                prev_token = '-'
                i += 1
            continue

        # tilde: complement — same rule as minus when before number
        if c == '~':
            j = i + 1
            while j < n and s[j] == ' ':
                j += 1
            next_is_num = j < n and s[j].isdigit()
            unary_context = prev_token in (None, '=', '(', '[', '{', ',', ';',
                                           'return', 'and', 'or', 'not', 'if',
                                           'elseif', 'while', 'until', 'then')
            if next_is_num and unary_context:
                j2 = j
                while j2 < n and (s[j2].isalnum() or s[j2] in '.xXbBpP_'):
                    j2 += 1
                yield ('number', s[i:j2])
                prev_token = 'number'
                i = j2
            else:
                yield ('op', '~')
                prev_token = '~'
                i += 1
            continue

        # remaining single-char operators
        if c in '+-*/%^#&|<>=':
            yield ('op', c)
            prev_token = c
            i += 1
            continue

        # skip anything else
        i += 1

def count_file_tokens(path):
    with open(path, encoding='utf-8') as f:
        src = f.read()
    total = 0
    for ttype, val in tokenise(src):
        if ttype != 'free':
            total += 1
    return total

def main():
    # Read inline lua from main cart
    with open(MAIN, encoding='utf-8') as f:
        main_src = f.read()
    import re as re2
    lua_block = re2.search(r'__lua__(.*?)(?:__gfx__|$)', main_src, re2.DOTALL)
    lua_body = lua_block.group(1) if lua_block else ""
    inline_lua = re2.sub(r'^#include[^\n]*\n?', '', lua_body, flags=re2.MULTILINE)

    grand_total = 0
    print(f"{'file':<40} {'tokens':>7}")
    print("-" * 50)

    for rel in INCLUDE_ORDER:
        path = os.path.join(BASE, rel)
        if os.path.exists(path):
            c = count_file_tokens(path)
            grand_total += c
            print(f"{rel:<40} {c:>7}")

    # inline lua
    inline_count = sum(1 for ttype, _ in tokenise(inline_lua) if ttype != 'free')
    grand_total += inline_count
    print(f"{'(main cart inline)':<40} {inline_count:>7}")
    print("-" * 50)
    print(f"{'TOTAL':<40} {grand_total:>7}")
    print(f"LIMIT:                                   8192")
    print(f"REMAINING:                               {8192 - grand_total}")

if __name__ == "__main__":
    main()
