import strutils
import streams
import lists

var s = readFile("puzzle/puzzle4.txt").strip().splitLines()
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


for line in s:

# vi: expandtab ts=2
