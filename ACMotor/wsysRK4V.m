function [Y,t,wr]=wsysRK4V(FV,Y0,a,b,N)
h=(b-a)/N;
Y = zeros(N,5);
wr=zeros(3,N);
Y(1,:)=Y0;t(1)=a;
wr(:,1)=[0 0 0]';

for i=1:N
    t(i+1)=a+i*h;
   
    K1=feval(FV,t(i),Y(i,:));
    
    K2=feval(FV,t(i)+h/2,Y(i,:)+(h/2).*K1');
    K3=feval(FV,t(i)+h/2,Y(i,:)+(h/2).*K2');
    K4=feval(FV,t(i)+h,Y(i,:)+h.*K3');
    Y(i+1,:)=Y(i,:)+(h/6)*(K1+2*K2+2*K3+K4)';
     Ar=[cos(Y(i+1,5)*t(i+1)) -sin(Y(i+1,5)*t(i+1))  1;
         cos(Y(i+1,5)*t(i+1)-((2*pi)/3)) -sin(Y(i+1,5)*t(i+1)-((2*pi)/3))  1;
         cos(Y(i+1,5)*t(i+1)+((2*pi)/3)) -sin(Y(i+1,5)*t(i+1)+((2*pi)/3))  1];
    wr(:,i+1)=Ar*[Y(i+1,3) Y(i+1,4) 0]';
   
    
%     disp([K1' K2' K3' K4' Y(i+1,:)])
    %pause
 end