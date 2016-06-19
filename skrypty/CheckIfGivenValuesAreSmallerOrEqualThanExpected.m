function [ status ] = CheckIfGivenValuesAreSmallerOrEqualThanExpected(values, expectedValue)
    status = 1;
    for i=1:length(values) 
        if values(i) > expectedValue
            status = 0;
        end
    end
end

