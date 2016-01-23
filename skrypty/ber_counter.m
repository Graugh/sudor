function [ results ] = ber_counter(data,receivedSignal)

% jesli probek wyjsciowych jest wiecej niz wejscia
if length(receivedSignal) < length(data)
    receivedSignal = [0; receivedSignal];
end
if length(receivedSignal) > length(data)
    receivedSignal = receivedSignal(2:end);
end
% przesuwamy wejscie o 11 lub 10, bo tak
error_rate = comm.ErrorRate('ReceiveDelay',11);
errors = step(error_rate,data,receivedSignal);
if errors(1) > 0.5
    error_rate = comm.ErrorRate('ReceiveDelay',10);
    errors = step(error_rate,data,receivedSignal);
end
results = errors(1);

end

