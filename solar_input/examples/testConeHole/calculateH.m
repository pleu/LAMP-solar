function H = calculateH(rtop, rbot, a, T, ET)
  H = 3*a^2*(T- ET)/pi/(rtop^2+rtop*rbot+rbot^2);
end