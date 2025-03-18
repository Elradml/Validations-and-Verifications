clear;
close all;
clc;
%% Post Processing of pressure coefficient distribution for task 3
% experimental
exp = importdata('Experiment_Cp_AoA_1_Freestream.dat');
x_exp = exp(:, 1);
cp_exp = exp(:, 2);
x_exp_pre = x_exp(cp_exp > 0);
x_exp_suc = x_exp(cp_exp < 0);
cp_exp_pre = cp_exp(cp_exp > 0);
cp_exp_suc = cp_exp(cp_exp < 0);

% simulation (spalart-allmaras AUSM 1st order upwind with 10 cell adaptive
% boundary layer mesh refinement)
sim = load('adapt10.dat');
x_sim = sim(:, 1);
cp_sim = sim(:, 2);
norm_x = x_sim/max(x_sim);
norm_x_pre = norm_x(cp_sim > 0);
norm_x_suc = norm_x(cp_sim < 0);
cp_sim_pre = cp_sim(cp_sim > 0);
cp_sim_suc = cp_sim(cp_sim < 0);

% sort
[norm_x_pre, sID] = sort(norm_x_pre);
cp_sim_pre = cp_sim_pre(sID);
[norm_x_suc, sID] = sort(norm_x_suc);
cp_sim_suc = cp_sim_suc(sID);

% remove trailing edge values
non_te = norm_x_pre < 1;
norm_x_pre = norm_x_pre(non_te);
cp_sim_pre = cp_sim_pre(non_te);
non_te = norm_x_suc < 1;
norm_x_suc = norm_x_suc(non_te);
cp_sim_suc = cp_sim_suc(non_te);

[pre_unique, idx] = unique(norm_x_pre, 'stable');
cp_sim_pre_unq = cp_sim_pre(idx);
[suc_unique, idx] = unique(norm_x_suc, 'stable');
cp_sim_suc_unq = cp_sim_suc(idx);

% error
cp_sim_pre_int = interp1(pre_unique, cp_sim_pre_unq, x_exp_pre);
cp_sim_suc_int = interp1(suc_unique, cp_sim_suc_unq, x_exp_suc);

pre_error = cp_sim_pre_int - cp_exp_pre;
suc_error = cp_sim_suc_int - cp_exp_suc;

%% Plot data
fig = figure;
set(gcf, 'Units', 'pixels', 'Position', [40, 80, 800, 600]);
tile = tiledlayout(2, 2, 'Padding', 'compact', 'TileSpacing', 'compact');
a1 = nexttile(1);
hold on
% experimental points
plot(x_exp_pre, cp_exp_pre, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 5) 
plot(x_exp_suc, cp_exp_suc, 'g>', 'MarkerFaceColor', 'g', 'MarkerSize', 5)
% simulation lines
plot(norm_x_pre, cp_sim_pre, '-r', 'MarkerFaceColor', 'r', 'MarkerSize', 5, 'LineWidth', 2) 
plot(norm_x_suc, cp_sim_suc, '-b', 'MarkerFaceColor', 'b', 'MarkerSize', 5, 'LineWidth', 2)
legend(a1, {'Exp. - pressure side', 'Exp. - suction side', 'Sim. - pressure side', 'Sim. - suction side'}, 'Location', 'best')
xlim([0, 1])
xlabel('x/C')
ylabel('C_p')

a2 = nexttile(2);
hold on
plot(x_exp_pre, pre_error, 'rs', 'MarkerFaceColor', 'r', 'MarkerSize', 5)
plot(x_exp_suc, suc_error, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 5)
legend(a2, {'Pressure side', 'Suction side'}, 'Location', 'best')
xlim([0, 1])
xlabel('x/C')
ylabel('Absolute Error (C_p)')

a3 = nexttile(3);
hold on
plot(x_exp_pre, cp_exp_pre, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 5)
plot(x_exp_suc, cp_exp_suc, 'g>', 'MarkerFaceColor', 'g', 'MarkerSize', 5)
legend(a3, {'Pressure side', 'Suction side'}, 'Location', 'best')
xlim([0, 1])
xlabel('x/C')
ylabel('C_p')

annotation('textbox', [0.12, 0.9, 0.05, 0.05], 'String', '(a)', ...
           'FontSize', 12, 'EdgeColor', 'none');
annotation('textbox', [0.62, 0.9, 0.05, 0.05], 'String', '(b)', ...
           'FontSize', 12, 'EdgeColor', 'none');
annotation('textbox', [0.12, 0.40, 0.05, 0.05], 'String', '(c)', ...
           'FontSize', 12, 'EdgeColor', 'none');

set(fig, 'PaperUnits', 'centimeters');
set(fig, 'PaperSize', [21 8]);  
saveas(fig,'task3.png')



