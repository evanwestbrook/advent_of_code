package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	fmt.Println("Day 9")
	part1("./test.txt")
}

type Move struct {
	direction string
	steps int
}

func part1(filePath string) {
	fmt.Println("Part 1")
	// Read file
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	fmt.Println(getMove(lines[0]))
}

func getMove(line string) Move{
	splitLine := strings.Split(line," ")
	dir := splitLine[0]
	steps, _ := strconv.Atoi(splitLine[1])

	return Move{dir, steps}
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
