package main

import (
	"fmt"
	_ "fmt"
	"math"
	"math/rand"
	"os"
)

type Point struct {
	X int
	Y int
}


type Walker struct {
	curr_pos Point
	init_pos Point
}


var choices []int = []int {-1, 1};

func getDir() int {
	return choices[rand.Intn(len(choices))];
}

func createMatrix(n int) [][]int {
	matrix := make([][]int, n)
    for i := range matrix {
        matrix[i] = make([]int, n)
    }

	return matrix
}

func createPosMatrix(lines int, rows int) [][]Point {
	matrix := make([][]Point, lines);
	
	for i := range matrix {
		matrix[i] = make([]Point, rows);
	}

	return matrix;
}


func getRandInt(a int, b int) int {
	return rand.Intn(b-a) + a
}


func main() {
	var walkers []Walker;
	var num_walkers int = 10000
	var n = 100;
	var limite = 1000
	var m [][]int = createMatrix(n);
	var marcacoes = limite / 10;
	var pos_tempo = createPosMatrix(num_walkers, marcacoes)
	var pontos []float64 = make([]float64, marcacoes)

	for i := 0 ; i < num_walkers ; i++ {
		x := getRandInt(0, n-1)
		y := getRandInt(0, n-1);

		pos := Point{X: x, Y: y}

		walkers = append(walkers, Walker{
			curr_pos: pos,
			init_pos: pos,
		})
	}

	for i := 0; i < limite; i++ {

		for j, _ := range walkers {

			walker := &walkers[j]

			dir := getDir()

			if dir == 1{
				x_dir := getDir()

				if walker.curr_pos.X + x_dir > 0 && walker.curr_pos.X + x_dir < n {
					if m[walker.curr_pos.X + x_dir][walker.curr_pos.Y] == 0 {
						walker.curr_pos.X += x_dir
					}
				}

			} else {
				y_dir := getDir()

				if walker.curr_pos.Y + y_dir > 0 && walker.curr_pos.Y + y_dir < n {
					if m[walker.curr_pos.X][walker.curr_pos.Y] == 0 {
						walker.curr_pos.Y += y_dir
					}
				}
			}

			if i % 10 == 0 {
				index := i / 10
				pos_tempo[j][index] = walker.curr_pos
			}
		}
		
		if i % 10 == 0 {
			index := i / 10
			var soma_dist float64 = 0

			for _, walker := range walkers {

				x_dist := math.Pow(math.Abs(float64(walker.curr_pos.X) - float64(walker.init_pos.X)), 2);
				y_dist := math.Pow(math.Abs(float64(walker.curr_pos.Y) - float64(walker.init_pos.Y)), 2);

				soma_dist += math.Sqrt(x_dist + y_dist)
			}

			media_dist := soma_dist / float64(num_walkers)

			p := float64(i)
			if p == 0 {
				p += 0.0001;
			}
			pontos[index] = media_dist / float64(p)
		}

		fmt.Printf("fim da iter: %d\n", i);

	}

	// === Save pos_tempo to file ===
	// 10 walkers, 10 marcacoes
	filePos, err := os.Create("pos_tempo.txt")
	if err != nil {
		panic(err)
	}
	defer filePos.Close()

	for i := 0; i < len(pos_tempo); i++ {
		for j := 0; j < len(pos_tempo[i]); j++ {
			fmt.Fprintf(filePos, "(%d,%d) ", pos_tempo[i][j].X, pos_tempo[i][j].Y)
		}
		fmt.Fprintln(filePos)
	}

	// === Save pontos to file ===
	// 10 linhas
	filePontos, err := os.Create("pontos.txt")
	if err != nil {
		panic(err)
	}
	defer filePontos.Close()

	for _, p := range pontos {
		fmt.Fprintln(filePontos, p)
	}

	fmt.Println("Files saved: pos_tempo.txt and pontos.txt")
}