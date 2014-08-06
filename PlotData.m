[m,n] = size(data);

for i = 1:n
pdeplot(p,e,t,'xydata',data(:,i));
caxis([10 600]);                            %Fix the limits of temperature on the legend
colormap(hot);                              %Change the color of the plot
title(i);
drawnow;
if i==1
%pause(60);                             %Control the speed of playback
end
end
