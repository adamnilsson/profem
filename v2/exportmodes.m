for i=1:7
    figure(i)
    view(20,30);zlim([-.01 .02]);ylim([-.01 .02]);xlim([0 .09])
    name = ['../img/beammode' num2str(i) '.eps']
    print('-depsc', name)
end


% for i=1:7
%     figure(i)
%     view(20,30);zlim([-.1 .1]);xlim([0 .3])
%     name = ['../img/beammode' num2str(i) '.eps']
%     print('-depsc', name)
% end
% 
% 
