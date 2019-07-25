%% Plot Value Function
nplot = 100;
S1 = linspace(-90,10,nplot);
S2 = linspace(-30,90,nplot);
S=[S1' S2'];
%X = [1; S(1); S(2); S(1)*S(2)];
%X = [1; S(1); S(2); S(1)*S(2); S(1)^2; S(2)^2; S(1)*S(2)^2; S(1)^2 *S(2); S(1)^2 *S(2)^2; S(1)^3; S(2)^3; S(1)*S(2)^3; S(1)^3 *S(2); S(1)^3 *S(2)^3];

%%X = [ones(nplot,1), S(:,1), S(:,2), S(:,1).*S(:,2), S(:,1).^2, S(:,2).^2, S(:,1).*S(:,2).^2, S(:,1).^2 .*S(:,2), S(:,1).^2 .*S(:,2).^2, S(:,1).^3, S(:,2).^3, S(:,1).*S(:,2).^3, S(:,1).^3 .*S(:,2), S(:,1).^3 .*S(:,2).^3];
%%Xweighted = w(:,1)' .* X


%Xplot = [1; S(iS1,1); S(iS2,2); S(iS1,1)*S(iS2,2); S(iS1,1)^2; S(iS2,2)^2; S(iS1,1)*S(iS2,2)^2; S(iS1,1)^2 *S(iS2,2); S(iS1,1)^2 *S(iS2,2)^2; S(iS1,1)^3; S(iS2,2)^3; S(iS1,1)*S(iS2,2)^3; S(iS1,1)^3 *S(iS2,2); S(iS1,1)^3 *S(iS2,2)^3]; %V=w'*X;
%Xplot = [1; S(iS1,1); S(iS2,2); S(iS1,1)*S(iS2,2)]; 

for ia=1:4
    for iS1=1:nplot
        for iS2=1:nplot
            V(iS1,iS2,ia) = w(:,ia)' * [1; S(iS1,1); S(iS2,2); S(iS1,1)*S(iS2,2)]; %V=w'*X;
        end
    end
end

for ia=1:4
    figure
    surf(S1,S2,V(:,:,ia))
end
Vtot=sum(V,3);
figure
surf(S1,S2,Vtot)

%% Plot Q Table Value Function
for ia=1:4
    figure
    surf(reshape(policy(:,ia),[5, 5]))
end
%surf(reshape(sum(policy,2),[5, 5]))
%bar3(reshape(sum(policy,2),[5, 5]))

for i=1:4
    policym(:,:,i) = reshape(policy(:,i),[5,5]);
end
    
for i=1:5
    for j=1:5
        [maxval, Vmax(i,j)] = max(squeeze(policym(i,j,:)));
    end
end
figure

h=heatmap(Vmax); xlabel("Servo 2"); ylabel("Servo 1"); caxis([1 4]); colormap('Summer'); 
colorbar.Ticks = [1:4];
