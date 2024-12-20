clear;
close all;
clc;
%% Estimation of Uncertainty 
% spalart-allmaras
sp = load('spcp.dat');
sp_x = sp(:, 1);
sp_y = sp(:, 2);
norm_sp = sp_x/max(sp_x);
sp_pre = norm_sp(sp_y > 0);
sp_suc = norm_sp(sp_y < 0);
sp_y_pre = sp_y(sp_y > 0);
sp_y_suc = sp_y(sp_y < 0);

[sp_pre, sID] = sort(sp_pre);
sp_y_pre = sp_y_pre(sID);


% k-e
ke = load('kecp.dat');
ke_x = ke(:, 1);
ke_y = ke(:, 2);
norm_ke = ke_x/max(ke_x);
ke_pre = norm_ke(ke_y > 0);
ke_suc = norm_ke(ke_y < 0);
ke_y_pre = ke_y(ke_y > 0);
ke_y_suc = ke_y(ke_y < 0);

[ke_pre, sID] = sort(ke_pre);
ke_y_pre = ke_y_pre(sID);


% k-w
kw = load('k-wcp.dat');
kw_x = kw(:, 1);
kw_y = kw(:, 2);
norm_kw = kw_x/max(kw_x);
kw_pre = norm_kw(kw_y > 0);
kw_suc = norm_kw(kw_y < 0);
kw_y_pre = kw_y(kw_y > 0);
kw_y_suc = kw_y(kw_y < 0);

[kw_pre, sID] = sort(kw_pre);
kw_y_pre = kw_y_pre(sID);


%% Estimation of Uncertainty Originating from Modelling Errors using Mean Deviation
% initialize deviation variables
sp_dev = 0;
ke_dev = 0;
kw_dev = 0;
for i = 1:147
    mean = (sp_y(i) + ke_y(i) + kw_y(i))/ 3;
    % deviation for spalart-allmaras
    sp_temp = (abs(sp_y(i) - mean)) / 147;
    sp_dev = sp_dev + sp_temp;
    % deviation for k-e
    ke_temp = (abs(ke_y(i) - mean)) / 147;
    ke_dev = ke_dev + ke_temp;
    % deviation for k-w
    kw_temp = (abs(kw_y(i) - mean)) / 147;
    kw_dev = kw_dev + kw_temp;
end
disp(ke_dev)
disp(sp_dev)
disp(kw_dev)


%% Plot data to check validity
%hold on
%plot(sp_pre, sp_y_pre, 'k-', 'LineWidth', 2)
%plot(sp_suc, sp_y_suc, 'k-','LineWidth', 2)
%plot(ke_pre, ke_y_pre, 'g--','LineWidth', 2)
%plot(ke_suc, ke_y_suc, 'g--','LineWidth', 2)
%plot(kw_pre, kw_y_pre, 'b:','LineWidth', 2)
%plot(kw_suc, kw_y_suc, 'b:','LineWidth', 2)
%grid on
%legend({'Spalart-Allmaras', '','K-e', '', 'K-w'}, 'Location', 'best')
%xlabel('x/C')
%xlim([0, 1])
%ylabel('C_p')
