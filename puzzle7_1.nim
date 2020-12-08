# https://adventofcode.com/2020/day/7
# --- Part Two ---
# It's getting pretty expensive to fly these days - not because of ticket prices, but because of the ridiculous number of bags you need to buy!
# 
# Consider again your shiny gold bag and the rules from the above example:
# 
# faded blue bags contain 0 other bags.
# dotted black bags contain 0 other bags.
# vibrant plum bags contain 11 other bags: 5 faded blue bags and 6 dotted black bags.
# dark olive bags contain 7 other bags: 3 faded blue bags and 4 dotted black bags.
# So, a single shiny gold bag must contain 1 dark olive bag (and the 7 bags within it) plus 2 vibrant plum bags (and the 11 bags within each of those): 1 + 1*7 + 2 + 2*11 = 32 bags!
# 
# Of course, the actual rules have a small chance of going several levels deeper than this example; be sure to count all of the bags, even if the nesting becomes topologically impractical!
# 
# Here's another example:
# 
# shiny gold bags contain 2 dark red bags.
# dark red bags contain 2 dark orange bags.
# dark orange bags contain 2 dark yellow bags.
# dark yellow bags contain 2 dark green bags.
# dark green bags contain 2 dark blue bags.
# dark blue bags contain 2 dark violet bags.
# dark violet bags contain no other bags.
# In this example, a single shiny gold bag must contain 126 other bags.
# 
# How many individual bags are required inside your single shiny gold bag?

import strutils, streams, tables, sequtils

type
  SubColour = tuple[quantity: int, name: string, id: int]
  Colour = tuple[name: string, mayContainGold: int, bag_contained: seq[SubColour], bag_contained_ids: seq[int]]
# mayContainGold is a flag: 0 "not processed", 1 "may contain a gold shiny bag", 2 "can't contain a gold shiny bag"

var s = readFile("puzzle/puzzle7.txt").strip().splitLines()
var lookup_colours = initTable[string, int]()
var colours: seq[Colour]
var part: seq[Colour]
var colour: string
var subcols: seq[string]
var tmp: seq[string]
var n = 0
var subcolname: string
var i = 0
var j = 0
var found = false
var sum = 0
var sub = 0
var multiplied = 0
var min = 0
var max = 0
var needle = ""
var valid = 0
var table_last = -1
var pattern = "shiny gold"
var id_pattern = 0
var containers: seq[string]
var containers_id: seq[int]
var new_containers_id: seq[int]
var rem: seq[int]
var processed = 0
var first_loop = true
var gld = 0
var total = 0

proc quantize(q: int, id: int): int =
  result = q
  var quantities = 0
  if len(colours[id].bag_contained) > 0:
      for b in colours[id].bag_contained:
          quantities += quantize(b.quantity, b.id)
      if quantities > 0: result = q + ( q * quantities )

for line in s:
    gld = 0
    let subject = line.replace(".").replace(" bags").replace(" bag").split(" contain ")
    colour = subject[0]
    subcols = subject[1].split(",")
    table_last += 1
    if colour == pattern: gld = 2
    lookup_colours[colour] = table_last
    colours.add((name: colour, mayContainGold: gld, bag_contained: @[], bag_contained_ids: @[]))
    for sc in subcols:
        if sc == "no other": continue
        tmp = sc.split(" ")
        keepIf(tmp, proc(s: string): bool = s != "")
        n = parseInt(tmp[0])
        subcolname = tmp[1] & " " & tmp[2]

        colours[table_last].bag_contained.add((quantity: n, name: subcolname, id: -1))

        if subcolname == pattern: 
            colours[table_last].mayContainGold = 1
            containers.add(subcolname)

for cont in containers:
    containers_id.add(lookup_colours[cont])

for k, v in colours:
    for it, b in v.bag_contained:
      let subcolorname = colours[k].bag_contained[it].name
      let subcolorid = lookup_colours[subcolorname]
      colours[k].bag_contained[it].id = subcolorid
      colours[k].bag_contained_ids.add(subcolorid)
    
echo "Quantity of bags: ", quantize(1, lookup_colours[pattern]) - 1

# vi: expandtab ts=2
