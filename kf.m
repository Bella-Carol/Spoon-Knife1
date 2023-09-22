clear
% close
%initialization
N=1:100;
Q=1;R=1;
w=normrnd(0,Q,100,1);
v=normrnd(0,R,100,1);
x(1)=normrnd(0,1);
A=1.001;
C=0.999;
for i=1:99
    x(i+1) = A * x(i) + w(i);
    y(i) = C * x(i) + v(i);
end
y(i+1) =  C * x(i+1) + v(i+1);
%y0,y1,...,yN
%init condition
P(1)=1;
X(1)=0;
s=0;
for i=1:99
    X(i+1) = A * X(i);
    P(i+1) = A*P(i)*A'+Q;
    Kk=P(i+1)*C'*inv(C*P(i+1)*C'+R);
    X(i+1)=X(i+1)+Kk*(y(i+1)-C*X(i+1));
    P(i+1)=P(i+1)-P(i+1)*C'*inv(C*P(i+1)*C'+R)*C*P(i+1);
    s=s+(x(i)-X(i))^2;
    p(i)=s/(i);
end
s=s+(x(i+1)-X(i+1))^2;
p(i+1)=s/(i+1);

plot(N,x,'b',N,X,'r',N,x-X,'*');
hold on
plot(N,P,'-',N,p,'-o');
grid on