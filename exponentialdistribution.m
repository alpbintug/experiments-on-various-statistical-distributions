function [sampleVar1, variance1, sampleVar2, variance2] = exponentialdistribution(lambda1, lambda2)
    %Calculating the mu
    mu1 = 1/lambda1;
    mu2 = 1/lambda2;
    
    %Calculating the variance
    variance1 = 1/(lambda1*lambda1);
    variance2 = 1/(lambda2*lambda2);
   
    N = 1000;
    sampleMean1 = 0;
    sampleMean2 = 0;
    
    result1 = randomNumberGenerator(N);
    n1=0;
    now = 1-exp((-1)*n1*lambda1);
   	while(now<1)
        y=(result1<now);
        calc1(n1+1) = sum(y)/N;
        n1=n1+1;
        now = 1-exp((-1)*n1*lambda1);
    end
    i1 = 0:n1-1;
    dy1 = diff(calc1)./diff(i1);
    sizePmf1 = 1;
    while(dy1(sizePmf1)>0)
        sizePmf1 = sizePmf1+1;
    end
    pmf1 = dy1;
    for i = 1:n1-1
        %Calculating sample mean using x*F(x) formula
        sampleMean1 = sampleMean1 + pmf1(i)*(i-1);
    end


    result2 = randomNumberGenerator(N);
    n2=0;
    now = 1-exp((-1)*n2*lambda2);
   	while(now<1)
        y=(result2<now);
        calc2(n2+1) = sum(y)/N;
        n2=n2+1;
        now = 1-exp((-1)*n2*lambda2);
    end
    i2 = 0:n2-1;
    dy2 = diff(calc2)./diff(i2);
    sizePmf2 = 1;
    pmf2 = dy2;
    while(dy2(sizePmf2)>0)
        sizePmf2 = sizePmf2+1;
    end
    for i = 1:n2-2
        sampleMean2 = sampleMean2 + pmf2(i)*(i-1);
    end
    %Calculate sample variance
    sampleVar1=0;
    sampleVar2=0;
    for i=1:sizePmf1
        for j = 1:pmf1(i)*N
            sampleVar1 = sampleVar1 + ((i-sampleMean1)*(i-sampleMean1));
        end
    end
    for i=1:sizePmf2
        for j = 1:pmf2(i)*N
            sampleVar2 = sampleVar2 + ((i-sampleMean2)*(i-sampleMean2));
        end
    end
    sampleVar1 = sampleVar1/(N-1);
    sampleVar2 = sampleVar2/(N-1);

    figure;
    subplot(2, 1, 1);
    X = 1:N;
    Y = result1;
    stem(X, Y, 'red');
    set(gca, 'xlim', [1 N]);
    str = sprintf('Mean of generated values= %f\nSample mean of experimental graph = %f\nMean of analytical graph = %f',mean(result1),sampleMean1,mu1);
    xlabel(str);
    
    str = sprintf('%d Random Values',N);
    title(str);
    
    subplot(2, 1, 2);
    X = 1:N; 
    Y = result2;
    stem(X, Y,'b');
    set(gca, 'xlim', [1 N]);
    
    str = sprintf('Mean of generated values= %f\nSample mean of experimental graph = %f\nMean of analytical graph = %f',mean(result2),sampleMean2,mu2);
    xlabel(str);
    
    figure;
    
    subplot(2,2,1);
    bins = 0:n1-1;
    plot( bins,calc1, 'r', 'LineWidth', 2);
    str = sprintf('Exponential Distribution:\n Lambda=%f',lambda1);
    title(str);
    legend('Experimental');
    
    subplot(2,2,2);
    bins = 0:n2-1;
    plot( bins, calc2,'b', 'LineWidth', 2);
    str = sprintf('Exponential Distribution:\n Lambda=%f',lambda2);
    title(str);
    legend('Experimental');
    
    subplot(2, 2, 3);
    x = 0:n1-1;     
    cdf1 = 1-exp((-1).*x*lambda1);
    h = plot(x,cdf1,'ok');
    set(h,'MarkerFaceColor','r')
    str = sprintf('Variance=%f\nSample Variance=%f',variance1,sampleVar1);
    title(str);
    legend('Analytical');
    
    subplot(2, 2, 4);
    x = 0:n2-1;        
    cdf2 = 1-exp((-1).*x*lambda2);
    h = plot(x,cdf2,'ok');
    set(h,'MarkerFaceColor','b')
    str = sprintf('Variance=%f\nSample Variance=%f',variance2,sampleVar2);
    title(str);
    legend('Analytical');
     
end
