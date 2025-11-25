import pygame
from Cell import Cell
import math
from datetime import datetime

WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

class Matrix:
    def __init__(
            self, 
            width: int, 
            height: int, screen, 
            cell_size: int, 
            main_color = WHITE, 
            inverted_color = BLACK
        ):
        self.width = width
        self.height = height
        self.screen = screen
        self.cell_size = cell_size
        self.cells = self.create_matrix()
        self.main_color = main_color,
        self.inverted_color = inverted_color
        self.inverted = False

    def create_matrix(self):

        matrix = []

        for i in range(self.width):

            line = []

            for j in range(self.height):
                cell = Cell(
                    x=self.cell_size * i - 1,
                    y=self.cell_size * j - 1,
                    size=self.cell_size,
                    screen=self.screen,
                    color=(255, 255, 255)
                )

                line.append(cell)

            matrix.append(line)

        return matrix

    def draw(self):
        for line in self.cells:
            for cell in line:
                cell.draw()

    def change_cell_color(self, pos_x: int, pos_y):
        x = pos_x // self.cell_size
        y = pos_y // self.cell_size

        cell: Cell = self.cells[x][y]

        if cell.clicked == False:
            cell.clicked = True
            if cell.color == (255, 255, 255):
                cell.color = (0, 0, 0)
            else:
                cell.color = (255, 255, 255)
        
        cell.draw()

    def reset_cells_clicked(self):
        for line in self.cells:
            for cell in line:
                cell.clicked = False

    def distance(self, x1, x2, y1, y2):
        return math.sqrt((x1-x2)**2 + (y1-y2)**2)

    def change_circle_cells_colors(self, pos_x: int, pos_y: int, circle_radius: int, color, value: int):
        x_init = pos_x - circle_radius
        y_init = pos_y - circle_radius
        interval = 2 * circle_radius // self.cell_size

        x = [x_init + self.cell_size * i for i in range(interval)]
        # print(x)
        y = [y_init + self.cell_size * i for i in range(interval)]
        # print(y)

        for i in x:
            for j in y:
                cell_x = i // self.cell_size
                cell_y = j // self.cell_size

                if (
                    (cell_x >= 0 and cell_x < self.width) and
                    (cell_y >= 0 and cell_y < self.height) 
                ):
                    if self.distance(pos_x, i, pos_y, j) < circle_radius:
                        cell = self.cells[cell_x][cell_y]
                        cell.color = color
                        cell.value = value
                        cell.clicked = True
                        cell.draw()

    def invert_colors(self):
        for line in self.cells:
            for cell in line:
                if self.inverted is False:
                    cell.value = 1
                    cell.color = self.inverted_color
                else:
                    cell.value = 0
                    cell.color = self.main_color

                cell.draw()

        self.inverted = not self.inverted


    def export(self):
        now = int(datetime.now().timestamp() * 100000)
        filename = f"matrix_{now}.txt"

        with open(filename, "w") as f:
            for line in self.cells:
                line_str = ",".join([str(cell.value) for cell in line])
                f.write(line_str + "\n")
    
    def read_from_file(self, filename: str):
        with open(filename, "r") as f:
            lines = f.readlines()
            lines = [line.rstrip("\n").split(",") for line in lines]
            # print(lines)
            for i, line in enumerate(lines):
                for j, value in enumerate(line):
                    cell = self.cells[i][j]
                    cell.value = int(value)
                    cell.color = (0, 0, 0) if cell.value == 1 else (255, 255, 255)
                    cell.draw()

