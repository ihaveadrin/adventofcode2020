import strutils
import streams
import lists

type Bullet = array[26, int]
var s = readFile("puzzle/puzzle6.txt").strip().splitLines()
var n = 0
var i = 0
var j = 0
var arch = initSinglyLinkedList[int]()
var found = false
var sum = 0
var sub = 0
var multiplied = 0
var min = 0
var max = 0
var limit_password: seq[string]
var limit_part: seq[string]
var limit: seq[string]
var needle = ""
var password = ""
var password_map: seq[string]
var valid = 0
let alphabet = "abcdefghijklmnopqrstuvwxyz"
var group_answers: seq[string]
var group_members: seq[int]
var group_answers_count: seq[Bullet]

proc load_bullet(): Bullet = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

group_answers.add("")
group_members.add(0)
group_answers_count.add(load_bullet())

for line in s:
    if line == "":
        group_answers.add("")
        group_members.add(0)
        group_answers_count.add(load_bullet())
        i += 1
    else:
        group_members[i] += 1
        for c in line:
            let idx = find(alphabet, c)
            group_answers_count[i][idx] += 1
            group_answers[i] = group_answers[i] & $c

for it, group in group_members:
    for lit, letter in group_answers_count[it]:
        if letter == group: sum += 1

echo "Totale: ", sum

# vi: expandtab ts=2
