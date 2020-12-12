# https://adventofcode.com/2020/day/11
# --- Part Two ---
# As soon as people start to arrive, you realize your mistake. People don't just care about adjacent seats - they care about the first seat they can see in each of those eight directions!
# 
# Now, instead of considering just the eight immediately adjacent seats, consider the first seat in each of those eight directions. For example, the empty seat below would see eight occupied seats:
# 
# .......#.
# ...#.....
# .#.......
# .........
# ..#L....#
# ....#....
# .........
# #........
# ...#.....
# The leftmost empty seat below would only see one empty seat, but cannot see any of the occupied ones:
# 
# .............
# .L.L.#.#.#.#.
# .............
# The empty seat below would see no occupied seats:
# 
# .##.##.
# #.#.#.#
# ##...##
# ...L...
# ##...##
# #.#.#.#
# .##.##.
# Also, people seem to be more tolerant than you expected: it now takes five or more visible occupied seats for an occupied seat to become empty (rather than four or more from the previous rules). The other rules still apply: empty seats that see no occupied seats become occupied, seats matching no rule don't change, and floor never changes.
# 
# Given the same starting layout as above, these new rules cause the seating area to shift around as follows:
# 
# L.LL.LL.LL
# LLLLLLL.LL
# L.L.L..L..
# LLLL.LL.LL
# L.LL.LL.LL
# L.LLLLL.LL
# ..L.L.....
# LLLLLLLLLL
# L.LLLLLL.L
# L.LLLLL.LL
# #.##.##.##
# #######.##
# #.#.#..#..
# ####.##.##
# #.##.##.##
# #.#####.##
# ..#.#.....
# ##########
# #.######.#
# #.#####.##
# #.LL.LL.L#
# #LLLLLL.LL
# L.L.L..L..
# LLLL.LL.LL
# L.LL.LL.LL
# L.LLLLL.LL
# ..L.L.....
# LLLLLLLLL#
# #.LLLLLL.L
# #.LLLLL.L#
# #.L#.##.L#
# #L#####.LL
# L.#.#..#..
# ##L#.##.##
# #.##.#L.##
# #.#####.#L
# ..#.#.....
# LLL####LL#
# #.L#####.L
# #.L####.L#
# #.L#.L#.L#
# #LLLLLL.LL
# L.L.L..#..
# ##LL.LL.L#
# L.LL.LL.L#
# #.LLLLL.LL
# ..L.L.....
# LLLLLLLLL#
# #.LLLLL#.L
# #.L#LL#.L#
# #.L#.L#.L#
# #LLLLLL.LL
# L.L.L..#..
# ##L#.#L.L#
# L.L#.#L.L#
# #.L####.LL
# ..#.#.....
# LLL###LLL#
# #.LLLLL#.L
# #.L#LL#.L#
# #.L#.L#.L#
# #LLLLLL.LL
# L.L.L..#..
# ##L#.#L.L#
# L.L#.LL.L#
# #.LLLL#.LL
# ..#.L.....
# LLL###LLL#
# #.LLLLL#.L
# #.L#LL#.L#
# Again, at this point, people stop shifting around and the seating area reaches equilibrium. Once this occurs, you count 26 occupied seats.
# 
# Given the new visibility method and the rule change for occupied seats becoming empty, once equilibrium is reached, how many seats end up occupied?
import strutils, sequtils, algorithm

var s = readFile("puzzle/puzzle11.txt").strip().splitLines()
var clone = s
var symbols = @['L', '#', '.']
var
    minco: int
    maxco: int
    scan_began = false
    lastRow = len(s) - 1
    lastCol = len(s[0]) - 1
    prevs = s.join("\n")
    curs = ""
var occu = 0


proc toggle_seat(row: int, column: int): bool {.discardable.} =
    result = true
    var iterators = @[
        @[-1, -1], @[-1, 0], @[-1, 1],
        @[0, -1],       @[0, 1],
        @[1, -1], @[1, 0], @[1, 1]
    ]
    var around = ""
    var irow = 0
    var icol = 0
    if(s[row][column] != '.'):
        for it in iterators:
            irow = row + it[0]
            icol = column + it[1]
            while irow >= 0 and irow <= lastRow and icol >= 0 and icol <= lastCol:
                if s[irow][icol] != '.': break
                irow += it[0]
                icol += it[1]
            if irow >= 0 and icol >= 0 and irow < len(s) and icol < len(s[irow]): 
                around = around & s[irow][icol]
            else: around = around & '.'

        let c = count(around, '#')
        if c == 0 and s[row][column] == 'L': clone[row][column] = '#'
        elif c >= 5 and s[row][column] == '#': clone[row][column] = 'L'
    


var n = 0
while prevs != curs:
    if len(curs) > 0: prevs = curs
    for row, l in s:
        for col, c in l:
            toggle_seat(row, col)
    curs = clone.join("\n")
    s = clone
    n += 1

echo n

for row, l in s:
    occu += count(l, '#')
 
echo "Seats occupied ", occu

    

# vi: expandtab ts=4
