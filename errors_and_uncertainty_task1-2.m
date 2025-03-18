clear;
close all;
clc;
%% Post Processing for table quantifying total iterative Error for Roe-FDS and AUSM in solving Spalart-Allmaras
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

%% Calculating iteration error and uncertainty for each point

% Roe 1 calculations
% lists for calculation of errors and uncertainty
avg1 = []; % holds values for average eigenvalue
ie1 = []; % holds iterative erros
iu1 = []; % holds iterative uncertainties

for i = 2:139
    % estimate eigen values
    eigen1 = (norm((roe1_data(i+1) - roe1_data(i)), 2)/140) / norm((roe1_data(i) - roe1_data(i-1)), 2)/140; 
    avg1 = [avg1, eigen1];
    % estimate the iterative error
    iter_error1 = (roe1_data(i+1) - roe1_data(i)) / (eigen1 - 1);
    % average eigenvalue
    avg_eigen1 = mean(avg1);
    % estimate uncertainty in iteration convergence
    iter_un1 = (norm(iter_error1, 2)/140) / (avg_eigen1 - 1);

    % adding values to lists for output to plots
    ie1 = [ie1, iter_error1];
    iu1 = [iu1, iter_un1];
end

% AUSM 1 calculations
% lists for calculation of errors and uncertainty
avg2 = []; % holds values for average eigenvalue
ie2 = []; % holds iterative erros
iu2 = []; % holds iterative uncertainties

for i = 2:153
    % estimate eigen values
    eigen2 = (norm((ausm1_data(i+1) - ausm1_data(i)), 2)/154) / norm((ausm1_data(i) - ausm1_data(i-1)),2)/154; 
    avg2 = [avg2, eigen2];
    % estimate the iterative error
    iter_error2 = (ausm1_data(i+1) - ausm1_data(i)) / (eigen2 - 1);
    % average eigenvalue
    avg_eigen2 = mean(avg2);
    % estimate uncertainty in iteration convergence
    iter_un2 = (norm(iter_error2, 2)/154) / (avg_eigen2 - 1);

    % adding values to lists for output to plots
    ie2 = [ie2, iter_error2];
    iu2 = [iu2, iter_un2];
end

% Roe 2 calculations
% lists for calculation of errors and uncertainty
avg3 = []; % holds values for average eigenvalue
ie3 = []; % holds iterative erros
iu3 = []; % holds iterative uncertainties

for i = 2:65
    % estimate eigen values
    eigen3 = (norm((roe2_data(i+1) - roe2_data(i)), 2)/66) / norm((roe2_data(i) - roe2_data(i-1)),2)/66; 
    avg3 = [avg3, eigen3];
    % estimate the iterative error
    iter_error3 = (roe2_data(i+1) - roe2_data(i)) / (eigen3 - 1);
    % average eigenvalue
    avg_eigen3 = mean(avg3);
    % estimate uncertainty in iteration convergence
    iter_un3 = (norm(iter_error3, 2)/66) / (avg_eigen3 - 1);

    % adding values to lists for output to plots
    ie3 = [ie3, iter_error3];
    iu3 = [iu3, iter_un3];
end

% AUSM 2 calculations
% lists for calculation of errors and uncertainty
avg4 = []; % holds values for average eigenvalue
ie4 = []; % holds iterative erros
iu4 = []; % holds iterative uncertainties

for i = 2:65
    % estimate eigen values
    eigen4 = (norm((ausm2_data(i+1) - ausm2_data(i)), 2)/66) / norm((ausm2_data(i) - ausm2_data(i-1)),2)/66; 
    avg4 = [avg4, eigen4];
    % estimate the iterative error
    iter_error4 = (ausm2_data(i+1) - ausm2_data(i)) / (eigen4 - 1);
    % average eigenvalue
    avg_eigen4 = mean(avg4);
    % estimate uncertainty in iteration convergence
    iter_un4 = (norm(iter_error4, 2)/66) / (avg_eigen4 - 1);

    % adding values to lists for output to plots
    ie4 = [ie4, iter_error4];
    iu4 = [iu4, iter_un4];
end

% Roe 3 calculations
% lists for calculation of errors and uncertainty
avg5 = []; % holds values for average eigenvalue
ie5 = []; % holds iterative erros
iu5 = []; % holds iterative uncertainties

for i = 2:65
    % estimate eigen values
    eigen5 = (norm((roe3_data(i+1) - roe3_data(i)), 2)/66) / norm((roe3_data(i) - roe3_data(i-1)),2)/66; 
    avg5 = [avg5, eigen5];
    % estimate the iterative error
    iter_error5 = (roe3_data(i+1) - roe3_data(i)) / (eigen5 - 1);
    % average eigenvalue
    avg_eigen5 = mean(avg5);
    % estimate uncertainty in iteration convergence
    iter_un5 = (norm(iter_error5, 2)/66) / (avg_eigen5 - 1);

    % adding values to lists for output to plots
    ie5 = [ie5, iter_error5];
    iu5 = [iu5, iter_un5];
end

% AUSM 3 calculations
% lists for calculation of errors and uncertainty
avg6 = []; % holds values for average eigenvalue
ie6 = []; % holds iterative erros
iu6 = []; % holds iterative uncertainties

