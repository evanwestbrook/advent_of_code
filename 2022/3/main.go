package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
)

func main() {
	fmt.Println("Day 3")

	//part1("./test_data.txt")
	part2("./test_data.txt")
}

func part2(filePath string) {
	fmt.Println("Part 2")
	// Read file
	rss, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	rsgs := getRucksackGroups(rss)
	fmt.Println(rsgs)

	for _, rsg := range rsgs {
		fmt.Println(rsg)
	}
}

func getRucksackGroups(ruckSacks []string) map[int][]string {
	var rsgs = make(map[int][]string)
	rsgid := 0
	cgs := 0

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
	ip := createItemPriorities()
	sip := 0

	for _, item := range sharedItems {
		sip = sip + ip[item]
	}

	return sip
}

func createItemPriorities() map[string]int {
	letters := []string{"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}

	var ips = make(map[string]int)
	for i, letter := range letters {
		ips[letter] = i + 1
		ips[strings.ToUpper(letter)] = i + 27
	}

	return ips
}

func findSharedItems(compartments []string) []string {
	var sis []string

	cis := strings.Split(compartments[0],"")
	for _, ci := range cis {
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
	cs := len(ruckSack) / 2
	return []string{ruckSack[0:cs], ruckSack[cs:len(ruckSack)]}
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