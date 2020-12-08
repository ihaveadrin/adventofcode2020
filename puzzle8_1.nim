# https://adventofcode.com/2020/day/8
# --- Part Two ---
# After some careful analysis, you believe that exactly one instruction is corrupted.
# 
# Somewhere in the program, either a jmp is supposed to be a nop, or a nop is supposed to be a jmp. (No acc instructions were harmed in the corruption of this boot code.)
# 
# The program is supposed to terminate by attempting to execute an instruction immediately after the last instruction in the file. By changing exactly one jmp or nop, you can repair the boot code and make it terminate correctly.
# 
# For example, consider the same program from above:
# 
# nop +0
# acc +1
# jmp +4
# acc +3
# jmp -3
# acc -99
# acc +1
# jmp -4
# acc +6
# If you change the first instruction from nop +0 to jmp +0, it would create a single-instruction infinite loop, never leaving that instruction. If you change almost any of the jmp instructions, the program will still eventually find another jmp instruction and loop forever.
# 
# However, if you change the second-to-last instruction (from jmp -4 to nop -4), the program terminates! The instructions are visited in this order:
# 
# nop +0  | 1
# acc +1  | 2
# jmp +4  | 3
# acc +3  |
# jmp -3  |
# acc -99 |
# acc +1  | 4
# nop -4  | 5
# acc +6  | 6
# After the last instruction (acc +6), the program terminates by attempting to run the instruction below the last instruction in the file. With this change, after the program terminates, the accumulator contains the value 8 (acc +1, acc +1, acc +6).
# 
# Fix the program so that it terminates normally by changing exactly one jmp (to nop) or nop (to jmp). What is the value of the accumulator after the program terminates?
import strutils, tables, random, times

type Instruction = tuple[i_id: int, val: int, times: int]

var s = readFile("puzzle/puzzle8.txt").strip().splitLines()
var lookup = {"nop": 0, "acc": 1, "jmp": 2}.toTable
var instructions = @["nop", "acc", "jmp"]
var ilen = 0
var stack: seq[Instruction]
var stackit = 0
var step = 0
var accumulator = 0
var id = 0
var value = 0
var tmp: seq[string]
var exe = 0
var jmp_list: seq[int]
var el_seen: seq[int]

for line in s:
    tmp = line.split(" ")
    id = lookup[tmp[0]]
    value = parseInt(tmp[1])
    stack.add((i_id: id, val: value, times: 0))
    if(id == lookup["jmp"]): jmp_list.add(stackit)

    stackit += 1

ilen = len(stack)

block tester:
    let ts = getTime()
    randomize(ts.toUnix())
    shuffle(jmp_list)
    for jx in jmp_list:
        accumulator = 0
        stack[jx].i_id = lookup["nop"]
        step = 0

        while step < ilen:
            echo exe, ": ", step, " > ", instructions[stack[step].i_id], " ", stack[step].val, " -- ", stack[step].times
            if stack[step].times == 1: 
                echo "prevented infinite loop"
                step = ilen + 1000
            else:
                el_seen.add(step)
                stack[step].times += 1
                if stack[step].i_id != lookup["jmp"]: 
                    if stack[step].i_id == lookup["acc"]: accumulator += stack[step].val
                    step += 1
                else: 
                    step += stack[step].val

                exe += 1
                
        if step > ilen:
            stack[jx].i_id = lookup["jmp"]
            for se in el_seen:
                stack[se].times = 0
        elif step == ilen:
            echo "accumulator value at program termination: ", accumulator
            break tester

    echo "program always in infinite loop?"

# vi: expandtab ts=2
