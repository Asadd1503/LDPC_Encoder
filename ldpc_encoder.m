clc; clear;
code_rate = 3/4;
N = 64800; %frame length
% Generating H of frame length ='64800 bits' and code_rate = '3/4'
H = dvbs2ldpc(code_rate);
[row_idx, col_idx] = find(H);

%.......
no_columns_H = N;
k = N*code_rate; % no. of info bits
no_rows_H = no_columns_H - k;

u = readmatrix('E:\LDPC_Encoder\info_bits.txt');
%disp(size(u));
S = zeros(no_rows_H, 1);
%disp(size(S));
valid_idx = col_idx(col_idx <= k);

for i = 1:length(valid_idx)
    c = valid_idx(i);
    r = row_idx(i);
    S(r,1) = xor(S(r,1), u(c,1));
end

%disp(S.');

P = zeros(no_rows_H,1);
P(1,1) = S(1,1);
for x = 2: no_rows_H
    P(x,1) = xor(P((x-1),1),S(x,1));
end
%disp('information bits:');
%disp(u.');
%disp('Parity bits:');
%disp(P.');
%disp('encoded bits:');
c = [u;P];
disp(c.');









