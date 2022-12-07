package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
	"sort"
)

func main() {
	fmt.Println("Day 3")

	part1("./test_data.txt")
	part2("./test_data.txt")
}

func part2(filePath string) {
	fmt.Println("Part 2")
	// Read file
	rss, err := parseFile(filePath) // Rucksacks
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	// Divide rucksacks into Elf Groups of 3, Determine each groups badge, and calculate total priority
	rsgs := getRucksackGroups(rss) // Rucksack Groups
	tp := 0 // Total Priority

	for _, rsg := range rsgs {
		gb := findSharedGroupItems(rsg) // Group Badge
		tp =  tp + calculateSharedItemPriorities(gb)
	}

	fmt.Println(tp)
}

func findSharedGroupItems(rucksacks []string) []string {
	var gb []string // Group Badge

	// Sort rucksacks by total content lenght ASC because least full will have to be contained in the others
	sort.Slice(rucksacks, func(i, j int) bool {
		return rucksacks[i] < rucksacks[j]
  })

	lf := strings.Split(rucksacks[0],"") // Least full rucksack

	for _, it := range lf { // Item in rucksack
		if strings.Contains(rucksacks[1], it) && strings.Contains(rucksacks[2], it) && !slice_contains(gb, it){
			gb = append(gb, it)
		}
	}
	return gb
}

func getRucksackGroups(ruckSacks []string) map[int][]string {
	var rsgs = make(map[int][]string) // Rucksack Groups
	rsgid := 0 // Rucksack Group ID
	cgs := 0 // Current Group Size

	for _, rs := range ruckSacks {
		rsgs[rsgid] = append(rsgs[rsgid], rs)
		cgs = cgs + 1

		// If at max group size, index group id and reset current group size
		if cgs > 2 {
			rsgid = rsgid + 1
			cgs = 0
		}
	}
	return rsgs
}

func part1(filePath string) {
	fmt.Println("Part 1")
	// Read file
	rss, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	// Split Rucksacks and accumulate total priority of distint shared item types
	tp := 0

	for _, rucksack := range rss {
		cs := getRucksackCompartments(rucksack)
		sis := findSharedItems(cs)
		tp =  tp + calculateSharedItemPriorities(sis)
	}

	fmt.Println(tp)
}

func calculateSharedItemPriorities(sharedItems []string) int {
	ip := createItemPriorities() // Item Priority
	sip := 0 // Shared Item Priority

	for _, item := range sharedItems {
		sip = sip + ip[item]
	}

	return sip
}

func createItemPriorities() map[string]int {
	letters := []string{"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}

	var ips = make(map[string]int) // Item priorities
	for i, lt := range letters { // Letter
		ips[lt] = i + 1
		ips[strings.ToUpper(lt)] = i + 27
	}

	return ips
}

func findSharedItems(compartments []string) []string {
	var sis []string // Shared Items

	cis := strings.Split(compartments[0],"") // Compartment items shared
	for _, ci := range cis { // Compartment item
		if strings.Contains(compartments[1], ci) && !slice_contains(sis, ci) {
			sis = append(sis, ci)
		}
	}

	return sis
}

func slice_contains(s []string, str string) bool {
	for _, v := range s {
		if v == str {
			return true
		}
	}

	return false
}

func getRucksackCompartments(ruckSack string) []string {
	cs := len(ruckSack) / 2 // Compartment Size
	return []string{ruckSack[0:cs], ruckSack[cs:]}
}

func parseFile(filePath string) ([]string, error) {
	f, err := os.Open(filePath)

	if err != nil {
		return nil, err
	}

	var lines []string
	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	return lines, scanner.Err()
}