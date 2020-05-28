function [sampleVar1, variance1, sampleVar2, variance2] = poissondistribution(lambda1, lambda2)
   
    N = 1000;
    
    mu1 = lambda1;
    mu2 = lambda2;
    
    variance1 = lambda1;
    variance2 = lambda2;
    
    sampleMean1=0;
    sampleMean2=0;
    
    n1 = lambda1*2+20;
    n2 = lambda2*2+20;
    %Generating samples
    result1 = randomNumberGenerator(N);
    last = 0;
    for i = 1:n1
        now = (lambda1.^i)*exp(-lambda1)/factorial(i) + last;
        y=(result1<now & result1>=last);
        last = now;
        calc1(i) = sum(y)/N;
        sampleMean1= sampleMean1 + calc1(i)*i;
    end
    
    result2 = randomNumberGenerator(N);
    last = 0;
    for i = 1:n2
        now = (lambda2.^i)*exp(-lambda2)/factorial(i) + last;
        y=(result2<now & result2>=last);
        last = now;
        calc2(i) = sum(y)/N;
        sampleMean2= sampleMean2 + calc2(i)*i;
    end
    
    %Sample Variances
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
        
    
    % Draw random samples from uniform distribution in range 0 to 1:

    figure;
    
    subplot(2,1,1);
    a = 1:N; 
    p = result1;
    stem(a, p,'r');
    set(gca, 'xlim', [1 N]);
    str = sprintf('Mean of generated values= %f\nSample mean of experimental graph = %f\nMean of analytical graph = %f',mean(result1),sampleMean1,mu1);
    xlabel(str);
    
    str = sprintf('%d Random Values',N);
    title(str);
    
    subplot(2,1,2);
    a = 1:N; 
    p = result2;
    stem(a, p,'b');
    set(gca, 'xlim', [1 N]);
    str = sprintf('Mean of generated values= %f\nSample mean of experimental graph = %f\nMean of analytical graph = %f',mean(result2),sampleMean2,mu2);
    xlabel(str);
    %plot(result2, '--k');
    
    figure;
    
    % Calculate histogram with bin width 0.1:
    subplot(2,2,1);
    bins = 1:n1;
    plot( bins,calc1, 'r', 'LineWidth', 2);
    legend('Experimental');
    
    % Calculate histogram with bin width 0.1:
    subplot(2,2,2);
    bins = 1:n2;
    plot( bins,calc2, 'b', 'LineWidth', 2);
    legend('Experimental');
    
    % Compare with analytic pdf for lambda1
    subplot(2, 2, 3);
    %figure;
    for x1=1:n1
        c1(x1) = (lambda1.^x1)*exp(-lambda1)/factorial(x1);
    end
    x1=1:n1;
    h = plot(x1,c1,'ok');  % Plot the PDF using circles
    set(h,'MarkerFaceColor','r');
    str = sprintf('Poisson Distribution: Lambda= %d', lambda1);
    title(str);
    legend('Analytical');
    
    subplot(2, 2, 4);
    for x2=1:n2
        c2(x2) = (lambda2.^x2)*exp(-lambda2)/factorial(x2);
    end
    x2=1:n2;
    h = plot(x2,c2,'ok');  % Plot the PDF using circles
    set(h,'MarkerFaceColor','b');
    str = sprintf('Poisson Distribution: Lambda= %d',lambda2);
    title(str);
    legend('Analytical');   
    
end
