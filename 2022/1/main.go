package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

func main() {
	fmt.Println("Day 1")

	lines, err := parseFile("./test_data.txt")
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	fmt.Println(lines)

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
