poles = [-250+433i -250-433i 125+216.506i 125-216.506i -125+216.506i -125-216.506i];
zeros = [0 0];
gain = 0.8;
s=zpk(zeros,poles,gain);
pzplot(s)