import pygame

class Cell:
    def __init__(self, x: int, y: int, size: int, screen, color):
        self.x = x
        self.y = y
        self.size = size
        self.screen = screen
        self.color = color
        self.clicked = False
        self.value = 0

    def draw(self):
        rect = pygame.Rect(self.x, self.y, self.size, self.size)
        pygame.draw.rect(self.screen, self.color, rect)
        pygame.draw.rect(self.screen, (0, 0, 0), rect, width=1)