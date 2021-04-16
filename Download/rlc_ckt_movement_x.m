poles = [-4+0i -1+0i -10-2i -14-2i];
zeros = [0 0];
gain = 0.8;
s=zpk(zeros,poles,gain);
pzplot(s);
xlim([-20 10]);
ylim([-10 10]);