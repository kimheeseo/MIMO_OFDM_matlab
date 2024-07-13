function hh=channel_coeff(NT,NR,N,Rtx,Rrx,type)
% correlated Rayleigh MIMO channel coefficient
% Inputs:
% NT : number of transmitters
% NR : number of receivers
% N : length of channel matrix
% Rtx : correlation vector/matrix of Tx

% e.g.) [1 0.5], [1 0.5;0.5 1]
% Rrx : correlation vector/matrix of Rx
% type : correlation type: ’complex’ or ’field’

% Outputs:
% hh : NR x NT x N correlated channel

% uncorrelated Rayleigh fading channel, CN(1,0)
h=sqrt(1/2)*(randn(NT*NR,N)+j*randn(NT*NR,N));
if nargin
  hh=h;
  return;
end % Uncorrelated channel

if isvector(Rtx)
  Rtx=toeplitz(Rtx);
end % (3.43): R_MS

if isvector(Rrx)
  Rrx=toeplitz(Rrx);
end %(3.45) : R_BS

% Narrow band correlation coefficient
if strcmp(type,'complex')
  C =chol(kron(Rtx,Rrx))’; % Complex correlation (3.50)
else
  C =sqrtm(sqrt(kron(Rtx,Rrx))); % Power (field) correlation
end
% chol: 촐레스키 분해
% C: a non-singular matrix which can be decomposed into a symmetric mapping matrix(or correlation-shaping matrix)
% with the cholesky or square-root decomposition.

% Apply correlation to channel matrix
hh=zeros(NR,NT,N);
for i=1:N
  tmp=C*h(:,i);
  hh(:,:,i)=reshape(tmp,NR,NT);
end
