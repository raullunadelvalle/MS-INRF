
function s=wkernel(x,std)

    s=0;
    
    mu=0;
    std2=std;
    if length(x)>1
        s=sin(pi*x/std) .* exp(-((x-mu).^2)./(2*(std2^2)));
    else
        if abs(x)<std
            s=sin(pi*x/std) * exp(-((x-mu)^2)/(2*(std2^2))); 
        end
    end

end

