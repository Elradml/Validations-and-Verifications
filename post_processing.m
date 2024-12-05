clear;
close all;
clc;
%% Post Processing for tables quantifying iterative Error for Roe-FDS and AUSM in solving Spalart-Allmaras
% First order Roe-FDS
roe1 = load('Roe-1-res.dat');
roe1_data = roe1(:, 2); % extract lift-y values used for convergence
roe1_norm = (norm(roe1_data, 2))/ 140; % calculate norm 2

% Second order Roe-FDS
roe2 = load('Roe-2-res.dat');
roe2_data = roe2(:, 2);
roe2_norm = (norm(roe2_data, 2))/66; 

% Third order Roe-FDS
roe3 = load('Roe-3-res.dat');
roe3_data = roe3(:, 2);
roe3_norm = (norm(roe3_data, 2))/66;

% First order AUSM
ausm1 = load('AUSM-1-res.dat');
ausm1_data = ausm1(:, 2);
ausm1_norm = (norm(ausm1_data, 2))/154;

% Second order AUSM
ausm2 = load('AUSM-2-res.dat');
ausm2_data = ausm2(:, 2);
ausm2_norm = (norm(ausm2_data, 2))/66;

% First order AUSM
ausm3 = load('AUSM-3-res.dat');
ausm3_data = ausm3(:, 2);
ausm3_norm = (norm(ausm3_data, 2))/66;


% Norm table headings
headings = {'1st Order Roe-FDS', '1st Order AUSM', '2nd Order Roe-FDS', '2nd Order AUSM', '3rd Order Roe-FDS', '3rd Order AUSM'};
norms = [roe1_norm, ausm1_norm, roe2_norm, ausm2_norm, roe3_norm, ausm3_norm];
norm_table = table(headings', norms', 'VariableNames', {'Numerical Method', 'Euclidean (L2) Norm'});
disp(norm_table);