for i = 2:65
    % estimate eigen values
    eigen6 = (norm((ausm3_data(i+1) - ausm3_data(i)), 2)/66) / norm((ausm3_data(i) - ausm3_data(i-1)),2)/66; 
    avg6 = [avg6, eigen6];
    % estimate the iterative error
    iter_error6 = (ausm3_data(i+1) - ausm3_data(i)) / (eigen6 - 1);
    % average eigenvalue
    avg_eigen6 = mean(avg6);
    % estimate uncertainty in iteration convergence
    iter_un6 = (norm(iter_error6, 2)/66) / (avg_eigen6 - 1);

    % adding values to lists for output to plots
    ie6 = [ie6, iter_error6];
    iu6 = [iu6, iter_un6];
end

%% Plotting graphs for errors & uncertainties against iterations
% Plots for first order upwind for Roe-FDS and AUSM
fig1 = figure;
set(gcf, 'Units', 'pixels', 'Position', [40, 80, 800, 600]);
tile = tiledlayout(2, 2, 'Padding', 'compact', 'TileSpacing', 'compact');
a1 = nexttile(1);
hold on
x1 = linspace(0, 140, 138);
x2 = linspace(0, 154, 152);
y11 = abs(iu1); % values for iterative uncertainty of both numerical methods
y12 = abs(iu2);

plot(x1, y11, x2, y12)
xlabel('Iterations')
ylabel('Uncertainty (%)')
legend({'Roe-FDS', 'AUSM'}, 'Location', 'best')
title('Iterative Uncertainty for First Order Upwind')
grid on

a2 = nexttile(2);
%%% Plots for second order upwind for both methods
x3 = linspace(0, 66, 64);
x4 = linspace(0, 66, 64);
y21 = abs(iu3); % values for iterative uncertainty of both numerical methods
y22 = abs(iu4);

plot(x3, y21, x4, y22)
xlabel('Iterations')
ylabel('Uncertainty (%)')
legend({'Roe-FDS', 'AUSM'}, 'Location', 'best')
title('Iterative Uncertainty for Second Order Upwind')
grid on

a3 = nexttile(3);
%%% Plots for third order MUSCL for both methods
x5 = linspace(0, 66, 64);
x6 = linspace(0, 66, 64);
y31 = abs(iu5); % values for iterative uncertainty of both numerical methods
y32 = abs(iu6);

plot(x5, y31, x6, y32)
xlabel('Iterations')
ylabel('Uncertainty (%)')
legend({'Roe-FDS', 'AUSM'}, 'Location', 'best')
title('Iterative Uncertainty for Third Order MUSCL')
grid on

annotation('textbox', [0.12, 0.9, 0.05, 0.05], 'String', '(a)', ...
           'FontSize', 12, 'EdgeColor', 'none');
annotation('textbox', [0.62, 0.9, 0.05, 0.05], 'String', '(b)', ...
           'FontSize', 12, 'EdgeColor', 'none');
annotation('textbox', [0.12, 0.40, 0.05, 0.05], 'String', '(c)', ...
           'FontSize', 12, 'EdgeColor', 'none');

set(fig1, 'PaperUnits', 'centimeters');
set(fig1, 'PaperSize', [21 8]);  
saveas(fig1,'uncertainties.png')

fig2 = figure;
set(gcf, 'Units', 'pixels', 'Position', [40, 80, 800, 600]);
tile = tiledlayout(2, 2, 'Padding', 'compact', 'TileSpacing', 'compact');
b1 = nexttile(1);

y111 = ie1; % values for iterative error of both numerical methods
y121 = ie2;
plot(x1, y111, x2, y121)
xlabel('Iterations')
ylabel('Error (%)')
legend({'Roe-FDS', 'AUSM'}, 'Location', 'best')
title('Iterative Errors for First Order Upwind')
grid on

b2 = nexttile(2);
y211 = ie3; % values for iterative error of both numerical methods
y221 = ie4;
plot(x3, y211, x4, y221)
xlabel('Iterations')
ylabel('Error (%)')
legend({'Roe-FDS', 'AUSM'}, 'Location', 'best')
title('Iterative Errors for Second Order Upwind')
grid on


b3 = nexttile(3);
y311 = ie5; % values for iterative error of both numerical methods
y321 = ie6;
plot(x5, y311, x6, y321)
xlabel('Iterations')
ylabel('Error (%)')
legend({'Roe-FDS', 'AUSM'}, 'Location', 'best')
title('Iterative Errors for Third Order MUSCL')
grid on

annotation('textbox', [0.12, 0.9, 0.05, 0.05], 'String', '(a)', ...
           'FontSize', 12, 'EdgeColor', 'none');
annotation('textbox', [0.62, 0.9, 0.05, 0.05], 'String', '(b)', ...
           'FontSize', 12, 'EdgeColor', 'none');
annotation('textbox', [0.15, 0.40, 0.05, 0.05], 'String', '(c)', ...
           'FontSize', 12, 'EdgeColor', 'none');

set(fig2, 'PaperUnits', 'centimeters');
set(fig2, 'PaperSize', [21 8]);  
saveas(fig2,'errors.png')

%% Checking which scheme gives the lowest iterative uncertainty
check = [abs(iu1(end)), abs(iu2(end)), abs(iu3(end)), abs(iu4(end)), abs(iu5(end)), abs(iu6(end))];
disp(check);
disp(min(check));