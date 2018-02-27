function [] = MC_sigm_plot_thesis(dim,ifPost,exper,N,m,k)
clearvars -except dim ifPost exper N m k
format short
if nargin < 3, exper='sin'; end
if dim==1,
    respath = './sines_sigm-1d/';
    Sce = [0,1];
elseif dim==2,
    if strcmp(exper,'sin'),
        respath = './sines_sigm-2d/';
        Sce = [0,1];
    else
        respath = './SI_sigm-2d/';
        Sce = [2];
    end
else
    error('dim must be 1 or 2');
end
statfile = [respath 'stats-N-' num2str(N) '-m-' num2str(m) '-k-' num2str(k) '.mat'];
load(statfile)
ssize = size(methodErr);
markerSize = [18 18 24];
lineWidth = [6 6 8];
axisLabelFontSize = [48 48 60];
axisMarksFontSize = [36 36 48];
legendFontSize = [36 36 48];
transp = 0.2;
for kInd = 1:ssize(3),
    for sc = Sce+1,
        figure
        bl = errorbar(1./SNR,squeeze(mean(methodErr(1,sc,kInd,:,:),5)),...
                2*squeeze(std(methodErr(1,sc,kInd,:,:),1,5))./sqrt(N),'b-'); % AST
%             'b-','Marker', 'o', 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'b', 'MarkerSize', markerSize(sc),...
%             'LineWidth', lineWidth(sc)); % AST
        bl.LineWidth = lineWidth(sc);
        hold on
    %     loglog(1./SNR,squeeze(mean(methodErr(2,sc,kInd,:,:),5)),'g-','Marker', 'square', ...
    %         'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'g', 'MarkerSize', 12,...
    %         'LineWidth',3); % l8conk    
    %     hold on
    %     loglog(1./SNR,squeeze(mean(methodErr(3,sc,kInd,:,:),5)),'g-','Marker', 'square', ...
    %         'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'g', 'MarkerSize', 12,...
    %         'LineWidth',3); % l8conk2
    %     hold on
    %     loglog(1./SNR,squeeze(mean(methodErr(4,sc,kInd,:,:),5)),'r-','Marker', 'diamond', ...
    %         'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'r', 'MarkerSize', 12,...
    %         'LineWidth',3); % l2conk
    %     hold on
    %     loglog(1./SNR,squeeze(mean(methodErr(5,sc,kInd,:,:),5)),'r-','Marker', 'diamond', ...
    %         'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'r', 'MarkerSize', 12,...
    %         'LineWidth',3); % l2conk2
    %     hold on
        bl = errorbar(1./SNR,squeeze(mean(methodErr(6,sc,kInd,:,:),5)),...
                2*squeeze(std(methodErr(6,sc,kInd,:,:),1,5))./sqrt(N),'r-'); % l2penpr
