function PL=PL_free(fc,d,Gt,Gr)
% Free space Path Loss Model
% inputs
% d: distance between base station and mobile station [m]
% Gt/Gr: Transmitter/Receiver gain

% output
% PL : Path loss[dB]

lamda=3e8/fc;
tmp=lamda./(4*pi*d);

if nargin>2
    tmp=tmp*sqrt(Gt)
end

if nargin>3
    tmp=tmp*sqrt(Gr)
end

PL=-20*log10(tmp);

% nargin > 2는 최소 3개 이상의 입력 인자가 있음을 의미하며,
% 따라서 송신 안테나 이득 (Gt) 값이 제공되었음을 알려줍니다.

%nargin > 3 는 정확히 4개의 입력 인자가 있음을 의미하며,
% 송신 안테나 이득 (Gt)과 수신 안테나 이득 (Gr) 값이 모두 제공되었음을 알려줍니다.
