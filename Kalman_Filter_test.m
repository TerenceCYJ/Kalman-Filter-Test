%%
%匀速直线运动，速度和位置的观测噪声方差均为10
v0=ones(1,100);
r1=normrnd(0,10^0.5,1,100);
v=v0+r1;
p0=(1:100);
r2=normrnd(0,10^0.5,1,100);
p=p0+r2;
Z=[p;v]; %观测值 
%%
X=[0; 1]; %状态  
P=[1 0; 0 1]; %状态协方差矩阵  
F=[1 1; 0 1]; %状态转移矩阵  
Q=[0.1, 0; 0 0.1]; %状态转移协方差矩阵  
H=[1 0;0 1]; %观测矩阵  
R=10; %观测噪声方差  
%%
%卡尔曼滤波过程
for i=1:100   
  X_ = F*X;  
  P_ = F*P*F'+Q;  
  M0=H*P_*H'+R;
  M1=P_*H';
  K = P_*H'./(H*P_*H'+R);   %主要是K和X 
  X = X_+K*(Z(:,i)-H*X_);  %滤波结果
  P = (eye(2)-K*H)*P_; 
  pfil(i)=X(1);%位置滤波结果
  vfil(i)=X(2);%速度滤波结果
end
%%
%图像绘制
t=1:100;
%位置
subplot(1,2,1)
pm=Z(1,:);
plot(t,pfil(t),'r',t,pm,'g',t,p0,'b');
legend('Filtering','Measurement','True value');
title('卡尔曼滤波位置结果');
%速度
subplot(1,2,2)
plot(t,vfil(t),'r',t,v,'g',t,v0,'b');
legend('Filtering','Measurement','True value');
title('卡尔曼滤波速度结果');