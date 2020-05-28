function [randNumber] = randomNumberGenerator(noOfRequiredNumbers)

    tic;
    last= toc;
    %Using runtime to generate pseudo random numbers. Generated numbers will be used in distributions.
    for i = 1:noOfRequiredNumbers
        randNumber(i) = mod(100*mod((-1^i)*toc*10000*i^3-last,0.11)/11,1);             
        last = randNumber(i);
    end
end
