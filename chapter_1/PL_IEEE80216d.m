function PL=PL_IEEE80216d(fc,d,type,htx,hrx,corr_fact,mod)
% IEEE 802.16d model
% Inputs
% fc : Carrier frequency
% d : Distance between base and terminal
% type : selects ’A’, ’B’, or ’C’
% htx : Height of transmitter
% hrx : Height of receiver
% corr_fact : If shadowing exists, set to ’ATnT’ or ’Okumura’.
% Otherwise, ’NO’
% mod : set to ’mod’ to obtain modified IEEE 802.16d model
% Output
% PL : path loss[dB]
Mod='UNMOD';
if nargin>6
    Mod=upper(mod);
    sprintf('nargin>6')
end

if nargin==6 &&corr_fact(1)=='m'
    Mod='MOD';
    sprintf('nargin=6')
    sprintf('corr_fact(1)값 %d',corr_fact(1))
    corr_fact='NO';    
elseif nargin<6
    corr_fact='NO';
    if nargin==5  &&hrx(1)=='m'
        sprintf('nargin=5')
        Mod='MOD';
        hrx=2;
    elseif nargin<5
        hrx=2;
        if nargin==4  &&htx(1)=='m'
            Mod='MOD';
            htx=30;
        elseif nargin<4
            htx=30;

            if nargin==3  &&type(1)=='m'
                Mod='MOD';
               % type='A';
            elseif nargin<3
               % type='A'; 초기 코드값은 type = A로 고정되어 있기에, 입력값에 따라 결과값이 달라지도록
               % 주석 처리했고, plot_PL_IEEE80216d파일의 PLh은 correlation
               % coefficient for carrier frequency값이 type값이 A,B(k=2, PLh=-7.5489)일때는 동일하지만,
               % C값(k=2, PLh=-13.9794)은 다른 값임을 확인할 수 있다.
            end
        end
    end
end

% +) 2024.03.11 의견
% 저자는 20~47까지의 코드로 일단 nargin을 통해, 입력값의 갯수를 통해
% 설정되지 않은 값은 고정값으로 설정되도록 if문을 설정하였다.

% 그러기 위해서는 if nargin ==6만으로 가능한데, corr_fact(1)=='m'은 결과에 영향을 주지 않는 것으로
% 제거해도 성능에 큰 차이가 없다. 만일 나중에 분석했을 때, 혹은 공부했을 때 다른 의견이 생기면
% 추가 의견 남기도록 하겠다.

d0 = 100;
Type = upper(type);
if Type~='A'&& Type~='B'&&Type~='C'
    disp('Error: The selected type is not supported');
    return;
end

switch upper(corr_fact)
    case 'ATNT'
        PLf=6*log10(fc/2e9); % correlation coefficient for the carrier frequency[MHz]
        PLh=-10.8*log10(hrx/2) %해당 코드는 AT&T에 의해 측정된 correlation coefficient의 값으로, type A&B와 C는 다른 값임에도 해당 코드는 A를 기반으로 작성되어 있다.
        if type=='C' %따라서 68~70의 코드가 추가되어야 한다.
            PLh=-20*log10(hrx/2)            
        end
    case 'OKUMURA'
        PLf=6*log10(fc/2e9); 
    if hrx<=3
        PLh=-10*log10(hrx/3); 
    else PLh=-20*log10(hrx/3);
    end
    
    case 'NO'
        PLf=0; PLh=0;
end

if Type=='A'
    a=4.6; b=0.0075; c=12.6; % Eq.(1.3)
elseif Type=='B'
    a=4; b=0.0065; c=17.1;
else
    a=3.6; b=0.005; c=20;
end

lamda=3e8/fc; gamma=a-b*htx+c/htx; d0_pr=d0; % Eq.(1.12)

if Mod(1)=='M'
    d0_pr=d0*10^-((PLf+PLh)/(10*gamma)); % Eq.(1.17)
end

A = 20*log10(4*pi*d0_pr/lamda) + PLf + PLh;

for k=1:length(d)
    if d(k)>d0_pr
        PL(k) = A + 10*gamma*log10(d(k)/d0); % Eq.(1.18)
    else PL(k) = 20*log10(4*pi*d(k)/lamda);
    end
end
