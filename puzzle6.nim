import strutils
import streams
import lists

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
var group_answers_count: seq[int]


group_answers.add("")
group_answers_count.add(0)

for line in s:
    if line == "":
        group_answers.add("")
        group_answers_count.add(0)
        i += 1
    else:
        for c in line:
            if count(group_answers[i], c) == 0:
                group_answers_count[i] += 1
                group_answers[i] = group_answers[i] & $c

for count in group_answers_count:
    sum += count

echo "Totale: ", sum

# vi: expandtab ts=2
