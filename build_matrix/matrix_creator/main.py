import pygame
import sys
from Matrix import Matrix

# Initialize Pygame
pygame.init()

# Create window
WIDTH, HEIGHT = 500, 500
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Basic Pygame Window")

RED = (255, 0, 0)

# rect = pygame.Rect(30, 30, 60, 40)
matrix = Matrix(
    width=100,
    height=100,
    screen=screen,
    cell_size=5
)

# Clock to control FPS
clock = pygame.time.Clock()

# Game loop
running = True
mouse_down = False
radius = 40
color = (255, 0, 0)
value = -1

while running:
    screen.fill((255, 255, 255))
    mouse_x, mouse_y = pygame.mouse.get_pos()

    # Handle events
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_i:
                matrix.invert_colors()

        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_e:
                matrix.export()

        if event.type == pygame.MOUSEBUTTONDOWN:
            mouse_down = True

            if event.button == 1:
                color = (0, 0, 0)
                value = 1

            if event.button == 3:
                color = (255, 255, 255)
                value = 0

            # matrix.change_circle_cells_colors(mouse_x, mouse_y, radius, color, value)

        if event.type == pygame.MOUSEBUTTONUP:
            mouse_down = False
            matrix.reset_cells_clicked()

    if mouse_down:
        matrix.change_circle_cells_colors(mouse_x, mouse_y, radius, color, value)

    matrix.draw()
    pygame.draw.circle(screen, RED, (mouse_x, mouse_y), radius, 3)
    
    pygame.display.flip()

pygame.quit()
sys.exit()
