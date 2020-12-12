# https://adventofcode.com/2020/day/11
# --- Day 11: Seating System ---
# Your plane lands with plenty of time to spare. The final leg of your journey is a ferry that goes directly to the tropical island where you can finally start your vacation. As you reach the waiting area to board the ferry, you realize you're so early, nobody else has even arrived yet!
# 
# By modeling the process people use to choose (or abandon) their seat in the waiting area, you're pretty sure you can predict the best place to sit. You make a quick map of the seat layout (your puzzle input).
# 
# The seat layout fits neatly on a grid. Each position is either floor (.), an empty seat (L), or an occupied seat (#). For example, the initial seat layout might look like this:
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
# Now, you just need to model the people who will be arriving shortly. Fortunately, people are entirely predictable and always follow a simple set of rules. All decisions are based on the number of occupied seats adjacent to a given seat (one of the eight positions immediately up, down, left, right, or diagonal from the seat). The following rules are applied to every seat simultaneously:
# 
# If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
# If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
# Otherwise, the seat's state does not change.
# Floor (.) never changes; seats don't move, and nobody sits on the floor.
# 
# After one round of these rules, every seat in the example layout becomes occupied:
# 
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
# After a second round, the seats with four or more occupied adjacent seats become empty again:
# 
# #.LL.L#.##
# #LLLLLL.L#
# L.L.L..L..
# #LLL.LL.L#
# #.LL.LL.LL
# #.LLLL#.##
# ..L.L.....
# #LLLLLLLL#
# #.LLLLLL.L
# #.#LLLL.##
# This process continues for three more rounds:
# 
# #.##.L#.##
# #L###LL.L#
# L.#.#..#..
# #L##.##.L#
# #.##.LL.LL
# #.###L#.##
# ..#.#.....
# #L######L#
# #.LL###L.L
# #.#L###.##
# #.#L.L#.##
# #LLL#LL.L#
# L.L.L..#..
# #LLL.##.L#
# #.LL.LL.LL
# #.LL#L#.##
# ..L.L.....
# #L#LLLL#L#
# #.LLLLLL.L
# #.#L#L#.##
# #.#L.L#.##
# #LLL#LL.L#
# L.#.L..#..
# #L##.##.L#
# #.#L.LL.LL
# #.#L#L#.##
# ..L.L.....
# #L#L##L#L#
# #.LLLLLL.L
# #.#L#L#.##
# At this point, something interesting happens: the chaos stabilizes and further applications of these rules cause no seats to change state! Once people stop moving around, you count 37 occupied seats.
# 
# Simulate your seating area by applying the seating rules repeatedly until no seats change state. How many seats end up occupied?
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
    var rowpos = @[0, row]
    var colpos = @[0, column]
    var around = ""
    if row > 0: rowpos[0] = row - 1
    
    if row < lastRow: rowpos[1] = row + 1

    if column > 0: colpos[0] = column - 1

    if column < lastCol: colpos[1] = column + 1

    for ir in rowpos[0]..rowpos[1]:
        for ic in colpos[0]..colpos[1]:
            if not (ir == row and ic == column): 
                around = around & s[ir][ic]

    let c = count(around, '#')
    if(s[row][column] != '.'):
        if c == 0 and s[row][column] == 'L': clone[row][column] = '#'
        elif c >= 4 and s[row][column] == '#': clone[row][column] = 'L'
    


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
