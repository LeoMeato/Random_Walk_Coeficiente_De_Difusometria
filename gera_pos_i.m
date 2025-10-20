function[pos] = gera_pos_i(A)

[w, h] = size(A);
pos = [randi([1, w]), randi([1, h])];
while A(pos(1), pos(2)) == 1
  pos = [randi([1, w]), randi([1, h])];
endwhile