%                 'Marker', 'diamond',... %'pentagram', ...
%                 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'r', 'MarkerSize', markerSize(sc),...
%                 'LineWidth', lineWidth(sc)); % 10,'LineWidth',3); % l2penpr
        bl.LineWidth = lineWidth(sc);
    %     loglog(1./SNR,squeeze(mean(methodErr(7,sc,kInd,:,:),5)),'m-.','Marker', 'diamond',... %'hexagram', ...
    %             'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'm', 'MarkerSize', 12, 'LineWidth', 4); % 10,'LineWidth',3); % l2penth
        if ifPost,
            loglog(1./SNR,squeeze(mean(methodErr(8,sc,kInd,:,:),5)),'m-','Marker', '+',... %'pentagram', ...
                    'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'm', 'MarkerSize', markerSize(sc),...
                    'LineWidth', lineWidth(sc));
            loglog(1./SNR,squeeze(mean(methodErr(9,sc,kInd,:,:),5)),'g-','Marker', 'o',... %'pentagram', ...
                    'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'g', 'MarkerSize', markerSize(sc),...
                    'LineWidth', lineWidth(sc));
        end
        alpha 0.6
        set(gca,'XScale','log');
        set(gca,'YScale','log');
        grid on
        xlim([0.06,4]);
        %xlim([1/64, 16]);
        %ylim([2.5,20]);
        if dim==1,
%             ylim([0.02,20]);
            ylim([0.025,1]);
        else
            if strcmp(exper,'sin'),
                ylim([0.0025,1]);
            else
                ylim([0.025,1]);
            end
        end
        xlabel('SNR$^{-1}$','interpreter','latex','fontsize',axisLabelFontSize(sc));
        yl = ylabel('$\ell_2$-error','interpreter','latex','fontsize',axisLabelFontSize(sc));
        yl.Color = 'none';
        if sc == 1 || dim == 2 && sc == 3 && kInd == 1,
            yl.Color = 'black';
        end
        set(gca,'FontSize',axisMarksFontSize(sc));
        %set(gca,'XTick', [0.1 0.25 0.5 1 2 4 10]);
        set(gca,'XTick', [0.0625 0.125 0.25 0.5 1 2 4]);
        set(gca,'xtickmode','manual');
        %set(gca,'xtick', [1/32 1/16 1/8 1/4 1/2 1 2 4 8 16]);
        set(gca,'xticklabels', {'0.06','0.12','0.25','0.5','1','2','4'});
        %set(gca,'YTick', [2.5 5 10 20]);
        set(gca,'YTick', [0.005 0.01 0.025 0.05 0.1 0.25 0.5 1 2 4]);
        l=legend('Lasso (AST)','Pen. LSR','Location','southeast');
        if ifPost,
            l=legend('Lasso (AST)','Pen. LSR','post','esprit','Location','southeast');
        end
        %'Pen. $\ell_2$-recovery, $\lambda_{pract}$','Pen. $\ell_2$-recovery, $\lambda_{theor}$','Location','southeast');
            %'Constrained $\ell_\infty$-recovery','Constrained $\ell_2$-recovery',
        set(l,'Interpreter','latex','fontsize',legendFontSize(sc));
        %set(gcf,'PaperPositionMode','Auto');
        set(gcf,'defaulttextinterpreter','latex');
        set(gcf, 'PaperSize', [11.69 8.27]); % paper size (A4), landscape
        % Extend the plot to fill entire paper.
        set(gcf, 'PaperPosition', [0 0 11.69 8.27]);
        if sc == 1, scenario = ['RandomSpikes-m-' num2str(m) '-k-' num2str(k)]; end
        if sc == 2, scenario = ['CoherentSpikes-m-' num2str(m) '-k-' num2str(k)]; end
        if sc == 3, scenario = ['DimensionReduction-m-' num2str(m) '-beta-' num2str(k)]; end
        print('-depsc',[respath scenario '.eps']);
        saveas(gcf,[respath scenario '.pdf'],'pdf');
    end
    % the last plot is not needed
%     if dim == 1,
%         figure
%         loglog(1./SNR,squeeze(mean(methodErr(4,2,kInd,:,:),5)),'r-.','Marker', 'diamond', ...
%             'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r', 'MarkerSize', markerSize(sc),...
%             'LineWidth',lineWidth(sc)); %10,'LineWidth',3);
%              % l2conk
%         hold on
%         loglog(1./SNR,squeeze(mean(methodErr(5,2,kInd,:,:),5)),'r-','Marker', 'diamond', ...
%             'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'r', 'MarkerSize', markerSize(sc),...
%             'LineWidth',lineWidth(sc)); %10,'LineWidth',3);
%              % l2conk2
%         hold on
%         %xlim([0.1,10]);
%         xlim([1/16,4]);
%         %ylim([2.5,30]);
%         ylim([0.02,1]);
%         xlabel('SNR$^{-1}$','interpreter','latex','fontsize',axisLabelFontSize(sc));
%         %ylabel('$\ell_2$-error','interpreter','latex','fontsize',axisLabelFontSize(sc));
%         set(gca,'FontSize',axisMarksFontSize(sc));
%         set(gca,'XTick', [0.1 0.25 0.5 1 2 4 10]);
%         %set(gca,'XTick', [1/32 1/16 1/8 1/4 1/2 1 2 4]);
%         %set(gca,'YTick', [2.5 5 10 20 30]);
%         set(gca,'YTick', [0.05 0.1 0.25 0.5 1 2 4 10]);
%         l=legend('Con. $\ell_2$-rec., $\overline{\varrho}=4$','Con. $\ell_2$-rec., $\overline{\varrho}=16$',...
%             'Location','southeast');
%         set(l,'Interpreter','latex','fontsize',legendFontSize(sc));
%         %set(gcf,'PaperPositionMode','Auto');
%         set(gcf,'defaulttextinterpreter','latex');    
%         set(gcf, 'PaperSize', [11.69 8.27]); % paper size (A4), landscape
%         % Extend the plot to fill entire paper.
%         set(gcf, 'PaperPosition', [0 0 11.69 8.27]);
%         print('-depsc',[respath 'comp3.eps']);
%         saveas(gcf,[respath 'comp3.pdf'],'pdf');
%     end
end
end