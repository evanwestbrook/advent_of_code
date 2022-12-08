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
	// Used this person's solution for a lot of help
	// https://www.reddit.com/r/adventofcode/comments/zesk40/comment/izbm1mc/?utm_source=share&utm_medium=web2x&context=3
	fmt.Println("Day 7")

	part1("./test_data.txt")
}

func part1(filePath string) {
	fmt.Println("Part 1")
	// Read file
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	fmt.Println(findLargestDir(lines))
}

func findLargestDir(lines []string) int64 {
	var stack []int64 // Stack of directory sizes
	var sum int64 // Total sum of directory sizes

	// Data output is already DFS, so we just have to parse thorugh with keywords
	for _, line := range lines {
		switch line := line; line[:4] { // First 4 chars in a line will always be a command if there is one
		case "$ cd":
			if line[5:] != ".." { // Content after the cd command isn't going out of directory
				stack = append(stack, 0) // cd into new directory
				continue
			}

			// if command is .. cd out of directory and compute directory size
			dirSize := stack[len(stack) - 1]
			if dirSize <= 100000 {
				sum += dirSize
			}

			// If stack contains a file, add its directory size to the parent stack
			if stack = stack[:len(stack)-1]; len(stack) > 0 {
				stack[len(stack) - 1] += dirSize
			}
		case "$ ls", "dir ": // Nothing to do, next line
		default: //file
			fs := strings.Fields(line)
			fileSize, _ := strconv.ParseInt(fs[0], 10, 64)
			stack[len(stack)-1] += fileSize
		}
	}

	return sum
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
