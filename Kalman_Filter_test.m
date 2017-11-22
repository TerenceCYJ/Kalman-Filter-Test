%%
%����ֱ���˶����ٶȺ�λ�õĹ۲����������Ϊ10
v0=ones(1,100);
r1=normrnd(0,10^0.5,1,100);
v=v0+r1;
p0=(1:100);
r2=normrnd(0,10^0.5,1,100);
p=p0+r2;
Z=[p;v]; %�۲�ֵ 
%%
X=[0; 1]; %״̬  
P=[1 0; 0 1]; %״̬Э�������  
F=[1 1; 0 1]; %״̬ת�ƾ���  
Q=[0.1, 0; 0 0.1]; %״̬ת��Э�������  
H=[1 0;0 1]; %�۲����  
R=10; %�۲���������  
%%
%�������˲�����
for i=1:100   
  X_ = F*X;  
  P_ = F*P*F'+Q;  
  M0=H*P_*H'+R;
  M1=P_*H';
  K = P_*H'./(H*P_*H'+R);   %��Ҫ��K��X 
  X = X_+K*(Z(:,i)-H*X_);  %�˲����
  P = (eye(2)-K*H)*P_; 
  pfil(i)=X(1);%λ���˲����
  vfil(i)=X(2);%�ٶ��˲����
end
%%
%ͼ�����
t=1:100;
%λ��
subplot(1,2,1)
pm=Z(1,:);
plot(t,pfil(t),'r',t,pm,'g',t,p0,'b');
legend('Filtering','Measurement','True value');
title('�������˲�λ�ý��');
%�ٶ�
subplot(1,2,2)
plot(t,vfil(t),'r',t,v,'g',t,v0,'b');
legend('Filtering','Measurement','True value');
title('�������˲��ٶȽ��');