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

type Rope struct {
	headPosition []int
	tailPosition []int
}

func part1(filePath string) {
	fmt.Println("Part 1")
	// Read file
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	rope := Rope{headPosition: []int{0,0}, tailPosition: []int{0,0}}

	fmt.Println(getMove(lines[0]))

	moveRope(&rope)

}

func moveRope(r *Rope) {
	fmt.Println(r)
	r.headPosition[0] = 1
	fmt.Println(r)
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
