function [sampleVar1, variance1, sampleVar2, variance2] = normaldistribution(mean1,  variance1,mean2, variance2)
    %Calculating the mu
    mu1 = mean1;
    mu2 = mean2;
    
    %Calculating the std
    std1 = variance1^(1/2);
    std2 = variance2^(1/2);
   
    
    N = 1000;
    sampleMean1 = 0;
    sampleMean2 = 0;
    
    result1 = randomNumberGenerator(N);
    n1=0;
    now = (1+erf((n1-mu1)/(std1*2^(1/2))))/2;
   	while(now<1)
        n1=n1+1;
        now = (1+erf((n1-mu1)/(std1*2^(1/2))))/2;
    end
    ind = 1;
    for i = -n1:n1
        now = (1+erf((i-mu1)/(std1*2^(1/2))))/2;
        y=(result1<now);
        calc1(ind) = sum(y)/N;
        ind = ind+1;
    end
    i1 = -n1:n1;
    dy1 = diff(calc1)./diff(i1);
    pmf1 = dy1;
    for i = 1:n1*2
        sampleMean1 = sampleMean1 + pmf1(i)*(i-n1-1/2);
    end

    result2 = randomNumberGenerator(N);
    n2=0;
    now = (1+erf((n2-mu2)/(std2*2^(1/2))))/2;
   	while(now<1)
        n2=n2+1;
        now = (1+erf((n2-mu2)/(std2*2^(1/2))))/2;
    end
    ind = 1;
    for i = -n2:n2
        now = (1+erf((i-mu2)/(std2*2^(1/2))))/2;
        y=(result1<now);
        calc2(ind) = sum(y)/N;
        ind = ind+1;
    end
    i2 = -n2:n2;
    dy2 = diff(calc2)./diff(i2);
    pmf2 = dy2;
    for i = 1:n2*2
        sampleMean2 = sampleMean2 + pmf2(i)*(i-n2-1/2);
    end
    %Calculate sample variance
    sampleVar1=0;
    sampleVar2=0;
    for i=1:n1*2
        for j = 1:pmf1(i)*N
            if(pmf1(i)~=0)
            sampleVar1 = sampleVar1 + ((i-n1-sampleMean1)*(i-n1-sampleMean1));
            end
        end
    end
    for i=1:n2*2
        for j = 1:pmf2(i)*N
            if(pmf2(i)~=0)
            sampleVar2 = sampleVar2 + ((i-n2-sampleMean2)*(i-n2-sampleMean2));
            end
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
    bins = -n1:n1;
    plot( bins,calc1, 'r', 'LineWidth', 2);
    str = sprintf('Normal Distribution:\n Mean=%f',mu1);
    title(str);
    legend('Experimental');
    
    subplot(2,2,2);
    bins = -n2:n2;
    plot( bins, calc2,'b', 'LineWidth', 2);
    str = sprintf('Normal Distribution:\n Mean=%f',mu2);
    title(str);
    legend('Experimental');
    
    subplot(2, 2, 3);
    x = -n1:n1;     
    cdf1 = (1+erf((x-mu1)/(std1*2^(1/2))))/2;
    h = plot(x,cdf1,'ok');
    set(h,'MarkerFaceColor','r')
    str = sprintf('Sample Variance= %f\n Variance= %f\n',sampleVar1,variance1);
    title(str);
    legend('Analytical');
    
    subplot(2, 2, 4);
    x = -n2:n2;        
    cdf2 = (1+erf((x-mu2)/(std2*2^(1/2))))/2;
    h = plot(x,cdf2,'ok');
    set(h,'MarkerFaceColor','b')
    str = sprintf('Sample Variance= %f\n Variance= %f\n',sampleVar2,variance2);
    title(str);
    legend('Analytical');
     
end
