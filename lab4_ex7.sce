clc; clear;
if ~isempty(winsid()) then
    close(winsid());
end

function ve_tin_hieu(idx, sig, tieu_de)
    plot2d3(idx, sig, 2);
    plot(idx, sig, "ro");
    ax = gca();
    ax.x_ticks = tlist(["ticks", "locations", "labels"], idx, string(idx));
    xgrid(1);
    title(tieu_de);
    xlabel("Chi so n");
    ylabel("Bien do");
endfunction

function y_out = tich_chap_lat_dich(x_in, h_in)
    L = length(x_in);
    y_out = zeros(1, L);
    
    x_lat = zeros(1, L);
    for k = 0:L-1
        x_lat(k + 1) = x_in(pmodulo(-k, L) + 1);
    end
    
    mprintf("=== PHUONG PHAP LAT VA DICH CHUYEN ===\n");
    mprintf("Chuoi lat x((-k) mod %d) = [%s]\n", L, strcat(string(x_lat), ", "));
    
    for k_n = 0:L-1
        x_dich = zeros(1, L);
        for k = 0:L-1
            x_dich(k + 1) = x_lat(pmodulo(k - k_n, L) + 1);
        end
        val = sum(h_in .* x_dich);
        y_out(k_n + 1) = val;
        mprintf("n = %d: y(%d) = %g\n", k_n, k_n, val);
    end
endfunction

function [y_out, H_mat] = tich_chap_ma_tran(x_in, h_in)
    L = length(x_in);
    H_mat = zeros(L, L);
    
    for row = 0:L-1
        for col = 0
