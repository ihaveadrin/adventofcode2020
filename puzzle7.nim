# https://adventofcode.com/2020/day/7
# --- Day 7: Handy Haversacks ---
# You land at the regional airport in time for your next flight. In fact, it looks like you'll even have time to grab some food: all flights are currently delayed due to issues in luggage processing.
# 
# Due to recent aviation regulations, many rules (your puzzle input) are being enforced about bags and their contents; bags must be color-coded and must contain specific quantities of other color-coded bags. Apparently, nobody responsible for these regulations considered how long they would take to enforce!
# 
# For example, consider the following rules:
# 
# light red bags contain 1 bright white bag, 2 muted yellow bags.
# dark orange bags contain 3 bright white bags, 4 muted yellow bags.
# bright white bags contain 1 shiny gold bag.
# muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
# shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
# dark olive bags contain 3 faded blue bags, 4 dotted black bags.
# vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
# faded blue bags contain no other bags.
# dotted black bags contain no other bags.
# These rules specify the required contents for 9 bag types. In this example, every faded blue bag is empty, every vibrant plum bag contains 11 bags (5 faded blue and 6 dotted black), and so on.
# 
# You have a shiny gold bag. If you wanted to carry it in at least one other bag, how many different bag colors would be valid for the outermost bag? (In other words: how many colors can, eventually, contain at least one shiny gold bag?)
# 
# In the above rules, the following options would be available to you:
# 
# A bright white bag, which can hold your shiny gold bag directly.
# A muted yellow bag, which can hold your shiny gold bag directly, plus some other bags.
# A dark orange bag, which can hold bright white and muted yellow bags, either of which could then hold your shiny gold bag.
# A light red bag, which can hold bright white and muted yellow bags, either of which could then hold your shiny gold bag.
# So, in this example, the number of bag colors that can eventually contain at least one shiny gold bag is 4.
# 
# How many bag colors can eventually contain at least one shiny gold bag? (The list of rules is quite long; make sure you get all of it.)

import strutils, tables, sequtils

type
  SubColour = tuple[quantity: int, name: string, id: int]
  Colour = tuple[name: string, mayContainGold: int, bag_contained: seq[SubColour], bag_contained_ids: seq[int]]
# mayContainGold is a flag: 0 "not processed", 1 "may contain a gold shiny bag", 2 "can't contain a gold shiny bag"

var s = readFile("puzzle/puzzle7.txt").strip().splitLines()
var lookup_colours = initTable[string, int]()
var colours: seq[Colour]
var colour: string
var subcols: seq[string]
var tmp: seq[string]
var n = 0
var subcolname: string
var i = 0
var table_last = -1
var pattern = "shiny gold"
var containers: seq[string]
var containers_id: seq[int]
var first_loop = true
var gld = 0


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

        colours[table_last].bag_contained.add((quantity: n, name: subcolname, id: 0))

        if subcolname == pattern: 
            colours[table_last].mayContainGold = 1
            containers.add(subcolname)

for cont in containers:
    containers_id.add(lookup_colours[cont])

for k, v in colours:
    for it, b in v.bag_contained:
      let subcolorname = colours[k].bag_contained[it].name
      let subcolorid = lookup_colours[subcolorname]
      # echo "sub color: ", subcolorname, " ", subcolorid
      colours[k].bag_contained[it].id = subcolorid
      colours[k].bag_contained_ids.add(subcolorid)
      # if equals pattern, set every child to 2
      if colours[k].name == pattern:
          colours[subcolorid].mayContainGold = 2
    
i = 1
while i > 0:
    if not first_loop: i = 0
    for k, v in colours:
        if v.mayContainGold == 0:
            for id in v.bag_contained_ids:
                if colours[id].mayContainGold == 1:
                    i += 1
                    colours[k].mayContainGold = 1
    if first_loop:
        if i == 1: i = 0

    first_loop = false


# echo lookup_colours["shiny gold"]
# echo colours

i = 0
for k, v in colours:
    if v.mayContainGold == 1: i += 1

echo "number of bags which can contain: ", i





# vi: expandtab ts=2
