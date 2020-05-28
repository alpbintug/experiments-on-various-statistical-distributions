function [sampleVar1, variance1, sampleVar2, variance2] = binomialdistribution( n1, p1, n2, p2)

    %Calculating the mu
    mu1 = n1*p1;
    mu2 = n2*p2;
    
    %Calculating the variance
    variance1 = n1*p1*(1-p1);
    variance2 = n2*p2*(1-p2);
    
    

    N = 1000;
    sampleMean1 = 0;
    sampleMean2 = 0;
    
    result1 = randomNumberGenerator(N);
    last = 0;
    for i = 1:n1
        now = p1.^i*(1-p1).^(n1-i)*factorial(n1)/(factorial(i)*factorial(n1-i)) + last;
        y=(result1<now & result1>=last);
        last = now;
        calc1(i) = sum(y)/N;
        sampleMean1 = sampleMean1 + calc1(i)*i;
    end
    result2 = randomNumberGenerator(N);
    last = 0;
    for i = 1:n2
        now = p2.^i*(1-p2).^(n2-i)*factorial(n2)/(factorial(i)*factorial(n2-i)) + last;
        y=(result2<now & result2>=last);
        last = now;
        calc2(i) = sum(y)/N;
        sampleMean2 = sampleMean2 + calc2(i)*i;
    end
        
    %Calculate sample variance
    sampleVar1=0;
    sampleVar2=0;
    
   for i=1:n1
        for j = 1:calc1(i)*N
            sampleVar1 = sampleVar1 + ((i-sampleMean1)*(i-sampleMean1));
        end
    end
    for i=1:n2
        for j = 1:calc2(i)*N
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
    X = 1:1000; 
    Y = result2;
    stem(X, Y,'b');
    set(gca, 'xlim', [1 N]);
    
    str = sprintf('Mean of generated values= %f\nSample mean of experimental graph = %f\nMean of analytical graph = %f',mean(result2),sampleMean2,mu2);
    xlabel(str);
    
    figure;
    
    subplot(2,2,1);
    bins = 1:n1;
    plot( bins,calc1, 'r', 'LineWidth', 2);
    legend('Experimental');
    
    subplot(2,2,2);
    bins = 1:n2;
    plot( bins, calc2,'b', 'LineWidth', 2);
    legend('Experimental');
    
    subplot(2, 2, 3);
    x = 1:n1;     
    pdf1 = (p1.^x).*(1-p1).^(n1-x).*factorial(n1)./(factorial(x).*factorial(n1-x));
    h = plot(x,pdf1,'ok');
    set(h,'MarkerFaceColor','r')
    str = sprintf('Binomial Distribution: p=%f\n n=%f',p1,n1);
    title(str);
    legend('Analytical');
    
    subplot(2, 2, 4);
    x = 1:n2;        
    pdf2 = (p2.^x).*(1-p2).^(n2-x).*factorial(n2)./(factorial(x).*factorial(n2-x));
    h = plot(x,pdf2,'ok');
    set(h,'MarkerFaceColor','b')
    str = sprintf('Binomial Distribution: p=%f\n n=%f',p2,n2);
    title(str);
    legend('Analytical');
       
end
