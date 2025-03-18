clear;
close all;
clc;
%% Post Processing for pressure coefficient for task 3
% experiment
data = load('Experiment_Cp_AoA_1_Freestream.dat');
x_exp = data(:, 1); % position
y_exp = data(:, 2); % Cp
x_exp_pre = x_exp(x_exp > 0);
x_exp_suc = x_exp(x_exp < 0);
y_exp_pre = y_exp(y_exp > 0);
y_exp_suc = y_exp(y_exp < 0);

% simulation
data_sim = load('adapt10.dat');
x = data_sim(:, 1); % position
y = data_sim(:, 2); % Cp
y_pre = y(y > 0);
y_suc = y(y < 0);
norm_x = x/max(x);
norm_x_pre = norm_x(y > 0);
norm_x_suc = norm_x(y < 0);

[norm_x_pre, sID] = sort(norm_x_pre);
y_pre = y_pre(sID);
[norm_x_suc, sID] = sort(norm_x_suc);
y_suc = y_suc(sID);

unique_indices = norm_x_pre < 1;
norm_x_pre = norm_x_pre(unique_indices);
y_pre = y_pre(unique_indices);

unique_indices = norm_x_suc < 1;
norm_x_suc = norm_x_suc(unique_indices);
y_suc = y_suc(unique_indices);

y_pres_int = interp1(norm_x_pre, y_pre, x_exp_pre);
y_suc_int = interp1(norm_x_suc, y_suc, x_exp_suc);

pres_error = y_pres_int - y_exp_pre;
suc_error = y_suc_int - y_exp_suc;

disp(pres_error);
disp(suc_error);

%% Plot Data
%plot(x_exp, y_exp, 'o',)
%xlabel('x/C')
%ylabel('C_p')
%grid on