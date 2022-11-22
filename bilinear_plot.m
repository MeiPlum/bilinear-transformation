% Illustration of bilinear transformation.
% Edited by Chung-Shiang Mei, Nov. 22, 2022

close all; clear; clc;

img_range = 3;
grid_size = 0.01;

% Points
% Random point(s) in lef-hand side of s-domain
pt_num = 5;
pt_s = rand(1, pt_num) * -img_range + ...
    sqrt(-1) * (rand(1, pt_num) * 2 * img_range - img_range);

figure();
stem(real(pt_s), imag(pt_s), '*', 'LineStyle', 'none');
axis ('equal', [-img_range img_range -img_range img_range]);
grid();
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
title('s domain');
xlabel('\Re');
ylabel('\Im');

% Bilinear transformation
Td = 1;
pt_z = (1 + Td / 2 * pt_s) ./ (1 - Td / 2 * pt_s);

figure();
stem(real(pt_z), imag(pt_z), '*', 'LineStyle', 'none');
hold on;
pos = [-1 -1 2 2];
rectangle('Position', pos, 'Curvature', [1 1]);
axis ('equal', [-img_range img_range -img_range img_range]);
grid();
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
title('Bilinear transformation into z domain');
xlabel('\Re');
ylabel('\Im');

% Image
re_axis = -img_range:grid_size:img_range;
im_axis = (-img_range:grid_size:img_range)';
s = sqrt(-1) .* im_axis + re_axis;

figure();
% imagesc(re_axis, im_axis, real(s));
% imagesc(re_axis, im_axis, 1-abs(real(s)));
s = reshape(s, 1, []);
scatter(real(s), imag(s), [], real(s), '.');
% scatter(real(s), imag(s), [], 1-abs(real(s)), '.');
xline(0, '--r');
axis equal;
axis tight;
set(gca, 'YDir', 'normal');
colorbar;
% colormap gray;
grid();
title('s domain');
xlabel('\Re');
ylabel('\Im');

% Bilinear transformation
Td = 1;
z = (1 + Td / 2 .* s) ./ (1 - Td / 2 .* s);
rmv_idx = isinf(z);
% rmv_idx = isinf(z) | abs(real(z)) > img_range | abs(imag(z)) > img_range;

z(rmv_idx) = [];
z_original_s = s(~rmv_idx);

re_pos_z = round((real(z) + img_range) / grid_size) + 1;
im_pos_z = round((imag(z) + img_range) / grid_size) + 1;

figure();
scatter(real(z), imag(z), [], real(z_original_s), '.');
% scatter(real(z), imag(z), [], 1-abs(real(z_original_s)), '.');
rectangle('Position', pos, 'Curvature', [1 1], 'LineStyle', '--', 'EdgeColor', 'r');
axis('equal', 2 * [-img_range img_range -img_range img_range]);
set(gca, 'YDir', 'normal');
colorbar;
% colormap gray;
grid();
title('Bilinear transformation into z domain');
xlabel('\Re');
ylabel('\Im');