function [Y,t,wr,mn,Tem] =test()
global N b p Lm
[Y,t,wr]=wsysRK4V(@F,[0 0 0 0 0],0,b,N);
Tem=3*p/2*Lm*(Y(:,2).*Y(:,3)-Y(:,4).*Y(:,1));
As=[1 0 1;-0.5 0.866 1;-0.5 -0.866 1];
[n,~]=size(Y);
mn=zeros(3,n);
for i=1:n
   mn(:,i)=As*[Y(i,1) Y(i,2) 0]';
end
end
